module.exports = {
	'force-app/**/lwc/**/*.js': 'import-sort --write',
	'force-app/**/*.{auradoc,cls,cmp,component,css,design,html,js,json,md,page,trigger,xml,yaml,yml}': 'prettier --write',
	'force-app/**/{aura,lwc}/**/*.js': 'eslint --fix',
	'force-app/**/lwc/**': 'npm run test:unit:silent -- --passWithNoTests',
	'force-app/**/*.{cls,trigger}': (filenames) => {
		const files = filenames.join(',');
		return `sfdx scanner:run --pmdconfig config/pmd-ruleset.xml --target "${files}" --engine pmd --format table --severity-threshold 3`;
	}
};
