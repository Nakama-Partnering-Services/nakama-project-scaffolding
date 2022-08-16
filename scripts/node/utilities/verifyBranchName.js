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
		const validBranchPrefix = 'feature|bugfix|hotfix|chore';
		const userStoryPrefix = 'US-';
		const validBranchesRegex = new RegExp(`^(${validBranchPrefix})/${userStoryPrefix}[\\w.-]+$`);
		if (!validBranchesRegex.test(branchName)) {
			const msg = `Branch names in this project must adhere to this contract: (${validBranchPrefix})/${userStoryPrefix}*.`;
			console.error(msg);
			process.exit(1);
		}
	}
};

validateBranchName();
