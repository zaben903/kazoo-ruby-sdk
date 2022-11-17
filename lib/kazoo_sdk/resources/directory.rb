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
  # Directories provide the ability to route a caller to a user by having the caller enter DTMF corresponding to the directory users' first or last names (versus having to know the user's extension).
  # @see https://docs.2600hz.com/supported/applications/crossbar/doc/directories/
  class Directory < Resource
    SCHEMA_NAME = 'directories'

    attr_reader :account_id

    def initialize(account_id:, **kwargs)
      @account_id = account_id
      super(**kwargs)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/directories/#fetch
    def list
      get_request("/v2/accounts/#{account_id}/directories")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/directories/#remove-a-directory
    def delete(id)
      delete_request("/v2/accounts/#{account_id}/directories/#{id}")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/directories/#fetch-a-directory-listing
    def get(id)
      get_request("/v2/accounts/#{account_id}/directories/#{id}")
    end

    def create(attributes)
      put_request("/v2/accounts/#{account_id}/directories", body: attributes)
    end

    def update(id, attributes)
      patch_request("/v2/accounts/#{account_id}/directories/#{id}", body: attributes)
    end
  end
end
