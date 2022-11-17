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
  class Fax
    # Managing past inbound faxes
    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/faxes/#managing-past-inbound-faxes
    class Inbox < Resource
      attr_reader :account_id

      def initialize(account_id:, **kwargs)
        @account_id = account_id
        super(**kwargs)
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/faxes/#fetch-all-faxes-in-the-inbox-folder
      def list
        get_request("/v2/accounts/#{account_id}/faxes/inbox")
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/faxes/#fetch-a-fax-from-the-inbox-folder
      def get(id)
        get_request("/v2/accounts/#{account_id}/faxes/inbox/#{id}")
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/faxes/#remove-a-fax-from-the-inbox-folder
      def delete(id)
        delete_request("/v2/accounts/#{account_id}/faxes/inbox/#{id}")
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/faxes/#fetch-the-fax-payload_1
      def payload(id)
        get_request("/v2/accounts/#{account_id}/faxes/inbox/#{id}/attachment")
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/faxes/#remove-the-fax-payload_1
      def delete_payload(id)
        delete_request("/v2/accounts/#{account_id}/faxes/inbox/#{id}/attachment")
      end
    end
  end
end
