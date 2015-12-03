//
//  WalletViewController.m
//  GettingStart
//
//  Created by Cypac on 11/30/15.
//  Copyright © 2015 Modjadji. All rights reserved.
//

#import "WalletViewController.h"
#import "APIServices.h"
#import "Constants.h"

#import <SCLAlertView-Objective-C/SCLAlertView.h>

@interface WalletViewController ()

@end

@implementation WalletViewController

@synthesize viewTopWallet;
@synthesize lblWalletAmount;
@synthesize actAnimating;

- (void)viewDidLoad {
    viewTopWallet.layer.cornerRadius = 10.0;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [lblWalletAmount setHidden:YES];
    
    [actAnimating startAnimating];
    [self performSelectorInBackground:@selector(getWalletInfo) withObject:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
    
}



- (IBAction)btnLearnMoreClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kModjadjiPlatformDocumentationURL]];
}

- (IBAction)btnBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)getWalletInfo
{    
    APIServices *server = [APIServices sharedAPIService];
    
    [server getWalletInfo:kTempWalletCode block:^(NSDictionary *dicResponse, NSMutableDictionary *dicFailMessage, NSError *error) {
        if (error == nil)
        {
            if (dicResponse)
            {
                NSLog(@"Wallet Info Success : %@", dicResponse);
                
                NSString *strMessageText;
                
                if ([[dicResponse objectForKey:@"Status"] isEqualToString:kModjadjiPlatformSuccessCode]) {
                    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
                    numberFormatter.alwaysShowsDecimalSeparator = NO;
                    numberFormatter.minimumFractionDigits = 2;
                    numberFormatter.maximumFractionDigits = 2;
                    numberFormatter.minimumIntegerDigits = 1;
                    lblWalletAmount.text = [NSString stringWithFormat:@"$%@", [numberFormatter stringFromNumber:[NSNumber numberWithFloat:[[[dicResponse objectForKey:@"DataObject"] objectForKey:@"CurrentBalance"] floatValue]]]];
                    
                    numberFormatter = nil;
                    
                    
                    strMessageText = [[dicResponse valueForKey:@"Message"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    
                    [self updateWalletInfo];
                    
                    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                    [alert showSuccess:kSCLSuccessTitle subTitle:strMessageText closeButtonTitle:kSCLCloseButtonTitle duration:0.5f];
                }
                else {
                    lblWalletAmount.text = @"$ 0.0";
                    
                    [self updateWalletInfo];
                    
                    strMessageText = [[dicResponse valueForKey:@"Message"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    
                    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                    [alert showNotice:kSCLNoticeTitle subTitle:strMessageText closeButtonTitle:kSCLCloseButtonTitle duration:0.5f];
                }
                
                
            }
            else if (dicFailMessage)
            {
                NSLog(@"Wallet Info Failed : %@", dicFailMessage);
                
                lblWalletAmount.text = @"$ 0.0";
                [self updateWalletInfo];
                
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert showWarning:[dicFailMessage valueForKey:@"Title"] subTitle:[dicFailMessage valueForKey:@"Message"] closeButtonTitle:kSCLCloseButtonTitle duration:0.0f];
            }
        }
        else
        {
            NSLog(@"Wallet Info Error : %@", [error debugDescription]);
            
            lblWalletAmount.text = @"$ 0.0";
            [self updateWalletInfo];
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert showError:kSCLErrorTitle subTitle:[error localizedDescription] closeButtonTitle:kSCLCloseButtonTitle duration:0.0f];
        }
    }];
}


- (void)updateWalletInfo
{
    [lblWalletAmount setHidden:NO];
    [actAnimating stopAnimating];
}


@end
