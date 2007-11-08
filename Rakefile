#! /usr/bin/env rake
#
#--
# PDF::Writer for Ruby.
#   http://rubyforge.org/projects/ruby-pdf/
#   Copyright 2003 - 2005 Austin Ziegler.
#   Licensed under a MIT-style licence. See LICENCE in the main distribution
#   for full licensing information.
#
# $Id$
#++
$LOAD_PATH.unshift('lib')

require 'meta_project'
require 'rake/gempackagetask'
require 'rake/contrib/xforge'
require 'rake/clean'

require 'gmailer'

require 'pdf/writer'
require 'pdf/techbook'

require 'archive/tar/minitar'
require 'zlib'

DISTDIR = "pdf-writer-#{PDF::Writer::VERSION}"
TARDIST = "../#{DISTDIR}.tar.gz"
DEMODIR = "pdf-writer-demo-#{PDF::Writer::VERSION}"
DEMOTAR = "../#{DEMODIR}.tar.gz"

DATE_RE = %r<(\d{4})[./-]?(\d{2})[./-]?(\d{2})(?:[\sT]?(\d{2})[:.]?(\d{2})[:.]?(\d{2})?)?>

if ENV['RELEASE_DATE']
  year, month, day, hour, minute, second = DATE_RE.match(ENV['RELEASE_DATE']).captures
  year ||= 0
  month ||= 0
  day ||= 0
  hour ||= 0
  minute ||= 0
  second ||= 0
  ReleaseDate = Time.mktime(year, month, day, hour, minute, second)
else
  ReleaseDate = nil
end

task :test do |t|
  require 'test/unit/testsuite'
  require 'test/unit/ui/console/testrunner'

  runner = Test::Unit::UI::Console::TestRunner

  $LOAD_PATH.unshift('tests')
  Dir['tests/tc_*.rb'].each do |testcase|
    load testcase
  end

  suite = Test::Unit::TestSuite.new("PDF::Writer")

  ObjectSpace.each_object(Class) do |testcase|
    suite << testcase.suite if testcase < Test::Unit::TestCase
  end

  runner.run(suite)
end                                      


mkdir_p "pkg"
spec = eval(File.read("pdf-writer.gemspec"))
spec.version = "1.1.4"
desc "Build the RubyGem for PDF::Writer"
task :gem => [ :test ]
Rake::GemPackageTask.new(spec) do |g|
  g.need_tar    = false
  g.need_zip    = false
  g.package_dir = "pkg"
end

