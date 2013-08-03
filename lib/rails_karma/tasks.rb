namespace :karma do
  desc 'Run karma tests'
  task :run do
    sh './node_modules/karma/bin/karma start config/karma.conf.js'
  end

  desc 'Install karma files'
  task :install do
    puts 'Generating Karma files'
    RailsKarma::Installer.karma
    RailsKarma::Installer.angular_files
    RailsKarma::Installer.karma_config
  end

  desc 'Uninstall karma files'
  task :uninstall do
    files = ['./config/karma.conf.js', './karma', './vendor/assets/javascripts/rails_karma']
    #FileUtils.rm 'package.json'
    puts 'Removing files...'

    files.each do |f|
      if File.exists? f
        puts f
        FileUtils.rm_rf f
      end
    end
  end
end

desc 'Alias for karma:run'
task :karma => 'karma:run'

module RailsKarma
  class Installer
    def self.karma
      unless File.exists?('package.json')
        puts './package.json'
        File.open('package.json', 'w') {|f| f.write '{}'}
      end
      unless File.open('package.json') {|f| f.read.include? 'karma'}
        puts 'installing karma'
        puts `npm install karma --save-dev`
      end
      unless File.open('.gitignore') {|f| f.read.include? 'node_modules'}
        puts 'adding node_modules to .gitignore'
        File.open('.gitignore', 'a') {|f| f.write "node_modules\n"}
      end
    end

    def self.angular_files
      vendor_dir = File.join('vendor', 'assets', 'javascripts', 'rails_karma')
      unless Dir.exists?(vendor_dir)
        puts vendor_dir
        Dir.mkdir vendor_dir
      end

      angular_glob = File.join(Gem.loaded_specs['angularjs-rails'].full_gem_path, 'vendor', 'assets', 'javascripts', '*.js')
      Dir.glob(angular_glob).each do |file|
        FileUtils.cp file, File.join(vendor_dir,File.basename(file))
      end
    end

    def self.karma_config
      config_source = File.join(Gem.loaded_specs['rails_karma'].full_gem_path, 'files', 'karma.conf.js')
      config_target = File.join(Rails.root, 'config', 'karma.conf.js')
      unless File.exists?(config_target)
        puts './config/karma.conf.js'
        FileUtils.cp_r config_source, config_target
      end
      unless Dir.exists?('karma')
        puts './karma'
        Dir.mkdir 'karma'
      end
    end
  end
end

