module.exports = {
	'**/*.{auradoc,cls,cmp,component,css,design,html,js,json,md,page,trigger,xml,yaml,yml}': 'prettier --write',
	'core/**/lwc/**': 'yarn test:unit:silent -- --passWithNoTests',
	// Note: the following runs the code-analyzer on matching staged files for pmd, eslint and regex engines with recommended rules
	// Note: locally, we use severity-threshold 'Moderate' to catch more issues, but in pipeline jobs we use 'High' instead
	'core/**/*.{cls,cmp,component,css,design,html,js,json,page,trigger,xml}': (filenames) => {
		const targets = filenames.map((file) => `--target "${file}"`).join(' ');
		return `sf code-analyzer run ${targets} --rule-selector Recommended --config-file config/code-analyzer.yml --view table --severity-threshold Moderate`;
	},
	// Note: for flows, we continue using lightning-flow-scanner since it seems more poweful than code-analyzer and it seems it is no longer discontinued
	// Note: locally, we use --failon 'warning' to catch more issues, but in pipeline jobs we use 'error' instead
	'core/**/*.flow-meta.xml': (filenames) => {
		const files = filenames.join('" "');
		return `sf flow scan --files "${files}" --failon warning`;
	}
};
