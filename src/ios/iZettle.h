//
//  iZettle.h
//  POS
//
//  Created by Tue Topholm on 19/05/15.
//
//

#import <Cordova/CDV.h>

@interface iZettle : CDVPlugin

- (void) startiZettleSDK:(CDVInvokedUrlCommand*)command;
- (void) enforcedUserAccount:(CDVInvokedUrlCommand*)command;
- (void) chargeAmount:(CDVInvokedUrlCommand*)command;
- (void) refundAmount:(CDVInvokedUrlCommand*)command;
- (void) retrievePaymentInfoForReference:(CDVInvokedUrlCommand*)command;
- (void) presentSettingsFromViewController:(CDVInvokedUrlCommand*)command;
- (void) abortOperation:(CDVInvokedUrlCommand*)command;
- (NSDictionary*) convertPaymentInfo: (id)paymentInfo;


@end
