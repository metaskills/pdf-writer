#--
# PDF::Writer for Ruby.
#   http://rubyforge.org/projects/ruby-pdf/
#   Copyright 2003 - 2005 Austin Ziegler.
#
#   Licensed under a MIT-style licence. See LICENCE in the main distribution
#   for full licensing information.
#
# $Id$
#++

spec = Gem::Specification.new do |s|
  s.name              = 'pdf-writer'
  s.version           = '1.1.4'
  s.summary           = %q(A pure Ruby PDF document creation library.)
  s.platform          = Gem::Platform::RUBY

  s.has_rdoc          = true
  s.rdoc_options      = %w(--title PDF::Writer --main README --line-numbers)
  s.extra_rdoc_files  = %w(README ChangeLog LICENCE)

  files   = %w(README LICENCE ChangeLog bin/**/* lib/**/* demo/**/*
             images/**/* demo/**/* manual.pwd)
  s.files = FileList[*files]

  s.autorequire       = %(pdf/writer)
  s.require_paths     = %w(lib)

  s.bindir            = %{bin}
  s.executables       = %w(techbook)

  s.author            = %q(Austin Ziegler)
  s.email             = %q(austin@rubyforge.org)
  s.rubyforge_project = %q(ruby-pdf)
  s.homepage          = %q(http://rubyforge.org/projects/ruby-pdf)
  description         = []
  File.open("README") do |file|
    file.each do |line|
      line.chomp!
      break if line.empty?
      description << "#{line.gsub(/\[\d\]/, '')}"
    end
  end
  s.description = description[1..-1].join(" ")

  s.add_dependency('color', '>= 1.4.0')
  s.add_dependency('transaction-simple', '~> 1.3')
end
