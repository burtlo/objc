module Objc
  module Test
    class XcodeProject
      attr_reader :runner

      def initialize(runner)
        @runner = runner
      end

      def install!
        clean
        extract
      end


      def add(files)
        project = Xcode.project(project_path)

        puts "Loading files into #{project} at #{project_path}"

        target = project.target(target_name)
        test_group = project.group(group_name)

        source_files_in_project = files.data.map do |path_data|
          test_group.create_file path_data
        end

        files_required_to_be_built = source_files_in_project.reject do |file|
          file.name.end_with?("h")
        end

        target.sources_build_phase do
          files_required_to_be_built.each do |source_file|
            add_build_file source_file
          end
        end

        project.save!
      end


      def execute!
        pid = spawn xctool_command
        Process.wait
      end


      private

      def clean
        `rm -rf #{project_root}`
      end

      def extract
        `tar -xvf #{project_template_tar_file} -C #{temp_path} > /dev/null 2>&1`
      end

      def temp_path
        @temp_path ||= Dir.tmpdir
      end

      def project_template_tar_file
        File.expand_path(File.join(__FILE__,"..","..","..","template","template-project.tar"))
      end

      def project_root
        File.expand_path(File.join(temp_path,"ExercismTestFixture"))
      end

      def project_path
        File.expand_path(File.join(project_root,"ExercismTestFixture.xcodeproj"))
      end

      def target_name
        'test-suite'
      end

      def group_name
        'test-suite'
      end

      def use_xcodebuild?
        runner == :xcodebuild
      end

      def xctool_command
        if use_xcodebuild?
          "xcodebuild -project #{project_path} -scheme IgnoreThisTarget test | xcpretty"
        else
          "xctool -project #{project_path} -scheme IgnoreThisTarget test"
        end
      end
    end
  end
end
