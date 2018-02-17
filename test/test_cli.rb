# frozen_string_literal: true

require 'helper'
require 'dodona/cli'

class TestDodonaCli < MiniTest::Test
  def test_default
    Dodona::CLI.run([])
  end
end
