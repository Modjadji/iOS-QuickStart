//
//  APIServices.h
//  GettingStart
//
//  Created by Cypac on 11/30/15.
//  Copyright © 2015 Modjadji. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KHTTPMethodPOST @"POST"
#define KHTTPMethodGET @"GET"

#define KHTTPMethodTimeout 80;

#define KHTTPHeaderFieldAccept @"application/json"
#define KHTTPHeaderFieldContentType @"application/json"

#define kBaseURL @"https://api.sit.modjadji.org:8243/TipsGo/v1.0.0/api/"

#define kGetWalletInfoURL @"Wallet/GetWalletInfo?walletCode="
#define kGetPersonalInfoURL @"Member/GetPersonalInfo"
#define kGetWalletTransactionsURL @"Wallet/GetWalletTransactions?walletCode="

typedef void (^ResponseBlock)(NSDictionary *dicResponse, NSMutableDictionary *dicFailMessage, NSError *error);

@interface APIServices : NSObject
{
}


+ (id)sharedAPIService;

@property (strong) NSOperationQueue *operationQueue;


- (void)getWalletInfo:(NSString *)strWalletCode block:(ResponseBlock)block;
- (void)getPersonalInfo:(NSMutableDictionary *)dicParams block:(ResponseBlock)block;
- (void)getWalletTransactions:(NSString *)strWalletCode withStartDate:(NSString *)strStartDate withEndDate:(NSString *)strEndDate withPageSize:(int)pageSize withPageNumber:(int)pageNum block:(ResponseBlock)block;

@end
