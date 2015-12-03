//
//  Constants.h
//  GettingStart
//
//  Created by Cypac on 11/30/15.
//  Copyright © 2015 Modjadji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kModjadjiAccessKey @"_gZLgUuKtMfLvAzLfm3fBvYZ7wsa"
#define kModjadjiSecretKey @"lidep6lFCwRnvlVmCVAPDsaSfH8a"

#define kModjadjiAccessToken @"M2vYgXH1xYJ0DmxLurH3Zbfp3Osa"
#define kModjadjiAppId @"QuickStart"
#define kModjadjiInstallationId @"+1LikoDObzyRBPMEXIyrsy/wngHlitPX"
#define kModjadjiDeviceId @"123456789123456795"

#define kModjadjiPlatformRegistrationURL @"http://developer.modjadji.org/signup/"
#define kModjadjiPlatformDocumentationURL @"http://developer.modjadji.org/"



static NSString *kModjadjiPlatformSuccessCode = @"000000";


static NSString *kTempWalletCode = @"5636107328935424973";


static NSString *kSCLSuccessTitle = @"Congratulations";
static NSString *kSCLErrorTitle = @"Error";
static NSString *kSCLConnectionErrorTitle = @"Connection error";
static NSString *kSCLNoticeTitle = @"Notice";
static NSString *kSCLWarningTitle = @"Warning";
static NSString *kSCLInfoTitle = @"Info";
static NSString *kSCLCloseButtonTitle = @"Ok";
static NSString *kSCLCancelButtonTitle = @"Cancel";
static NSString *kSCLGoToRegisterTitle = @"Go to Register";



static NSString *kApplicationUpdateMessage = @"You need to have your own API Key and Secret Key to perfrom this function with Modjadji platform. Registar a Free account and get your API Key & Secret Key";

static NSString *k401Title = @"Info";
static NSString *k401Message = @"Something is wrong with your login email or password :(";

static NSString *k500Title = @"Oops!";
static NSString *k500Message = @"Something went wrong. Try again later?";

static NSString *kAPIErrorTitle = @"Something went wrong!";
static NSString *kAPIErrorMessage = @"Please check your connection and give it another go!";


@interface Constants : NSObject{
}

+ (NSMutableDictionary *)getAPI401Message;
+ (NSMutableDictionary *)getAPI500Message;
+ (NSMutableDictionary *)getAPIFailMessage;


+ (NSString *)getDeviceId;
+ (NSString *)getAuthHeader;

+ (NSString *)getFormattedDateTimeFromAPIDateTime:(NSString *)strSourceDateTime;

@end
