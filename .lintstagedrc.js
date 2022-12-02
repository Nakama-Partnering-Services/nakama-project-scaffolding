module.exports = {
	'**/lwc/**/*.js': 'import-sort --write',
	'**/*.{auradoc,cls,cmp,component,css,design,html,js,json,md,page,trigger,xml,yaml,yml},!**/experiences/**/*.json':
		'prettier --write',
	'**/*.{component,js,page}': 'eslint --fix',
	// '**/lwc/**': 'npm run test:unit:silent .',
	'**/{classes,trigger}/**/*.{cls,trigger}': (filenames) => {
		const files = filenames.join(',');
		return `sfdx scanner:run --pmdconfig config/pmd-ruleset.xml --target "${files}" --engine pmd --format table --severity-threshold 3`;
	}
};
