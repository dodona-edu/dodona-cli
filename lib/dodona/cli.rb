# frozen_string_literal: true

require 'cri'

module Dodona::CLI
  module Commands
  end
end

require 'dodona/api'

require_relative 'cli/subcommand'
require_relative 'cli/api_subcommand'
require_relative 'cli/command'
require_relative 'cli/config'
require_relative 'cli/courses'
require_relative 'cli/debug'
require_relative 'cli/exercises'
require_relative 'cli/last'
require_relative 'cli/list'
require_relative 'cli/status'
require_relative 'cli/submissions'
require_relative 'cli/submit'

module Dodona::CLI
  def self.run(args)
    Dodona::CLI::Command.new.run(args)
  end
end
