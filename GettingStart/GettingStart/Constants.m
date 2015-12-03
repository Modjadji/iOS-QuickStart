//
//  Constants.m
//  GettingStart
//
//  Created by Cypac on 11/30/15.
//  Copyright © 2015 Modjadji. All rights reserved.
//

#import "Constants.h"



@implementation Constants

#if !defined(DEBUG) || !(TARGET_IPHONE_SIMULATOR)
#define NSLog(...)
#endif


+ (NSMutableDictionary *)getAPI401Message
{
    NSMutableDictionary *dicFailMessage = [[NSMutableDictionary alloc] init];
    
    [dicFailMessage setValue:k401Message forKeyPath:@"Message"];
    [dicFailMessage setValue:k401Title forKeyPath:@"Title"];
    
    return dicFailMessage;
}

+ (NSMutableDictionary *)getAPI500Message
{
    NSMutableDictionary *dicFailMessage = [[NSMutableDictionary alloc] init];
    
    [dicFailMessage setValue:k500Message forKeyPath:@"Message"];
    [dicFailMessage setValue:k500Title forKeyPath:@"Title"];
    
    return dicFailMessage;
}

+ (NSMutableDictionary *)getAPIFailMessage
{
    NSMutableDictionary *dicFailMessage = [[NSMutableDictionary alloc] init];
    
    [dicFailMessage setValue:kAPIErrorMessage forKeyPath:@"Message"];
    [dicFailMessage setValue:kAPIErrorTitle forKeyPath:@"Title"];
    
    return dicFailMessage;
}


+ (NSString *)getDeviceId
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (NSString *)getAuthHeader
{
    return [NSString stringWithFormat:@"Bearer %@", kModjadjiAccessToken];
}



+ (NSString *)getFormattedDateTimeFromAPIDateTime:(NSString *)strSourceDateTime
{
    NSString *strFormattedTime;
    
    if ([strSourceDateTime length] > 0)
    {
        //It should be displayed in minutes when less than an hour, in hours when within the same day, days when past a day old, weeks when past a week old, months when past a month old, years when past a year old
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        //[df setFormatterBehavior:NSDateFormatterBehavior10_4];
        
        // 2014-07-09T09:14:20.000Z
        [df setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
        //[df setDateFormat:@"yyyy-MM-ddTHH.mm.ssZ"];
        
        NSDate *sourceDate = [df dateFromString:strSourceDateTime];
        [df setDateFormat:@"dd MMM yyyy"];
        strFormattedTime = [df stringFromDate:sourceDate];
        
        // Fallsafe to fix for multiuse without SSS
        if ([strFormattedTime length] == 0) {
            [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
            //[df setDateFormat:@"yyyy-MM-ddTHH.mm.ssZ"];
            
            NSDate *sourceDate = [df dateFromString:strSourceDateTime];
            [df setDateFormat:@"dd MMM yyyy"];
            strFormattedTime = [df stringFromDate:sourceDate];
        }
        
        df = nil;
    }
    else
    {
        strFormattedTime = @"INVALID FORMAT";
    }
    
    return strFormattedTime;
}

@end
