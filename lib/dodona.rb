# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'byebug'

Bundler.require(:default)

module Dodona
end

# Load Dodona
require 'dodona/configuration'
require 'dodona/state'
require 'dodona/version'
require 'dodona/core'
require 'dodona/api'
require 'dodona/cli'
