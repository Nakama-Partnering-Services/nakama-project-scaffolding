const { defineConfig, globalIgnores } = require('eslint/config');
const eslintJs = require('@eslint/js');
const jestPlugin = require('eslint-plugin-jest');
const auraPlugin = require('@salesforce/eslint-plugin-aura');
const lwcPlugin = require('@lwc/eslint-plugin-lwc-platform');
const lwcConfig = require('@salesforce/eslint-config-lwc/recommended');
const globals = require('globals');

module.exports = defineConfig([
	// Aura configuration (ES5 syntax with ES6 promises only)
	{
		extends: [...auraPlugin.configs.recommended, ...auraPlugin.configs.locker],
		files: ['**/aura/**/*.js'],
		rules: {
			'no-var': 'off'
		}
	},

	// LWC configuration
	{
		files: ['**/lwc/**/*.js'],
		extends: [lwcConfig, ...lwcPlugin.configs.recommended]
	},

	// LWC configuration with override for LWC test files
	{
		files: ['**/lwc/**/*.test.js'],
		extends: [lwcConfig, ...lwcPlugin.configs.recommended],
		rules: {
			'@lwc/lwc/no-unexpected-wire-adapter-usages': 'off'
		},
		languageOptions: {
			globals: {
				...globals.node
			}
		}
	},

	// Jest mocks configuration
	{
		files: ['**/jest-mocks/**/*.js'],
		languageOptions: {
			sourceType: 'module',
			ecmaVersion: 'latest',
			globals: {
				...globals.node,
				...globals.es2021,
				...jestPlugin.environments.globals.globals
			}
		},
		plugins: {
			eslintJs
		},
		extends: ['eslintJs/recommended']
	},

	globalIgnores(['frameworks/**', '**/staticresources/*.js'])
]);
