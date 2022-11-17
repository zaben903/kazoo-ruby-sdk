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
  class Group < Resource
    autoload :Page, 'kazoo_sdk/resources/group/page'
    autoload :Ring, 'kazoo_sdk/resources/group/ring'

    attr_reader :account_id

    def initialize(account_id:, **kwargs)
      @account_id = account_id
      super(**kwargs)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/groups/#fetch
    def list
      get_request("/v2/accounts/#{account_id}/groups")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/groups/#fetch-all-groups-containing-a-user
    def user_list(id)
      get_request("/v2/accounts/#{account_id}/users/#{id}/groups")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/groups/#create-a-group-for-a-given-account
    def create(attributes)
      put_request("/v2/accounts/#{account_id}/groups", body: attributes, skip_validation: true)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/groups/#remove-a-group
    def delete(id)
      delete_request("/v2/accounts/#{account_id}/groups/#{id}")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/groups/#get-a-group-for-a-given-account
    def get(id)
      get_request("/v2/accounts/#{account_id}/groups/#{id}")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/groups/#update-a-group-for-a-given-account
    def update(id, attributes)
      patch_request("/v2/accounts/#{account_id}/groups/#{id}", body: attributes)
    end
  end
end
