/* eslint-disable no-console */
/**
 * Toast notification handler
 */
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
/**
 * Shows a success toast notification
 * @param {object} self - The context (this) where you call the notification. Mandatory.
 * @param {object} options - Params to show the notification. Optional.
 *     - {string} message - Text to show in the notification.
 *     - {string} title - Alternative title.
 *     - {string} mode - Determines how persistent the toast is. Possible values are: dismissable | pester | sticky
 */
const showToastSuccess = (self, options) => {
	options = options ? options : {};
	const showSuccess = new ShowToastEvent({
		variant: 'success',
		title: options.title || 'Success',
		message: options.message || '',
		mode: options.mode || 'dismissable'
	});
	self.dispatchEvent(showSuccess);
};
/**
 * Shows an error toast notification
 * @param {object} self - The context (this) where you call the notification. Mandatory.
 * @param {object} options - Params to show the notification. Optional.
 *     - {string} message - Text to show in the notification.
 *     - {string} title - Alternative title.
 *     - {string} mode - Determines how persistent the toast is. Possible values are: dismissable | pester | sticky
 *     - {array}  messageData - url and label values that replace the {index} placeholders in the message string.
 */
const showToastError = (self, options) => {
	options = options ? options : {};
	const showError = new ShowToastEvent({
		variant: 'error',
		title: options.title || 'Error',
		message: options.message || '',
		messageData: options.messageData || [],
		mode: options.mode || 'dismissable'
	});
	self.dispatchEvent(showError);
};
/**
 * Shows a warning toast notification
 * @param {object} self - The context (this) where you call the notification. Mandatory.
 * @param {object} options - Params to show the notification. Optional.
 *     - {string} message - Text to show in the notification.
 *     - {string} title - Alternative title.
 *     - {string} mode - Determines how persistent the toast is. Possible values are: dismissable | pester | sticky
 */
const showToastWarning = (self, options) => {
	options = options ? options : {};
	const showWarn = new ShowToastEvent({
		variant: 'warning',
		title: options.title || 'Warning',
		message: options.message || '',
		mode: options.mode || 'dismissable'
	});
	self.dispatchEvent(showWarn);
};
/**
 * Shows an info toast notification
 * @param {object} self - The context (this) where you call the notification. Mandatory.
 * @param {object} options - Params to show the notification. Optional.
 *     - {string} message - Text to show in the notification.
 *     - {string} title - Alternative title.
 *     - {string} mode - Determines how persistent the toast is. Possible values are: dismissable | pester | sticky
 */
const showToastInfo = (self, options) => {
	options = options ? options : {};
	const showInfo = new ShowToastEvent({
		variant: 'info',
		title: options.title || 'Info',
		message: options.message || '',
		mode: options.mode || 'dismissable'
	});
	self.dispatchEvent(showInfo);
};

export { showToastSuccess, showToastError, showToastWarning, showToastInfo };
