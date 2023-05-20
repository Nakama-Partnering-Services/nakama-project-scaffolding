'use strict';

const { promisify } = require('util');
const exec = promisify(require('child_process').exec);

const validateBranchName = async () => {
	const branchName = (await exec('git rev-parse --abbrev-ref HEAD')).stdout.trim();

	let isInRemote = true;

	await exec(`git show-branch remotes/origin/${branchName}`).catch(() => {
		isInRemote = false;
	});

	if (!isInRemote) {
		const validReleaseBranchPrefix = 'rc|patch';
		const validReleaseBranchesRegex = new RegExp(`^(${validReleaseBranchPrefix})/\\d\\.\\d\\.\\d`);

		const validDevelopmentBranchPrefix = 'feature|bugfix|hotfix|chore|backup';
		const userStoryPrefix = '[\\w]+';
		const userStoryPrefixReadable = '*';
		const validDevelopmentBranchesRegex = new RegExp(
			`^(${validDevelopmentBranchPrefix})/${userStoryPrefix}-[\\w.-]+$`
		);

		if (!validReleaseBranchesRegex.test(branchName) && !validDevelopmentBranchesRegex.test(branchName)) {
			const msg = `Branch names in this project must adhere to one of these contracts:
			(${validReleaseBranchPrefix})/major.minor.patch
			(${validDevelopmentBranchPrefix})/${userStoryPrefixReadable}-*`;
			console.error(msg);
			process.exit(1);
		}
	}
};

validateBranchName();
