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
  class Storage
    class Plan < Resource
      SCHEMA_NAME = 'storage.plan'

      attr_reader :account_id

      def initialize(account_id: nil, **kwargs)
        @account_id = account_id
        super(**kwargs)
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/storage/#fetch_1
      def list
        if account_id
          get_request("/v2/accounts/#{account_id}/storage/plans")
        else
          get_request('/v2/storage/plans')
        end
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/storage/#create_1
      def create(attributes)
        if account_id
          put_request("/v2/accounts/#{account_id}/storage/plans", body: attributes)
        else
          put_request('/v2/storage/plans', body: attributes)
        end
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/storage/#fetch_2
      def get(id)
        if account_id
          get_request("/v2/accounts/#{account_id}/storage/plans/#{id}")
        else
          get_request("/v2/storage/plans/#{id}")
        end
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/storage/#patch_1
      def update(id, attributes)
        if account_id
          patch_request("/v2/accounts/#{account_id}/storage/plans/#{id}", body: attributes)
        else
          patch_request("/v2/storage/plans/#{id}", body: attributes)
        end
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/storage/#remove_1
      def delete(id)
        if account_id
          delete_request("/v2/accounts/#{account_id}/storage/plans/#{id}")
        else
          delete_request("/v2/storage/plans/#{id}")
        end
      end
    end
  end
end
