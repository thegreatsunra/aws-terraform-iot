# vue-webpack-seed

> Vue webpack seed with updated dependencies

Initted from the output of the [Vue Webpack template](https://github.com/vuejs-templates/webpack) with the following settings:

```
? Generate project in current directory? Yes
? Project name vue-webpack-seed
? Project description Vue webpack seed with updated dependencies
? Author Dane Petersen <thegreatsunra@gmail.com>
? Vue build standalone
? Install vue-router? Yes
? Use ESLint to lint your code? Yes
? Pick an ESLint preset Standard
? Setup unit tests with Karma + Mocha? Yes
? Setup e2e tests with Nightwatch? Yes
```

...and then with the following changes applied:

* Bump all front-end and back-end npm dependencies to latest versions
  * Webpack 3.0.0, etc.
* Replace Karma + Mocha with Jest for unit testing
* Replace Nightwatch, Selenium, PhantomJS with TestCafe for end-to-end testing
* Update Babel transpiling from stage-2 to stage-0

## Build Setup

``` bash
# install dependencies
npm install

# serve with hot reload at localhost:8080
npm run dev

# build for production with minification
npm run build

# build for production and view the bundle analyzer report
npm run build --report

# run unit tests
npm run unit

# run e2e tests
npm run e2e

# run all tests
npm test
```

For a detailed explanation on how things work, check out the [guide](http://vuejs-templates.github.io/webpack/) and [docs for vue-loader](http://vuejs.github.io/vue-loader).
