module.exports = {
	'**/*.{auradoc,cls,cmp,component,css,design,html,js,json,md,page,trigger,xml,yaml,yml}': 'prettier --write',
	'force-app/**/{aura,lwc}/**/*.js': 'eslint --fix',
	'force-app/**/lwc/**': 'yarn test:unit:silent -- --passWithNoTests',
	'force-app/**/*.{cls,trigger}': (filenames) => {
		const files = filenames.join(',');
		return `sf scanner run --pmdconfig config/pmd-ruleset.xml --target "${files}" --engine pmd --format table --severity-threshold 2`;
	},
	'force-app/**/*.flow-meta.xml': (filenames) => {
		const files = filenames.join(',');
		return `sf flow scan -p "${files}"`;
	}
};
