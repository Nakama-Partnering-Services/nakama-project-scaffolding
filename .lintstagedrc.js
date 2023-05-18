module.exports = {
	'sfdx-source/**/lwc/**/*.js': 'import-sort --write',
	'sfdx-source/**/*.{auradoc,cls,cmp,component,css,design,html,js,json,md,page,trigger,xml,yaml,yml}': 'prettier --write',
	'sfdx-source/**/{aura,lwc}/**': 'eslint --fix',
	// '**/lwc/**': 'npm run test:unit:silent .',
	'**/*.{cls,trigger}': (filenames) => {
		const files = filenames.join(',');
		return `sfdx scanner:run --pmdconfig config/pmd-ruleset.xml --target "${files}" --engine pmd --format table --severity-threshold 3`;
	}
};
