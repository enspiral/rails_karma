basePath = '../';

files = [
  JASMINE,
  JASMINE_ADAPTER,

  //angular
  'vendor/assets/javascripts/rails_karma/angular.js',
  'vendor/assets/javascripts/rails_karma/*.js',

   //angular rails resource
  'vendor/assets/javascripts/rails_karma/angularjs-rails-resource/**',

  //our app!
  'app/assets/angular/**',

  //and our tests
  'karma/**/*',
];

browsers = 'PhantomJS'.split(' ')
singleRun = true;

preprocessors = {
    '**/*.coffee': 'coffee'
}