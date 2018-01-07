# frozen_string_literal: true

module Dodona::CLI
  class Subcommand < Cri::CommandRunner
    def state
      state = Dodona::State.instance
      state.configure options unless state.configured?
      state
    end

    def config
      state.config
    end

    def argument_count_max!(max)
      abort @command.help unless @arguments.count <= max
    end

    def argument_count_min!(min)
      abort @command.help unless min <= @arguments.count
    end

    def argument_count_between!(min, max)
      abort @command.help unless @arguments.count.between? min, max
    end

    def argument_count_exact!(count)
      abort @command.help unless @arguments.count == count
    end

    def self.subcommand_of(_cmd)
      raise NotImplementedError, 'Subclasses must implement self#subcommand_of'
    end
  end
end
