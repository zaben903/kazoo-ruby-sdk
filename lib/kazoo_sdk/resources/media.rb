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
  # Uploading media for custom music on hold, IVR prompts, or TTS (if a proper TTS engine is enabled).
  # @see https://docs.2600hz.com/supported/applications/crossbar/doc/media/
  class Media < Resource
    SCHEMA_NAME = 'media'

    attr_reader :account_id

    def initialize(account_id:, **kwargs)
      @account_id = account_id
      super(**kwargs)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/media/#fetch
    def list
      get_request("/v2/accounts/#{account_id}/media")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/media/#create-a-new-media-object-required-before-uploading-the-actual-media-data
    def create(attributes)
      put_request("/v2/accounts/#{account_id}/media", attributes)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/media/#remove-metadata
    def delete(id)
      delete_request("/v2/accounts/#{account_id}/media/#{id}")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/media/#update-metadata
    def update(id, attributes)
      patch_request("/v2/accounts/#{account_id}/media/#{id}", body: attributes)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/media/#list-all-prompts-and-the-number-of-translations-existing
    def prompts
      get_request("/v2/accounts/#{account_id}/media/prompts")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/media/#list-all-translations-of-a-given-prompt
    def translations(id)
      get_request("/v2/accounts/#{account_id}/media/prompts/#{id}")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/media/#list-languages-available
    def languages
      get_request("/v2/accounts/#{account_id}/media/languages")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/media/#list-media-files-with-specific-language
    def language_media(language)
      get_request("/v2/accounts/#{account_id}/media/languages/#{language}")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/media/#to-get-the-ids-of-the-media-docs-missing-a-language
    def media_missing_languages
      get_request("/v2/accounts/#{account_id}/media/languages/missing")
    end
  end
end
