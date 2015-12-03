//
//  APIServices.m
//  GettingStart
//
//  Created by Cypac on 11/30/15.
//  Copyright © 2015 Modjadji. All rights reserved.
//

#import "APIServices.h"

#import "Constants.h"

//#if !defined(DEBUG) || !(TARGET_IPHONE_SIMULATOR)
//#define NSLog(...)
//#endif

@implementation APIServices

@synthesize operationQueue;

- (id)init;
{
    if ( ( self = [super init] ) )
    {
        operationQueue = [[NSOperationQueue alloc] init];
        operationQueue.maxConcurrentOperationCount = 4;
    }
    
    return self;
}

+ (id)sharedAPIService;
{
    static dispatch_once_t onceToken;
    static id sharedAPIService = nil;
    
    dispatch_once( &onceToken, ^{
        sharedAPIService = [[[self class] alloc] init];
    });
    
    return sharedAPIService;
}


- (void)getWalletInfo:(NSString *)strWalletCode block:(ResponseBlock)block
{
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", kBaseURL, kGetWalletInfoURL, strWalletCode]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        request.HTTPMethod = KHTTPMethodGET;
        request.timeoutInterval = KHTTPMethodTimeout;
        
        // This is how we set header fields
        [request setValue:KHTTPHeaderFieldContentType forHTTPHeaderField:@"Content-Type"];
        [request setValue:KHTTPHeaderFieldAccept forHTTPHeaderField:@"Accept"];
        
        [request setValue:[Constants getAuthHeader] forHTTPHeaderField:@"Authorization"];
        [request setValue:kModjadjiAppId forHTTPHeaderField:@"AppId"];
        [request setValue:kModjadjiInstallationId forHTTPHeaderField:@"InstallationId"];
        [request setValue:kModjadjiDeviceId forHTTPHeaderField:@"DeviceId"];
        
        NSHTTPURLResponse* responseURL = nil;
        NSError *error;
        NSData *dataBulletins = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseURL error:&error];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             NSLog(@"Response Code : %ld (%@)", (long)responseURL.statusCode, request.URL.absoluteString);
             
             if (error)
             {
                 if (error.code == kCFURLErrorUserCancelledAuthentication)
                 {
                     NSMutableDictionary *dicFailMessage = [Constants getAPI401Message];
                     
                     block(nil, dicFailMessage, nil);
                 }
                 else
                 {
                     block(nil, nil, error);
                 }
             }
             else
             {
                 if (responseURL.statusCode == 200)
                 {
                     NSError *jsonParsingError = nil;
                     NSDictionary *response = [[NSDictionary alloc] init];
                     response = [NSJSONSerialization JSONObjectWithData:dataBulletins options:0 error:&jsonParsingError];
                     
                     //NSLog(@"API Response :%@", response);
                     
                     block(response, nil, nil);
                     
                     response = nil;
                 }
                 else
                 {
                     NSMutableDictionary *dicFailMessage = [Constants getAPIFailMessage];
                     
                     block(nil, dicFailMessage, nil);
                 }
             }
         }];
    }];
    
    // Optionally, set the operation priority. This is useful when flooding
    // the operation queue with different requests.
    
    [operation setQueuePriority:NSOperationQueuePriorityVeryHigh];
    [self.operationQueue addOperation:operation];
}

