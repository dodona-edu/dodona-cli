# frozen_string_literal: true

require_relative 'lib/dodona/version'

Gem::Specification.new do |s|
  s.name        = 'dodona-cli'
  s.version     = Dodona::VERSION
  s.homepage    = 'https://dodona.ugent.be/'
  s.summary     = 'A cli client for Dodona.'
  s.description = 'A command-line interface for the dodona.ugent.be application. Dodona is a web application to evaluate programming exercises, developed by Ghent University.'

  s.author  = 'Rien Maertens'
  s.email   = 'rien.maertens@ugent.be'

  s.files              = Dir['*.md']+ Dir['bin/*'] + Dir['lib/**/*.rb']
  s.executables        = ['dodona']
  s.require_paths      = ['lib']

  s.has_rdoc = false
end
