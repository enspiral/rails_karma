namespace :karma do
  desc 'Run karma tests'
  task :run do
    sh './node_modules/karma/bin/karma start config/karma.conf.js'
  end

  desc 'Install karma files'
  task :install do
    sh 'echo "{}" > package.json' unless File.exists?('package.json')
    sh 'npm install karma --save-dev'
    unless File.exists?('karma')
      sh 'mkdir karma'
      sh 'mkdir karma/lib'
      sh 'mkdir karma/lib/angular'

      mocks_source = File.join(Gem.loaded_specs["rails_karma"].full_gem_path, 'files', 'angular-mocks.js')
      mocks_target = File.join(Rails.root, 'karma', 'lib', 'angular', 'angular-mocks.js')
      FileUtils.cp_r mocks_source, mocks_target
    end

    config_source = File.join(Gem.loaded_specs["rails_karma"].full_gem_path, 'files', 'karma.conf.js')
    config_target = File.join(Rails.root, 'config', 'karma.conf.js')
    FileUtils.cp_r config_source, config_target unless File.exists?(config_target)
  end
end

desc 'Alias for karma:run'
task :karma => "karma:run"
