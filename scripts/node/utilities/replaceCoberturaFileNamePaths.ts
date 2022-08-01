'use strict';

const { promisify } = require('util');
const glob = require('glob');
const globPromise = promisify(glob);

const fs = require('fs');

const { XMLParser, XMLBuilder } = require('fast-xml-parser');

(async () => {
	const allClasses = await globPromise('sfdx-source/**/*.{cls,trigger}');

	const cobertura = fs.readFileSync('test-results/coverage/cobertura.xml', 'UTF-8');
	const coberturaReplaced = cobertura.replaceAll('filename="no-map/', 'filename="');

	const output = new XMLParser({
		ignoreDeclaration: true,
		attributeNamePrefix: '@_',
		ignoreAttributes: false,
		ignoreNameSpace: false
	}).parse(coberturaReplaced);

	for (const cls of output.coverage.packages.package.classes.class) {
		const fileName = cls['@_filename'];
		const fullPath = allClasses.filter(
			(item) => item.endsWith(fileName + '.cls') || item.endsWith(fileName + '.trigger')
		)[0];

		cls['@_filename'] = fullPath;
	}

	const xmlContent = new XMLBuilder({
		format: true,
		ignoreDeclaration: true,
		attributeNamePrefix: '@_',
		ignoreAttributes: false,
		ignoreNameSpace: false
	}).build(output);

	fs.writeFileSync('test-results/coverage/cobertura.xml', xmlContent);
})();
