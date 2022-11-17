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

require 'faraday'
require 'faraday_middleware'
require 'json-schema'
require 'digest/sha1'

module KazooSDK
  class Client
    # @return [String] the Kazoo API URL
    attr_reader :base_url
    # @return [String] the account name when using username/password authentication
    attr_reader :account_name
    # @return [String] the Kazoo API username
    attr_reader :username
    # @return [String] the Kazoo API password
    attr_reader :password
    # @return [String] the Kazoo Account API Key
    attr_reader :api_key
    # @return [Symbol] adapter the HTTP adapter used for the requests
    attr_reader :adapter
    # @return [Hash] options for the Faraday connection
    attr_reader :options
    # @return [boolean] if the request body should be validated
    attr_reader :validate_request
    # @return [String] the account ID
    attr_reader :account_id

    def initialize(base_url:, account_name: nil, username: nil, password: nil, api_key: nil, adapter: Faraday.default_adapter, options: {}, validate_request: true)
      @base_url = base_url
      @account_name = account_name
      @username = username
      @password = password
      @api_key = api_key
      @adapter = adapter
      @options = options
      @validate_request = validate_request

      sign_in if !username.nil? && !password.nil?
    end

    # Setting up Faraday with JSON defaults and signing in
    # @return [Faraday::Connection]
    def connection
      @connection ||= Faraday.new(base_url, options) do |conn|
        conn.headers['X-Auth-Token'] = x_auth_token
        conn.request :json
        conn.response :json, content_type: 'application/json', parser_options: { symbolize_names: true }
        conn.adapter adapter
        conn.response(:logger, nil, { bodies: true, log_level: :debug }) if options[:debug]
      end
    end

    def account
      Account.new(client: self)
    end

    def schema
      Schema.new(client: self)
    end

    def storage
      Storage.new(client: self)
    end

    private

    # @return [String] x_auth_token authentication token generated by Kazoo when using username/password authentication
    attr_accessor :x_auth_token

    def sign_in
      connection = Faraday.new(base_url, options) do |conn|
        conn.request :json
        conn.response :json, content_type: 'application/json', parser_options: { symbolize_names: true }
        conn.adapter adapter
        conn.response(:logger, nil, { bodies: true, log_level: :debug }) if options[:debug]
      end

      response = connection.put('v2/user_auth',
                                data: {
                                  credentials: Digest::SHA1.hexdigest("#{username}:#{password}"),
                                  account_name: account_name,
                                  method: 'sha'
                                }).body

      if response[:status] == 'success'
        self.x_auth_token = response[:auth_token]
        @account_id = response[:data][:account_id]
        @capabilities = response[:data]
      else
        raise KazooSDK::AuthenticationError, response[:message]
      end
    end

    def get_capabilities
      return if @capabilities

      connection = Faraday.new(base_url, options) do |conn|
        conn.headers['X-Auth-Token'] = x_auth_token
        conn.request :json
        conn.response :json, content_type: 'application/json', parser_options: { symbolize_names: true }
        conn.adapter adapter
        conn.response(:logger, nil, { bodies: true, log_level: :debug }) if options[:debug]
      end

      response = connection.get("v2/user_auth/#{token}").body
      @account_id = response[:data][:account_id]
      @capabilities = response[:data]
    end
  end
end