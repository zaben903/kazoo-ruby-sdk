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

require 'kazoo_sdk/error'
require 'kazoo_sdk/version'

# Used for interacting with the Kazoo HTTP API
module KazooSDK
  # Support classes
  autoload :Client, 'kazoo_sdk/client'

  # Resources
  autoload :Resource, 'kazoo_sdk/resource'
  autoload :Account, 'kazoo_sdk/resources/account'
  autoload :CallRecording, 'kazoo_sdk/resources/call_recording'
  autoload :Conference, 'kazoo_sdk/resources/conference'
  autoload :Device, 'kazoo_sdk/resources/device'
  autoload :Directory, 'kazoo_sdk/resources/directory'
  autoload :Fax, 'kazoo_sdk/resources/fax'
  autoload :Group, 'kazoo_sdk/resources/group'
  autoload :Hotdesk, 'kazoo_sdk/resources/hotdesk'
  autoload :Media, 'kazoo_sdk/resources/media'
  autoload :Queue, 'kazoo_sdk/resources/queue'
  autoload :Schema, 'kazoo_sdk/resources/schema'
  autoload :Storage, 'kazoo_sdk/resources/storage'
  autoload :TemporalRule, 'kazoo_sdk/resources/temporal_rule'
  autoload :TemporalRuleSet, 'kazoo_sdk/resources/temporal_rule_set'
  autoload :User, 'kazoo_sdk/resources/user'
  autoload :Voicemail, 'kazoo_sdk/resources/voicemail'
end
