const fs = require('fs');
const replacementsConfig = require('./config.json');

const { XMLParser, XMLBuilder } = require('fast-xml-parser');

replacementsConfig.forEach((replacementConfig) => {
	const folderPath = replacementConfig.path;
	fs.readdirSync(folderPath).forEach((file) => {
		const data = fs.readFileSync(folderPath + '/' + file, 'UTF-8');

		const output = new XMLParser({
			ignoreDeclaration: true,
			attributeNamePrefix: '@_'
		}).parse(data);

		writeOnPath(output, replacementConfig.replacementTagPath, replacementConfig.replacementValue);

		const xmlContent = new XMLBuilder({
			format: true
		}).build(output);

		fs.writeFileSync(folderPath + '/' + file, xmlContent);
	});
});

function writeOnPath(object, jsonPath, value) {
	const fullPath = jsonPath.split('.').reverse();
	while (fullPath.length > 1) {
		object = object[fullPath.pop()];
	}
	object[fullPath.pop()] = value;
	return object;
}
