basePath = '../';

files = [
  JASMINE,
  JASMINE_ADAPTER,

  //libs
  'vendor/assets/javascripts/rails_karma/angular.js',
  'vendor/assets/javascripts/rails_karma/angular-cookies.js',
  'vendor/assets/javascripts/rails_karma/angular-loader.js',
  'vendor/assets/javascripts/rails_karma/angular-resource.js',
  'vendor/assets/javascripts/rails_karma/angular-sanitize.js',
  'vendor/assets/javascripts/rails_karma/angular-mocks.js',

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