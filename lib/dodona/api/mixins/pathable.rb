# frozen_string_literal: true

module Dodona::API::Pathable
  def path
    raise NotImplementedError
  end

  def cd!(dodona_dir)
    Dir.chdir path(dodona_dir)
  end
end
