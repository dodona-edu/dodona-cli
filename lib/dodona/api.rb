# frozen_string_literal: true

module Dodona
  module Api
  end
end

require 'action_view/helpers'
require 'dotiw'
require 'pastel'
require 'json'

require_relative 'api/base'
require_relative 'api/course'
require_relative 'api/exercise'
require_relative 'api/series'
require_relative 'api/submission'
require_relative 'api/user'

module Dodona
  module API
    def current_user
      Base.current_user
    end

    def application_version
      Base.version
    end
  end
end
