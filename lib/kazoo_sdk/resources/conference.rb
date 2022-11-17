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
  # Conference documents are enriched with real-time information along side their configuration, namely showing the number of members, number of moderators, duration of the conference, conference locked status.
  # @see https://docs.2600hz.com/supported/applications/crossbar/doc/conference/
  class Conference < Resource
    SCHEMA_NAME = 'conferences'

    attr_reader :account_id

    def initialize(account_id:, **kwargs)
      @account_id = account_id
      super(**kwargs)
    end

    def list
      get_request("/v2/accounts/#{account_id}/conferences")
    end

    def create(attributes)
      put_request("/v2/accounts/#{account_id}/conferences", attributes)
    end

    def delete(id)
      delete_request("/v2/accounts/#{account_id}/conferences/#{id}")
    end

    def get(id)
      get_request("/v2/accounts/#{account_id}/conferences/#{id}")
    end

    def update(id, attributes)
      patch_request("/v2/accounts/#{account_id}/conferences/#{id}", body: attributes)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/conference/#perform-an-action-on-a-conference
    def action(id, action, attributes)
      put_request("/v2/accounts/#{account_id}/conferences/#{id}",
                  body: { action: action, body: attributes },
                  skip_validation: true)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/conference/#perform-an-action-on-participants
    def participant_action(id, action, attributes)
      put_request("/v2/accounts/#{account_id}/conferences/#{id}/participants",
                  body: { action: action, body: attributes },
                  skip_validation: true)
    end
  end
end
