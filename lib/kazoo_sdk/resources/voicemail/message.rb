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
  class Voicemail
    class Message < Resource
      attr_reader :account_id
      attr_reader :voicemail_id

      def initialize(account_id:, voicemail_id: nil, **kwargs)
        @account_id = account_id
        @voicemail_id = voicemail_id
        super(**kwargs)
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/voicemail/#list-all-voicemail-messages-on-an-account
      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/voicemail/#fetch-all-messages-for-a-voicemail-box
      def list
        if voicemail_id
          get_request("/v2/accounts/#{account_id}/vmboxes/#{voicemail_id}/messages")
        else
          get_request("/v2/accounts/#{account_id}/vmboxes/messages")
        end
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/voicemail/#create-a-new-voicemail-message
      def create
        raise MissingAttributeError, 'voicemail_id must be defined' if voicemail_id.nil?

        put_request("/v2/accounts/#{account_id}/vmboxes/#{voicemail_id}/messages", attributes)
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/voicemail/#remove-all-or-a-list-of-messages-from-a-voicemail-box
      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/voicemail/#remove-a-message-from-the-voicemail-box
      def delete(id = nil)
        raise MissingAttributeError, 'voicemail_id must be defined' if voicemail_id.nil?

        if id
          delete_request("/v2/accounts/#{account_id}/vmboxes/#{voicemail_id}/messages/#{id}")
        else
          delete_request("/v2/accounts/#{account_id}/vmboxes/#{voicemail_id}/messages")
        end
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/voicemail/#remove-a-message-from-the-voicemail-box
      def get(id)
        raise MissingAttributeError, 'voicemail_id must be defined' if voicemail_id.nil?

        get_request("/v2/accounts/#{account_id}/vmboxes/#{voicemail_id}/messages/#{id}")
      end

      # https://docs.2600hz.com/supported/applications/crossbar/doc/voicemail/#change-a-list-of-messages
      # https://docs.2600hz.com/supported/applications/crossbar/doc/voicemail/#change-a-message
      def update(id = nil, attributes)
        raise MissingAttributeError, 'voicemail_id must be defined' if voicemail_id.nil?

        if id
          post_request("/v2/accounts/#{account_id}/vmboxes/#{voicemail_id}/messages/#{id}", body: attributes)
        else
          post_request("/v2/accounts/#{account_id}/vmboxes/#{voicemail_id}/messages", body: attributes)
        end
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/voicemail/#fetch-the-raw-audio-of-a-list-of-messages-as-a-zip-file
      def audio(id = nil, messages)
        raise MissingAttributeError, 'voicemail_id must be defined' if voicemail_id.nil?

        if id
          post_request("/v2/accounts/#{account_id}/vmboxes/#{voicemail_id}/messages/#{id}/raw",
                       body: { messages: messages },
                       headers: { accept: 'application/zip' })
        else
          post_request("/v2/accounts/#{account_id}/vmboxes/#{voicemail_id}/messages/raw",
                       body: { messages: messages },
                       headers: { accept: 'application/zip' })
        end
      end

      # @see https://docs.2600hz.com/supported/applications/crossbar/doc/voicemail/#add-a-new-voicemail-media-file-to-a-message
      def add_audio(id, content)
        raise MissingAttributeError, 'voicemail_id must be defined' if voicemail_id.nil?

        put_request("/v2/accounts/#{account_id}/vmboxes/#{voicemail_id}/messages/#{id}/raw",
                    body: content,
                    headers: { content_type: 'multipart/mixed' })
      end
    end
  end
end
