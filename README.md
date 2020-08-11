# iZettle

Plugin for Cordova to use iZettle SDK in iOS (sdk < 3.0 && > 2.05)

You will need an API key issued by iZettle in order to use this plugin

To Install:

1. Follow https://github.com/iZettle/sdk-ios, recommend using CocoaPods to install iZettleSDK in ios directory in your Cordova project and then configuring bluetooth and location capabilities in xCode.

2. Add Plugin using cordova plugin add

# Setup your API key

To begin using iZettle SDK run:

	iZettle.startiZettleSDK('IZETTLE-API-KEY-GOES-HERE');
	
**Only load this into your application once.**

# Enforce user account

To force useage of a sepcific iZettle account:

	iZettle.enforcedUserAccount(iZettle-Account-Email);

# Charge Amount

To charge an amount through the iZettle reader:

	iZettle.chargeAmount(Amount, enableTipping, Reference, transactionSuccessful, transactionFailed);

- **Amount**: The amount to be charged in the logged in users currency
- **enableTipping**: defunc
- **Reference**: The payment reference. Used to identify an iZettle payment, used when retrieving payment information at a later time or performing a refund. Max length 128.
- **transactionSuccessful**: Callback to be fired on transaction succeding
- **transactionFailed**: Callback to be fired on transaction failing

transactionSuccessful returns iZettlePaymentInfo object as seen in iZettle SDK documentation.

# Refund Amount

To refund an amount through the iZettle reader:

	iZettle.refundAmount(Amount, Reference, Refund Reference, transactionSuccessful, transactionFailed);

- **Amount**: The amount to be charged in the logged in users currency
- **Reference**: The reference of the original payment used when chargeAmount was called.
- **Refund Reference**: The refund reference. Used to identify an iZettle payment, used when retrieving payment information at a later time or performing a refund. Max length 128.
- **transactionSuccessful**: Callback to be fired on transaction succeding
- **transactionFailed**: Callback to be fired on transaction failing

# Presenting Settings

Present iZettle settings view. The user can switch account, access the iZettle FAQ, view card reader settings etc.

	iZettle.presentSettingsFromViewController();
	
# Abort Operation

Attempt aborting the ongoing operation. Only use this if absolutely necessary. The state of the payment will be unknown to the user after this call.

	iZettle.abortOperation();
