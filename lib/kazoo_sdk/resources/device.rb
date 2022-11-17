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
  # Devices are the endpoints assigned to an account that serve that account's needs. Devices like fax machines, SIP phones, soft phone clients, and cell phones (via call forwarding), among others, can be represented by Kazoo devices.
  # @see https://docs.2600hz.com/supported/applications/crossbar/doc/devices/
  class Device < Resource
    SCHEMA_NAME = 'devices'

    attr_reader :account_id

    def initialize(account_id:, **kwargs)
      @account_id = account_id
      super(**kwargs)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/devices/#fetch
    def list
      get_request("/v2/accounts/#{account_id}/devices")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/devices/#create-a-new-device
    def create(attributes)
      put_request("/v2/accounts/#{account_id}/devices", body: attributes)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/devices/#remove-a-device
    def delete(id)
      delete_request("/v2/accounts/#{account_id}/devices/#{id}")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/devices/#fetch-a-device
    def get(id)
      get_request("/v2/accounts/#{account_id}/devices/#{id}")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/devices/#patch-a-device
    def update(id, attributes)
      patch_request("/v2/accounts/#{account_id}/devices/#{id}", body: attributes)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/devices/#send-a-sip-notify-to-a-device
    def sip_notify(event)
      put_request("/v2/accounts/#{account_id}/devices/#{id}/notify",
                  body: { action: 'notify', data: { event: event } }, skip_validation: true)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/devices/#fetch-registration-statuses-of-all-devices
    def status
      get_request("/v2/accounts/#{account_id}/devices/status")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/devices/#reboot-a-device
    def sync(id)
      post_request("/v2/accounts/#{account_id}/devices/#{id}/sync", skip_validation: true)
    end
  end
end