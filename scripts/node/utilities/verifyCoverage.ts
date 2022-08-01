#!/usr/bin/env node

'use strict';

const deploymentResult = require('./results.json');

const apexTestResults = deploymentResult.result.details.runTestResult.codeCoverage.reduce(
	(result, detail) => ({
		...result,
		[detail.name]: detail
	}),
	{}
);

// const flowTestResults = deploymentResult.result.details.runTestResult.codeCoverage; // Not used for now.

const requiredCoverage = parseInt(process.argv[2], 10);
const testClassesToCheck = process.argv[3].split(',');

if (!testClassesToCheck) {
	const msg = 'There are no apex test classes to check coverage.';
	console.log(msg);
	process.exit(0);
}

const classesWithCoverage = testClassesToCheck.map((testClassName) => {
	const testClassDetails = apexTestResults[testClassName];

	const totalLines = testClassDetails.numLocations;
	const linesNotCovered = testClassDetails.numLocationsNotCovered;
	const linesCovered = totalLines - linesNotCovered;
	const percentCoverage = (linesCovered / totalLines) * 100;
	return {
		class: testClassName,
		percentage: percentCoverage
	};
});

console.log(classesWithCoverage.map((coverage) => `${coverage.class}: ${coverage.percentage}%`).join('\n'));

const classesWithoutEnoughCoverage = classesWithCoverage
	.filter((item) => item.percentage < requiredCoverage)
	.map((item) => item.class);

if (classesWithoutEnoughCoverage.length > 0) {
	const msg = `Included test classes should met at least the required coverage of ${requiredCoverage}%. Classes without enough coverage: ${classesWithoutEnoughCoverage.join(
		', '
	)}.`;
	console.error(msg);
	process.exit(1);
}
