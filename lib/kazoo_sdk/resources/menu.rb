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
  # Menus, IVRs, what ever you call them, allow you to create branches in the callflow based on the caller's input.
  # @see https://docs.2600hz.com/supported/applications/crossbar/doc/menus/
  class Menu < Resource
    SCHEMA_NAME = 'menus'

    attr_reader :account_id

    def initialize(account_id:, **kwargs)
      @account_id = account_id
      super(**kwargs)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/menus/#fetch
    def list
      get_request("/v2/accounts/#{account_id}/menus")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/menus/#create
    def create(attributes, children)
      response = put_request("/v2/accounts/#{account_id}/menus",
                             body: { data: attributes, children: children },
                             return_data: false)
      { data: response[:data], children: response[:children] }
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/menus/#remove
    def delete(id)
      delete_request("/v2/accounts/#{account_id}/menus/#{id}")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/menus/#fetch_1
    def get(id)
      response = get_request("/v2/accounts/#{account_id}/menus/#{id}", return_data: false)
      { data: response[:data], children: response[:children] }
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/menus/#patch
    def update(id, attributes, children)
      response =  patch_request("/v2/accounts/#{account_id}/menus/#{id}",
                                body: { data: attributes, children: children },
                                return_data: false)
      { data: response[:data], children: response[:children] }
    end
  end
end
