module.exports = {
	'**/*.{auradoc,cls,cmp,component,css,design,html,js,json,md,page,trigger,xml,yaml,yml}': 'prettier --write',
	'core/**/{aura,lwc}/**/*.js': 'eslint --fix',
	'core/**/lwc/**': 'yarn test:unit:silent -- --passWithNoTests',
	'core/**/*.{cls,trigger}': (filenames) => {
		const files = filenames.join(',');
		return `sf scanner run --pmdconfig config/pmd-ruleset.xml --target "${files}" --engine pmd --format table --severity-threshold 2`;
	},
	'core/**/*.flow-meta.xml': (filenames) => {
		const files = filenames.join(',');
		return `sf flow scan -p "${files}"`;
	}
};
