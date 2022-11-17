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
    # Managing past outbound faxes
    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/faxes/#managing-past-outbound-faxes
    class Outbox < Resource
      attr_reader :account_id

      def initialize(account_id:, **kwargs)
        @account_id = account_id
        super(**kwargs)
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/faxes/#managing-past-outbound-faxes
      def list
        get_request("/v2/accounts/#{account_id}/faxes/outbox")
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/faxes/#remove-a-fax-from-the-outbox-folder
      def delete(id)
        delete_request("/v2/accounts/#{account_id}/faxes/outbox/#{id}")
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/faxes/#fetch-a-fax-from-the-outbox-folder
      def get(id)
        get_request("/v2/accounts/#{account_id}/faxes/outbox/#{id}")
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/faxes/#resubmit-a-fax-from-the-outbox-folder
      def resend(id)
        post_request("/v2/accounts/#{account_id}/faxes/outbox/#{id}", body: { action: 'resubmit', data: {} })
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/faxes/#fetch-the-fax-payload
      def payload(id)
        get_request("/v2/accounts/#{account_id}/faxes/outbox/#{id}/attachment")
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/faxes/#remove-the-fax-payload
      def delete_payload(id)
        delete_request("/v2/accounts/#{account_id}/faxes/outbox/#{id}/attachment")
      end
    end
  end
end
