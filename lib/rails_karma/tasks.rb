namespace :karma do
  desc 'Run karma tests'
  task :run do
    sh './node_modules/karma/bin/karma start config/karma.conf.js'
  end

  desc 'Install karma files'
  task :install do
    puts 'Generating Karma files'
    RailsKarma::Installer.install_karma_lib
    RailsKarma::Installer.ignore_node_modules
    RailsKarma::Installer.make_vendor_dir
    RailsKarma::Installer.copy_angularjs_files
    RailsKarma::Installer.copy_angularjs_resource_files
    RailsKarma::Installer.copy_karma_config
    RailsKarma::Installer.create_karma_dir
    RailsKarma::Installer.copy_test_spec
  end

  desc 'Uninstall karma files'
  task :uninstall do
    files = ['./config/karma.conf.js', './karma', './vendor/assets/javascripts/rails_karma']
    #FileUtils.rm 'package.json'
    puts 'Removing files...'

    files.each do |f|
      if File.exists? f
        puts "rm -rf #{f}"
        FileUtils.rm_rf f
      end
    end
  end
end

desc 'Alias for karma:run'
task :karma => 'karma:run'

module RailsKarma
  class Installer
    def self.install_karma_lib
      unless File.exists?('package.json')
        puts './package.json'
        File.open('package.json', 'w') {|f| f.write '{}'}
      end
      unless File.open('package.json') {|f| f.read.include? 'karma'}
        puts 'installing karma'
        puts `npm install karma --save-dev`
      end
    end

    def self.ignore_node_modules
      unless File.open('.gitignore') {|f| f.read.include? 'node_modules'}
        puts 'adding node_modules to .gitignore'
        File.open('.gitignore', 'a') {|f| f.write "node_modules\n"}
      end
    end

    def self.vendor_dir
      File.join('vendor', 'assets', 'javascripts', 'rails_karma')
    end

    def self.rails_resource_dir
      File.join(vendor_dir, 'angularjs-rails-resource')
    end

    def self.make_vendor_dir
      unless Dir.exists?(vendor_dir)
        puts "mkdir #{vendor_dir}"
        Dir.mkdir vendor_dir
      end
      unless Dir.exists?(rails_resource_dir)
        puts "mkdir #{rails_resource_dir}"
        Dir.mkdir rails_resource_dir
      end
    end

    def self.copy_angularjs_files
      angular_files = ['angular.js', 'angular-cookies.js', 'angular-loader.js', 'angular-resource.js', 'angular-sanitize.js', 'angular-mocks.js']
      angular_files.each do |file_name|
        path = File.join(Gem.loaded_specs['angularjs-rails'].full_gem_path, 'vendor', 'assets', 'javascripts', file_name)
        FileUtils.cp path, File.join(vendor_dir,File.basename(path))
      end
    end

    def self.copy_angularjs_resource_files
      rails_resource_lib = File.join(Gem.loaded_specs['angularjs-rails-resource'].full_gem_path, 'vendor', 'assets', 'javascripts', 'angularjs', 'rails', 'resource')
      FileUtils.cp_r rails_resource_lib, rails_resource_dir
    end

    def self.copy_karma_config
      config_source = File.join(Gem.loaded_specs['rails_karma'].full_gem_path, 'files', 'karma.conf.js')
      config_target = File.join(Rails.root, 'config', 'karma.conf.js')
      unless File.exists?(config_target)
        puts './config/karma.conf.js'
        FileUtils.cp_r config_source, config_target
      end
    end

    def self.create_karma_dir
      unless Dir.exists?('karma')
        puts './karma'
        Dir.mkdir 'karma'
      end
    end

    def self.copy_test_spec
      test_spec = File.join(Gem.loaded_specs['rails_karma'].full_gem_path, 'files', 'karma_test.coffee')
      target = File.join(Rails.root, 'karma', 'karma_test.coffee')
      unless File.exists?(target)
        puts './karma/karma_test.coffee'
        FileUtils.cp test_spec, target
      end
    end
  end
end

