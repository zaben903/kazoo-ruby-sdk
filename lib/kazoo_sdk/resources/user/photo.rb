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
  class User
    class Photo < Resource
      attr_reader :account_id
      attr_reader :user_id

      def initialize(account_id:, user_id:, **kwargs)
        @account_id = account_id
        @user_id = user_id
        super(**kwargs)
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/users/#fetch-or-create-a-vcard
      def delete
        delete_request("/v2/accounts/#{account_id}/users/#{user_id}/photo")
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/users/#fetch-the-users-photo-if-any
      def get
        get_request("/v2/accounts/#{account_id}/users/#{user_id}/photo", headers: { accept: 'application/octet-stream' })
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/users/#create-or-change-the-users-photo
      def update(photo)
        post_request("/v2/accounts/#{account_id}/users/#{user_id}/photo", photo, headers: { content_type: 'application/octet-stream' })
      end
    end
  end
end