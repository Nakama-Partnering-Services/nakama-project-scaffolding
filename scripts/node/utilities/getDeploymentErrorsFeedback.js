const axios = require('axios');
const { Configuration, OpenAIApi } = require('openai');
const { resolve } = require('path');

(async () => {
	try {
		// Note: this may not be needed if using self-hosted runner with static IP and provided Key is available for that IP
		// Note: in Azure, even this fails, due to IP being blacklisted on Cloudflare
		axios({
			method: 'post',
			url: 'https://api.pawan.krd/resetip',
			headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${process.argv[2]}` }
		});
	} catch (error) {
		console.log('Reset IP error: ' + error);
	}

	const configuration = new Configuration({
		apiKey: process.argv[2],
		basePath: 'https://api.pawan.krd/v1' // Note: can also be /v1/chat/ and accept messages instead of prompt
	});

	const openAI = new OpenAIApi(configuration);

	const deploymentResult = require(resolve('results.json'));

	const failures = JSON.stringify(deploymentResult.result.details.componentFailures);

	const response = await openAI.createCompletion({
		model: 'gpt-3.5-turbo',
		prompt: `Suggest how to fix the following Salesforce deployment issues: ${failures}`,
		temperature: 0.5,
		max_tokens: 256
	});

	console.log(response.data.choices[0].text);
})();
