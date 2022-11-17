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
  # The Faxes API exposes lots of ways to send, receive, track and manage faxes.
  # @see https://docs.2600hz.com/supported/applications/crossbar/doc/faxes/
  class Fax < Resource
    autoload :Inbox, 'kazoo_sdk/resources/fax/inbox'
    autoload :Outbox, 'kazoo_sdk/resources/fax/outbox'
    autoload :Outgoing, 'kazoo_sdk/resources/fax/outgoing'
    autoload :SMTPLog, 'kazoo_sdk/resources/fax/smtplog'

    attr_reader :account_id

    def initialize(account_id:, **kwargs)
      @account_id = account_id
      super(**kwargs)
    end

    def inbox
      Inbox.new(client: client, account_id: account_id)
    end

    def outbox
      Outbox.new(client: client, account_id: account_id)
    end

    def outgoing
      Outgoing.new(client: client, account_id: account_id)
    end

    def smtplog
      SMTPLog.new(client: client, account_id: account_id)
    end
  end
end
