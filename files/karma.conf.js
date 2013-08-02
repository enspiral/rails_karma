basePath = '../';

files = [
    JASMINE,
    JASMINE_ADAPTER,

    //libs
    'vendor/assets/javascripts/rails_karma/angular.js',
    'vendor/assets/javascripts/rails_karma/angular-*.js',

    //our app!
    'app/assets/angular/**',

    //and our tests
    //'vendor/assets/javascripts/rails_karma/angular-mocks.js',
    'karma/**/*',
];

browsers = 'PhantomJS'.split(' ')
singleRun = true;

preprocessors = {
    '**/*.coffee': 'coffee'
}