module.exports = {
	'**/lwc/**/*.js': 'import-sort --write',
	'**/*.{auradoc,cls,cmp,component,css,design,html,js,json,md,page,trigger,xml,yaml,yml}': 'prettier --write',
	'**/*.{cmp,component,css,html,js,page}': 'eslint --fix',
	'**/lwc/**': 'npm run test:unit:silent .',
	'**/{classes,trigger}/**/*.{cls,trigger}': (filenames) => {
		const files = filenames.join(',');
		return `sf scanner run --pmdconfig sonar/ruleset.xml --target "${files}" --engine pmd --format table --severity-threshold 3`;
	}
};
