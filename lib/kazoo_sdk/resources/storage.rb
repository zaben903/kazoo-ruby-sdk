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
  # Storage plans allow an account to control where data related to their account is stored.
  # @see https://docs.2600hz.com/supported/applications/crossbar/doc/storage/
  class Storage < Resource
    autoload :Plan, 'kazoo_sdk/resources/storage/plan'

    SCHEMA_NAME = 'storage'

    attr_reader :account_id

    def initialize(account_id: nil, **kwargs)
      @account_id = account_id
      super(**kwargs)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/storage/#fetch
    def get
      if account_id
        get_request("/v2/accounts/#{account_id}/storage")
      else
        get_request('/v2/storage')
      end
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/storage/#create
    def create(attributes)
      if account_id
        put_request("/v2/accounts/#{account_id}/storage", body: attributes)
      else
        put_request('/v2/storage', body: attributes)
      end
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/storage/#patch
    def update(attributes)
      if account_id
        patch_request("/v2/accounts/#{account_id}/storage", body: attributes)
      else
        patch_request('/v2/storage', body: attributes)
      end
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/storage/#remove
    def delete
      if account_id
        delete_request("/v2/accounts/#{account_id}/storage")
      else
        delete_request('/v2/storage')
      end
    end

    def plan
      Storage::Plan.new(client: client, account_id: account_id)
    end
  end
end
