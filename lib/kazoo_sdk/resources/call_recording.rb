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
  # Recordings endpoint provides a way to access call recordings.
  # @see https://docs.2600hz.com/supported/applications/crossbar/doc/recordings/
  class CallRecording < Resource
    attr_reader :account_id

    def initialize(account_id:, **kwargs)
      @account_id = account_id
      super(**kwargs)
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/recordings/#fetch-recordings
    def list
      get_request("/v2/accounts/#{account_id}/recordings")
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/recordings/#fetch-recording-media-or-document
    def audio(id)
      get_request("/v2/accounts/#{account_id}/recordings/#{id}", headers: { accept: 'audio/mpeg' })
    end

    # @see https://docs.2600hz.com/supported/applications/crossbar/doc/recordings/#remove-a-recording
    def delete(id)
      delete_request("/v2/accounts/#{account_id}/recordings/#{id}")
    end
  end
end
