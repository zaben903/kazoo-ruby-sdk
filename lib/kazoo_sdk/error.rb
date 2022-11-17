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
  # Generic KazooSDK error
  class Error < StandardError; end

  # API authentication error
  class AuthenticationError < Error; end

  # Missing required attribute error
  class MissingAttributeError < Error; end

  # Crossbar specific errors
  module Crossbar
    # Generic Crossbar error
    class Error < KazooSDK::Error; end

    # Bad identifier error
    class BadIdentifierError < Error; end

    # Invalid bulk type error
    class InvalidBulkTypeError < Error; end

    # Forbidden error
    class ForbiddenError < Error; end

    # Invalid method error
    class InvalidMethodError < Error; end
  end
end
