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
  # Users represent just that, your users of the system. You can assign multiple devices to a user, put the user in a callflow, and all devices will ring.
  # @see https://docs.2600hz.com/supported/applications/crossbar/doc/users/
  class User < Resource
    autoload :Photo, 'kazoo_sdk/resources/user/photo'

    SCHEMA_NAME = 'users'

    attr_reader :account_id

    def initialize(account_id:, **kwargs)
      @account_id = account_id
      super(**kwargs)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/users/#fetch
    def list
      get_request("/v2/accounts/#{account_id}/users")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/users/#create-a-new-user
    def create(attributes)
      put_request("/v2/accounts/#{account_id}/users", attributes)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/users/#remove-a-user
    def delete(id)
      delete_request("/v2/accounts/#{account_id}/users/#{id}")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/users/#fetch-a-user
    def get(id)
      get_request("/v2/accounts/#{account_id}/users/#{id}")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/users/#patch-a-users-doc
    def update(id, attributes)
      patch_request("/v2/accounts/#{account_id}/users/#{id}", body: attributes)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/users/#fetch-or-create-a-vcard
    def vcard(id)
      get_request("/v2/accounts/#{account_id}/users/#{id}/vcard", headers: { accept: 'text/x-vcard' })
    end

    def photo
      User::Photo.new(client: client, account_id: account_id, user_id: id)
    end
  end
end