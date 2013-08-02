basePath = '../';

files = [
    JASMINE,
    JASMINE_ADAPTER,

    //libs
    'vendor/assets/javascripts/angular/angular.js',
    'vendor/assets/javascripts/angular/angular-*.js',

    //angularjs-rails-resource files, need to manually keep up to date
    'vendor/assets/javascripts/angularjs/**/*.js',

    //our app!
    'app/assets/angular/**',

    // and our tests
    'karma/lib/angular/angular-mocks.js',
    'karma/**/*.coffee',
];

browsers = 'PhantomJS'.split(' ')
singleRun = true;

preprocessors = {
    '**/*.coffee': 'coffee'
}