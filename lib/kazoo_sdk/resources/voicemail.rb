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
  # Voicemail boxes store messages, recorded from the caller, for the voicemail box owner to listen to at a later time.
  # @see https://docs.2600hz.com/supported/applications/crossbar/doc/voicemail/
  class Voicemail < Resource
    autoload :Message, 'kazoo_sdk/resources/voicemail/message'

    SCHEMA_NAME = 'callflows.voicemail'

    attr_reader :account_id

    def initialize(account_id:, **kwargs)
      @account_id = account_id
      super(**kwargs)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/voicemail/#fetch
    def list
      get_request("/v2/accounts/#{account_id}/vmboxes")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/voicemail/#create-a-new-voicemail-box
    def create(attributes)
      put_request("/v2/accounts/#{account_id}/vmboxes", attributes)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/voicemail/#remove-a-voicemail-box
    def delete(id)
      delete_request("/v2/accounts/#{account_id}/vmboxes/#{id}")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/voicemail/#remove-a-voicemail-box
    def get(id)
      get_request("/v2/accounts/#{account_id}/vmboxes/#{id}")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/voicemail/#patch-a-voicemail-box
    def update(id, attributes)
      patch_request("/v2/accounts/#{account_id}/vmboxes/#{id}", body: attributes)
    end

    def message(id = nil)
      Message.new(account_id: account_id, voicemail_id: id)
    end
  end
end