desc "Look for TODO and FIXME tags in the code"
task :todo do
  rx = %r{#.*(FIXME|TODO|TBD|DEPRECATED)}
  Pathname.new(File.dirname(__FILE__)).egrep(rx) do |match|
    puts match
  end
end

desc "Build the PDF::Writer manual.pdf"
task :manual do
  begin
    PDF::TechBook.run %w(-z)
  rescue Exception => ex
    puts ex, $!, $?
  end
end

desc "Build a PDF::Writer demo distribution .tar.gz."
task :demotar => [ :manual, DEMOTAR ]
file DEMOTAR do |t|
  current = File.basename(Dir.pwd)
  Dir.chdir("..") do
    begin
      files = %W(manual.pwd manual.pdf demo/**/* Demo-README LICENCE images/**/*)
      files = FileList[files.map { |file| File.join(current, file) }].to_a
      files.map! do |dd|
        ddnew = dd.gsub(/^#{current}/, DEMODIR).gsub(%r{demo/}, '')
        ddnew.gsub!(/Demo-README/, 'README')
        mtime = ReleaseDate || File.stat(dd).mtime
        if File.directory?(dd)
          { :name => ddnew, :mode => 0755, :dir => true, :mtime => mtime }
        else
          if dd =~ %r{bin/}
            mode = 0755
          else
            mode = 0644
          end
          data = File.open(dd, "rb") { |ff| ff.read }
          data.gsub!(%r{../images/}, 'images/') if ddnew =~ /\.rb$/
          { :name => ddnew, :mode => mode, :data => data, :size => data.size,
            :mtime => mtime }
        end
      end

      ff = File.open(t.name.gsub(%r{^\.\./}o, ''), "wb")
      gz = Zlib::GzipWriter.new(ff)
      tw = Archive::Tar::Minitar::Writer.new(gz)

      files.each do |entry|
        if entry[:dir]
          tw.mkdir(entry[:name], entry)
        else
          tw.add_file_simple(entry[:name], entry) { |os| os.write(entry[:data]) }
        end
      end
    ensure
      tw.close if tw
      gz.close if gz
    end
  end
end

desc "Build a PDF::Writer .tar.gz distribution."
task :tar => [ TARDIST ]
file TARDIST => [ :test ] do |t|
  current = File.basename(Dir.pwd)
  Dir.chdir("..") do
    begin
      files = %W(bin/**/* lib/**/* demo/**/* images/**/* ChangeLog README
                 LICENCE setup.rb pre-setup.rb metaconfig manual.pwd)
      files = FileList[files.map { |file| File.join(current, file) }].to_a
      files.map! do |dd|
        ddnew = dd.gsub(/^#{current}/, DISTDIR)
        mtime = ReleaseDate || File.stat(dd).mtime
        if File.directory?(dd)
          { :name => ddnew, :mode => 0755, :dir => true, :mtime => mtime }
        else
          if dd =~ %r{bin/}
            mode = 0755
          else
            mode = 0644
          end
          data = File.open(dd, "rb") { |ff| ff.read }
          { :name => ddnew, :mode => mode, :data => data, :size => data.size,
            :mtime => mtime }
        end
      end

      ff = File.open(t.name.gsub(%r{^\.\./}o, ''), "wb")
      gz = Zlib::GzipWriter.new(ff)
      tw = Archive::Tar::Minitar::Writer.new(gz)

      files.each do |entry|
        if entry[:dir]
          tw.mkdir(entry[:name], entry)
        else
          tw.add_file_simple(entry[:name], entry) { |os| os.write(entry[:data]) }
        end
      end
    ensure
      tw.close if tw
      gz.close if gz
    end
  end
end
task TARDIST => [ :test ]

desc "Build the RDoc documentation for PDF::Writer"
task :docs do
  require 'rdoc/rdoc'
  rdoc_options = %w(--title PDF::Writer --main README --line-numbers)
  files = FileList[*%w(README LICENCE ChangeLog bin/**/*.rb lib/**/*.rb demo/**/*.rb)]
  rdoc_options += files.to_a
  RDoc::RDoc.new.document(rdoc_options)
end

task :verify_rubyforge do
  raise "RUBYFORGE_USER environment variable not set!" unless ENV['RUBYFORGE_USER']
  raise "RUBYFORGE_PASSWORD environment variable not set!" unless ENV['RUBYFORGE_PASSWORD']
end

task :verify_gmail do
  raise "GMAIL_USER environment variable not set!" unless ENV['GMAIL_USER']
  raise "GMAIL_PASSWORD environment variable not set!" unless ENV['GMAIL_PASSWORD']
end

Ruby_PDF    = MetaProject::Project::XForge::RubyForge.new('ruby-pdf')
PKG_VERSION = PDF::Writer::VERSION

desc "Release files on RubyForge."
task :release_files => [ :verify_rubyforge, :tar, :gem, :demotar ] do
  release_files = FileList[TARDIST, DEMOTAR, "../#{DISTDIR}.gem"]
  Rake::XForge::Release.new(Ruby_PDF) do |release|
    release.user_name       = ENV['RUBYFORGE_USER']
    release.password        = ENV['RUBYFORGE_PASSWORD']
    release.files           = release_files.to_a
    release.release_name    = "pdf-writer #{PDF::Writer::VERSION}"
    release.package_name    = "pdf-writer"

    notes = []
    File.open("README") do |file|
      file.each do |line|
        line.chomp!
        line.gsub!(/^#.*$/, '') and next
        notes << line
      end
    end
    release.release_notes   = notes.join("\n")

    changes = []
    File.open("ChangeLog") do |file|
      current = true

      file.each do |line|
        line.chomp!
        current = false if current and line =~ /^==/
        break if line.empty? and not current
        changes << line
      end
    end
    release.release_changes = changes.join("\n")
  end
end

desc "Publish news on RubyForge"
task :publish_news => [ :verify_rubyforge, :tar, :gem, :demotar] do
  Rake::XForge::NewsPublisher.new(Ruby_PDF) do |news|
    news.user_name    = ENV['RUBYFORGE_USER']
    news.password     = ENV['RUBYFORGE_PASSWORD']
    news.subject      = "PDF::Writer #{PDF::Writer::VERSION} Released"
    news.changes_file = nil

    details = []
    File.open("Release-Announcement") do |file|
      file.each do |line|
        line.chomp!
        break if line =~ /^=/
        details << line
      end
    end
    news.details      = details.join("\n")
  end
end

desc "Post a release announcement via GMail."
#task :email_announcement => [ :verify_gmail, :tar, :gem, :demotar] do
task :email_announcement => [ :verify_gmail ] do
  GMailer.connect(ENV["GMAIL_USER"], ENV["GMAIL_PASSWORD"]) do |gmail|
    gmail.send  :to       => "ruby-talk@ruby-lang.org",
                :subject  => "[ANN] PDF::Writer #{PDF::Writer::VERSION}",
                :body     => File.read("Release-Announcement")
  end
end

desc "Release the latest version."
task :release => [ :verify_rubyforge, :verify_gmail, :release_files,
  :publish_news, :email_announcement, :docs ]

desc "Build everything."
task :default => [ :tar, :gem, :demotar, :docs ]
