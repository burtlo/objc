module Objc
  module Test

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

  end
end