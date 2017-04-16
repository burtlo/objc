require 'xcoder'
require 'tmpdir'

require "objc/version"
require 'objc/source_files'
require 'objc/xcode_project'

module Objc
  module Test
    extend self

    def with(filePrefix, runner: :xctool)
      puts "Looking for all files with prefix: #{filePrefix}"

      files = SourceFiles.new(filePrefix)

      project = XcodeProject.new(runner)
      project.install!
      project.add(files)
      project.execute!
    end

  end
end
