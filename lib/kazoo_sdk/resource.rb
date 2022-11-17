# frozen_string_literal: true
# Copyright (C) 2022  Zach Bensley
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

module KazooSDK
  class Resource
    class << self
      # @return [Hash] json schema for the resource
      attr_accessor :schema_definition
      # @return [String] version of Kazoo when the schema was fetched
      attr_accessor :schema_version
    end

    # @return [KazooSDK::Client]
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def schema_definition
      raise Error, 'SCHEMA_NAME must be defined' unless defined?(self.class::SCHEMA_NAME)

      self.class.schema_definition ||= client.schema.get(self.class::SCHEMA_NAME)
    end

    private

    def get_request(path, params: {}, headers: nil, return_data: true)
      response = client.connection.get(path, params, headers).body
      handle_response(response, return_data: return_data)
    end

    def post_request(path, body: {}, headers: nil, skip_validation: false, return_data: true)
      validate!(body) if !skip_validation && client.validate_request

      body = prepare_body(body)
      response = client.connection.post(path, body, headers).body
      handle_response(response, return_data: return_data)
    end

    def put_request(path, body: {}, headers: nil, skip_validation: false, return_data: true)
      validate!(body) if !skip_validation && client.validate_request

      body = prepare_body(body)
      response = client.connection.put(path, body, headers).body
      handle_response(response, return_data: return_data)
    end

    def delete_request(path, headers: nil, return_data: true)
      response = client.connection.delete(path, nil, headers).body
      handle_response(response, return_data: return_data)
    end

    def patch_request(path, body: {}, headers: nil, skip_validation: false, return_data: true)
      validate!(body) if !skip_validation && client.validate_request

      body = prepare_body(body)
      response = client.connection.patch(path, body, headers).body
      handle_response(response, return_data: return_data)
    end

    # Prepare the body for a request if api_key is used
    def prepare_body(body)
      if body.is_a? Hash
        if body[:data]
          body[:data][:api_key] = client.api_key unless client.api_key.nil?
        else
          body[:api_key] = client.api_key unless client.api_key.nil?
          body = { data: body }
        end
      else
        raise KazooSDK::Error, 'Body must be a Hash if using API Key authentication' unless client.api_key.nil?
      end

      body
    end

    def handle_response(response, return_data: true)
      self.class.schema_definition = nil if response[:version] != self.class.schema_version
      case response[:error]
      when '400'
        raise Crossbar::InvalidBulkTypeError, response.dig(:data, :message)
      when '403'
        raise Crossbar::ForbiddenError, response.dig(:data, :message)
      when '404'
        raise Crossbar::BadIdentifierError, response.dig(:data, :message)
      when '405'
        raise Crossbar::InvalidMethodError, response.dig(:data, :message)
      when '500'
        raise Crossbar::Error, response.dig(:data, :message)
      else
        raise Crossbar::Error, "#{response[:error]}: #{response.dig(:data, :message)}" if response[:status] == 'error'
      end

      return_data ? response[:data] : response
    end

    def validate!(body)
      JSON::Validator.validate!(schema_definition, body)
    end
  end
end
