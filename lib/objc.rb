require "objc/version"
require 'xcoder'
require 'tmpdir'

module Objc
  module Test
    extend self

    class SourceFiles
      def initialize(prefix)
        @prefix = prefix
      end

      attr_reader :prefix

      def source_file
        "#{prefix}.m"
      end

      def source_file_path
        File.expand_path(source_file)
      end

      def header_file
        "#{prefix}.h"
      end

      def header_file_path
        File.expand_path(header_file)
      end

      def test_file
        "#{prefix}Test.m"
      end

      def test_file_path
        File.expand_path(test_file)
      end

      def data
        [ { 'name' => source_file, 'path' => source_file_path },
          { 'name' => header_file, 'path' => header_file_path },
          { 'name' => test_file, 'path' => test_file_path } ]
      end
    end

    class XcodeProject

      def install!
        extract
      end

      def extract
        `tar -xvf template/template-project.tar -C #{temp_path}`
      end

      def add(files)
        project = Xcode.project(project_path)
        puts project

        target = project.target(target_name)
        test_group = project.group(group_name)

        source_files_in_project = files.data.map do |path_data|
          test_group.create_file path_data
        end

        target.sources_build_phase do
          source_files_in_project.each do |source_file|
            add_build_file source_file
          end
        end

        project.save!
      end

      def execute!
        puts `xctool -project #{project_path} -scheme IgnoreThisTarget test`
      end

      private

      def project_template_tar_file
        File.expand_path(File.join(__FILE__,"..","..","template","template-project.tar"))
      end

      def temp_path
        @temp_path ||= Dir.tmpdir
      end

      def project_path
        File.expand_path(File.join(temp_path,"/ExercismTestFixture/ExercismTestFixture.xcodeproj"))
      end

      def target_name
        'test-suite'
      end

      def group_name
        'test-suite'
      end
    end

    def with(filePrefix)
      puts "Looking for all files with prefix: #{filePrefix}"

      files = SourceFiles.new(filePrefix)

      project = XcodeProject.new
      project.install!
      project.add(files)
      project.execute!
    end

  end
end