- (void)getPersonalInfo:(NSMutableDictionary *)dicParams block:(ResponseBlock)block
{
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kBaseURL, kGetPersonalInfoURL]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        request.HTTPMethod = KHTTPMethodGET;
        request.timeoutInterval = KHTTPMethodTimeout;
        
        // This is how we set header fields
        [request setValue:KHTTPHeaderFieldContentType forHTTPHeaderField:@"Content-Type"];
        [request setValue:KHTTPHeaderFieldAccept forHTTPHeaderField:@"Accept"];
        
        [request setValue:[Constants getAuthHeader] forHTTPHeaderField:@"Authorization"];
        [request setValue:kModjadjiAppId forHTTPHeaderField:@"AppId"];
        [request setValue:kModjadjiInstallationId forHTTPHeaderField:@"InstallationId"];
        [request setValue:kModjadjiDeviceId forHTTPHeaderField:@"DeviceId"];
        
        NSHTTPURLResponse* responseURL = nil;
        NSError *error;
        NSData *dataBulletins = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseURL error:&error];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             NSLog(@"Response Code : %ld (%@)", (long)responseURL.statusCode, request.URL.absoluteString);
             
             if (error)
             {
                 if (error.code == kCFURLErrorUserCancelledAuthentication)
                 {
                     NSMutableDictionary *dicFailMessage = [Constants getAPI401Message];
                     
                     block(nil, dicFailMessage, nil);
                 }
                 else
                 {
                     block(nil, nil, error);
                 }
             }
             else
             {
                 if (responseURL.statusCode == 200)
                 {
                     NSError *jsonParsingError = nil;
                     NSDictionary *response = [[NSDictionary alloc] init];
                     response = [NSJSONSerialization JSONObjectWithData:dataBulletins options:0 error:&jsonParsingError];
                     
                     //NSLog(@"API Response :%@", response);
                     
                     block(response, nil, nil);
                     
                     response = nil;
                 }
                 else
                 {
                     NSMutableDictionary *dicFailMessage = [Constants getAPIFailMessage];
                     
                     block(nil, dicFailMessage, nil);
                 }
             }
         }];
    }];
    
    // Optionally, set the operation priority. This is useful when flooding
    // the operation queue with different requests.
    
    [operation setQueuePriority:NSOperationQueuePriorityVeryHigh];
    [self.operationQueue addOperation:operation];
}



- (void)getWalletTransactions:(NSString *)strWalletCode withStartDate:(NSString *)strStartDate withEndDate:(NSString *)strEndDate withPageSize:(int)pageSize withPageNumber:(int)pageNum block:(ResponseBlock)block
{
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@&startDate=%@&endDate=%@&pageSize=%d&pageNum=%d", kBaseURL, kGetWalletTransactionsURL, strWalletCode, strStartDate, strEndDate, pageSize, pageNum]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        request.HTTPMethod = KHTTPMethodGET;
        request.timeoutInterval = KHTTPMethodTimeout;
        
        // This is how we set header fields
        [request setValue:KHTTPHeaderFieldContentType forHTTPHeaderField:@"Content-Type"];
        [request setValue:KHTTPHeaderFieldAccept forHTTPHeaderField:@"Accept"];
        
        [request setValue:[Constants getAuthHeader] forHTTPHeaderField:@"Authorization"];
        [request setValue:kModjadjiAppId forHTTPHeaderField:@"AppId"];
        [request setValue:kModjadjiInstallationId forHTTPHeaderField:@"InstallationId"];
        [request setValue:kModjadjiDeviceId forHTTPHeaderField:@"DeviceId"];
        
        NSHTTPURLResponse* responseURL = nil;
        NSError *error;
        NSData *dataBulletins = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseURL error:&error];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             NSLog(@"Response Code : %ld (%@)", (long)responseURL.statusCode, request.URL.absoluteString);
             
             if (error)
             {
                 if (error.code == kCFURLErrorUserCancelledAuthentication)
                 {
                     NSMutableDictionary *dicFailMessage = [Constants getAPI401Message];
                     
                     block(nil, dicFailMessage, nil);
                 }
                 else
                 {
                     block(nil, nil, error);
                 }
             }
             else
             {
                 if (responseURL.statusCode == 200)
                 {
                     NSError *jsonParsingError = nil;
                     NSDictionary *response = [[NSDictionary alloc] init];
                     response = [NSJSONSerialization JSONObjectWithData:dataBulletins options:0 error:&jsonParsingError];
                     
                     //NSLog(@"API Response :%@", response);
                     
                     block(response, nil, nil);
                     
                     response = nil;
                 }
                 else
                 {
                     NSMutableDictionary *dicFailMessage = [Constants getAPIFailMessage];
                     
                     block(nil, dicFailMessage, nil);
                 }
             }
         }];
    }];
    
    // Optionally, set the operation priority. This is useful when flooding
    // the operation queue with different requests.
    
    [operation setQueuePriority:NSOperationQueuePriorityVeryHigh];
    [self.operationQueue addOperation:operation];
}


@end
