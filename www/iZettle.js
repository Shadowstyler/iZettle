/*global cordova, module*/

module.exports = {
    startiZettleSDK: function (apiKey) {
        cordova.exec(null, null, "iZettle", "startiZettleSDK", [apiKey]);
    },
    enforcedUserAccount: function (userAccount) {
        cordova.exec(null, null, "iZettle", "enforcedUserAccount", [userAccount]);
    },
    chargeAmount: function (amount, enableTipping, reference, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "iZettle", "chargeAmount", [amount, enableTipping, reference]);
    },
    refundAmount: function (amount, reference, refundreference, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "iZettle", "refundAmount", [amount, reference, refundreference]);
    },
    retrievePaymentInfoForReference: function (reference, successCallback) {
        cordova.exec(successCallback, null, "iZettle", "retrievePaymentInfoForReference", [reference]);
    },
    presentSettingsFromViewController: function () {
        cordova.exec(null, null, "iZettle", "presentSettingsFromViewController");
    },
    abortOperation: function() {
	 	cordova.exec(null, null, "iZettle", "abortOperation");  
    }
};
