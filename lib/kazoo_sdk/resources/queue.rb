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
  # When you have more callers than agents to handle those calls, you can create a call queue to put the callers on hold while agents process callers in the order they arrived in.
  # @see https://docs.2600hz.com/supported/applications/crossbar/doc/queues/
  class Queue < Resource
    SCHEMA_NAME = 'queues'

    attr_reader :account_id

    def initialize(account_id:, **kwargs)
      @account_id = account_id
      super(**kwargs)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/queues/#fetch
    def list
      get_request("/v2/accounts/#{account_id}/queues")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/queues/#create-a-queue
    def create(attributes)
      put_request("/v2/accounts/#{account_id}/queues", body: attributes)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/queues/#remove-a-queue
    def delete(id)
      delete_request("/v2/accounts/#{account_id}/queues/#{id}")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/queues/#details-of-a-specific-queue
    def get(id)
      get_request("/v2/accounts/#{account_id}/queues/#{id}")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/queues/#update-a-queues-properties
    def update(id, attributes)
      patch_request("/v2/accounts/#{account_id}/queues/#{id}", body: attributes)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/queues/#list-queues-stats
    def stats
      get_request("/v2/accounts/#{account_id}/queues/stats")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/queues/#clear-a-queues-roster
    def clear_roster(id)
      delete_request("/v2/accounts/#{account_id}/queues/#{id}/roster")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/queues/#list-queue-roster-which-agents-are-assigned-to-the-queue
    def list_roster(id)
      get_request("/v2/accounts/#{account_id}/queues/#{id}/roster")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/queues/#set-the-queue-roster
    def set_roster(id, attributes)
      put_request("/v2/accounts/#{account_id}/queues/#{id}/roster", body: attributes)
    end
  end
end
