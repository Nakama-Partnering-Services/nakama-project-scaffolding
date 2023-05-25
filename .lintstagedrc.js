module.exports = {
	'sfdx-source/**/lwc/**/*.js': 'import-sort --write',
	'sfdx-source/**/*.{auradoc,cls,cmp,component,css,design,html,js,json,md,page,trigger,xml,yaml,yml}': 'prettier --write',
	'sfdx-source/**/{aura,lwc}/**/*.js': 'eslint --fix',
	'sfdx-source/**/lwc/**': 'npm run test:unit:silent -- --passWithNoTests',
	'sfdx-source/**/*.{cls,trigger}': (filenames) => {
		const files = filenames.join(',');
		return `sfdx scanner:run --pmdconfig config/pmd-ruleset.xml --target "${files}" --engine pmd --format table --severity-threshold 3`;
	}
};
