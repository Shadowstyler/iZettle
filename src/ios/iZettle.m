//
//  iZettle.m
//  POS
//
//  Created by Tue Topholm on 19/05/15.
//
//

#import <Foundation/Foundation.h>
#import "iZettle.h"
#import <Cordova/CDV.h>
#import <iZettleSDK/iZettleSDK.h>

@implementation iZettle

- (void) startiZettleSDK:(CDVInvokedUrlCommand *)command {
    NSString* apiKey = [command.arguments objectAtIndex:0];
    [[iZettleSDK shared] startWithAPIKey:apiKey];
}

- (void) enforcedUserAccount:(CDVInvokedUrlCommand *)command {
    NSString* userAccount = [command.arguments objectAtIndex:0];
    [iZettleSDK shared].enforcedUserAccount = userAccount;
}

- (void) chargeAmount:(CDVInvokedUrlCommand *)command {
    NSDecimalNumber* amount = [NSDecimalNumber decimalNumberWithString:[command.arguments objectAtIndex:0]];
    NSString* currency = [command.arguments objectAtIndex:1];
    NSString* reference = [command.arguments objectAtIndex:2];
    [[iZettleSDK shared] chargeAmount:amount currency:currency reference:reference presentFromViewController:self.viewController completion:^(iZettleSDKPaymentInfo *paymentInfo, NSError *error) {
        if (paymentInfo != nil) {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:[self convertPaymentInfo: paymentInfo]];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        } else {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
}          

- (void) refundAmount:(CDVInvokedUrlCommand *)command {
    NSDecimalNumber* amount = [NSDecimalNumber decimalNumberWithString:[command.arguments objectAtIndex:0]];
    NSString* reference = [command.arguments objectAtIndex:1];
    NSString* refundreference = [command.arguments objectAtIndex:2];
    [[iZettleSDK shared] refundAmount:amount ofPaymentWithReference:reference refundReference:refundreference presentFromViewController:self.viewController completion:^(iZettleSDKPaymentInfo *paymentInfo, NSError *error) {
        if (paymentInfo != nil) {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:[self convertPaymentInfo: paymentInfo]];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        } else {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
}

- (void) retrievePaymentInfoForReference:(CDVInvokedUrlCommand*)command {
    NSString* reference = [command.arguments objectAtIndex:0];
    [[iZettleSDK shared] retrievePaymentInfoForReference:reference presentFromViewController:self.viewController completion:^(iZettleSDKPaymentInfo *paymentInfo, NSError *error){
        if (paymentInfo != nil) {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:[self convertPaymentInfo: paymentInfo]];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        } else {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
}

- (void) presentSettingsFromViewController:(CDVInvokedUrlCommand*)command {
    [[iZettleSDK shared] presentSettingsFromViewController:self.viewController];
}

- (void) abortOperation:(CDVInvokedUrlCommand *)command {
    [[iZettleSDK shared] abortOperation];
}

- (NSDictionary*) convertPaymentInfo:(iZettleSDKPaymentInfo *)paymentInfo {
    NSString* referenceNumber  = @"Not Set";
    NSString* entryMode = @"Not Set";
    NSString* obfuscatedPan = @"Not Set";
    NSString* panHash = @"Not Set";
    NSString* cardBrand = @"Not Set";
    NSString* authorizationCode = @"Not Set";
    NSString* AID = @"Not Set";
    NSString* TSI = @"Not Set";
    NSString* TVR = @"Not Set";
    NSString* applicationName = @"Not Set";
    if (paymentInfo.referenceNumber != nil) {
        referenceNumber  = [NSString stringWithString:paymentInfo.referenceNumber];
    }
    if (paymentInfo.entryMode != nil) {
        entryMode = [NSString stringWithString:paymentInfo.entryMode];
    }
    if (paymentInfo.obfuscatedPan != nil) {
        obfuscatedPan = [NSString stringWithString:paymentInfo.obfuscatedPan];
    }
    if (paymentInfo.panHash != nil) {
        panHash = [NSString stringWithString:paymentInfo.panHash];
    }
    if (paymentInfo.cardBrand != nil) {
        cardBrand = [NSString stringWithString:paymentInfo.cardBrand];
    }
    if (paymentInfo.authorizationCode != nil) {
        authorizationCode = [NSString stringWithString:paymentInfo.authorizationCode];
    }
    if (paymentInfo.AID != nil) {
        AID = [NSString stringWithString:paymentInfo.AID];
    }
    if (paymentInfo.TSI != nil) {
        TSI = [NSString stringWithString:paymentInfo.TSI];
    }
    if (paymentInfo.TVR != nil) {
        TVR = [NSString stringWithString:paymentInfo.TVR];
    }
    if (paymentInfo.applicationName != nil) {
        applicationName = [NSString stringWithString:paymentInfo.applicationName];
    }
    return @{
             @"referenceNumber": referenceNumber,
             @"entryMode": entryMode,
             @"obfuscatedPan": obfuscatedPan,
             @"panHash": panHash,
             @"cardBrand": cardBrand,
             @"authorizationCode": authorizationCode,
             @"AID": AID,
             @"TSI": TSI,
             @"TVR": TVR,
             @"applicationName": applicationName
             };
}

@end