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
  # Accounts are the container for most things in Kazoo. They typically represent an office, business, family, etc. Kazoo arranges accounts into a tree structure, where parent accounts can access their sub accounts but not their ancestor accounts.
  # @see https://docs.2600hz.com/supported/applications/crossbar/doc/accounts
  class Account < Resource
    SCHEMA_NAME = 'accounts'

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/accounts/#create-new-account
    def create(attributes)
      put_request('/v2/accounts', attributes)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/accounts/#remove-an-account
    def delete(id = client.account_id)
      delete_request("/v2/accounts/#{id}")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/accounts/#fetch-the-account-doc
    def get(id = client.account_id)
      get_request("/v2/accounts/#{id}")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/accounts/#patch-the-account-doc
    def update(id = client.account_id, attributes)
      patch_request("/v2/accounts/#{id}", body: attributes)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/accounts/#create-a-new-child-account
    def create_child(id = client.account_id, attributes)
      put_request("/v2/accounts/#{id}", body: attributes, skip_validation: true)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/accounts/#fetch-the-parent-account-ids
    def parent_ids(id = client.account_id)
      get_request("/v2/accounts/#{id}/parents")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/accounts/#fetch-an-accounts-ancestor-tree
    def ancestor_tree(id = client.account_id)
      get_request("/v2/accounts/#{id}/tree")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/accounts/#fetch-sibling-accounts
    def siblings(id = client.account_id)
      get_request("/v2/accounts/#{id}/siblings")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/accounts/#fetch-all-descendants-of-an-account
    def descendants(id = client.account_id)
      get_request("/v2/accounts/#{id}/descendants")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/accounts/#fetch-immediate-children-of-an-account
    def children(id = client.account_id)
      get_request("/v2/accounts/#{id}/children")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/accounts/#demote-a-reseller
    def demote_reseller(id = client.account_id)
      delete_request("/v2/accounts/#{id}/reseller")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/accounts/#promote-a-reseller
    def promote_reseller(id = client.account_id)
      put_request("/v2/accounts/#{id}/reseller")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/accounts/#move-an-account
    def move(id = client.account_id, attributes)
      put_request("/v2/accounts/#{id}/move", body: attributes, skip_validation: true)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/accounts/#fetch-the-accounts-api-key
    def api_key(id = client.account_id)
      get_request("/v2/accounts/#{id}/api_key")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/accounts/#re-create-the-accounts-api-key
    def reset_api_key(id = client.account_id)
      put_request("/v2/accounts/#{id}/api_key")
    end

    def call_recoring(id = client.account_id)
      CallRecording.new(client: client, account_id: id)
    end

    def conference(id = client.account_id)
      Conference.new(client: client, account_id: id)
    end

    def device(id = client.account_id)
      Device.new(client: client, account_id: id)
    end

    def directory(id = client.account_id)
      Directory.new(client: client, account_id: id)
    end

    def fax(id = client.account_id)
      Fax.new(client: client, account_id: id)
    end

    def hotdesk(id = client.account_id)
      Hotdesk.new(client: client, account_id: id)
    end

    def media(id = client.account_id)
      Media.new(client: client, account_id: id)
    end

    def menu(id = client.account_id)
      Menu.new(client: client, account_id: id)
    end

    def queue(id = client.account_id)
      Queue.new(client: client, account_id: id)
    end

    def page_group(id = client.account_id)
      Group::Page.new(client: client, account_id: id)
    end

    def ring_group(id = client.account_id)
      Group::Ring.new(client: client, account_id: id)
    end

    def storage(id = client.account_id)
      Storage.new(client: client, account_id: id)
    end

    def temporal_rule(id = client.account_id)
      TemporalRule.new(client: client, account_id: id)
    end

    def temporal_rule_set(id = client.account_id)
      TemporalRuleSet.new(client: client, account_id: id)
    end

    def user(id = client.account_id)
      User.new(client: client, account_id: id)
    end

    def voicemail(id = client.account_id)
      Voicemail.new(client: client, account_id: id)
    end
  end
end
