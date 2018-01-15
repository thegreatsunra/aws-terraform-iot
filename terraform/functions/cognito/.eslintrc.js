// http://eslint.org/docs/user-guide/configuring

module.exports = {
  root: true,
  parser: 'babel-eslint',
  parserOptions: {
    sourceType: 'module'
  },
  env: {
    node: true,
  },
  // https://github.com/feross/standard/blob/master/RULES.md#javascript-standard-style
  extends: [
    'standard',
    'eslint:recommended',
    'plugin:node/recommended',
  ],
  plugins: [
    'node'
  ],
  // add your custom rules here
  'rules': {
    'no-console': ['warn'],
    'node/no-missing-require': ['warn']
  }
}
