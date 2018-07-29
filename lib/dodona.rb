# frozen_string_literal: true

require 'rubygems'
require 'byebug'
require 'spyke'
require 'yaml'
require 'json'
require 'pathname'
require 'tty/prompt'

module Dodona
end

# Load Dodona
require 'dodona/helper'
require 'dodona/configuration'
require 'dodona/json_parser'
require 'dodona/state'
require 'dodona/version'
require 'dodona/core'
require 'dodona/api'
require 'dodona/cli'
