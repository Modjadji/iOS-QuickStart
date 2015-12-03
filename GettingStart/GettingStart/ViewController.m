//
//  ViewController.m
//  GettingStart
//
//  Created by Cypac on 11/30/15.
//  Copyright © 2015 Modjadji. All rights reserved.
//

#import "ViewController.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#import "Constants.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize btnViewMember, btnWalletInfo, btnTransactionHistory;
@synthesize btnRegisterMember, btnMoreFunctions;

- (void)viewDidLoad {
    
    [self setUIButtonElements:btnWalletInfo];
    [self setUIButtonElements:btnTransactionHistory];
    [self setUIButtonElements:btnViewMember];
    [self setUIButtonElements:btnRegisterMember];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setUIButtonElements:(id)sender
{
    UIButton *btnSender = (UIButton *)sender;
    btnSender.layer.cornerRadius = 25.0;
    
    btnSender.layer.shadowColor = [UIColor blackColor].CGColor;
    btnSender.layer.shadowOpacity = 0.5;
    btnSender.layer.shadowRadius = 2.0f;
    btnSender.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)proceedToPlatformRegistration
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kModjadjiPlatformRegistrationURL]];
}

- (IBAction)btnMoreFunctionsClicked:(id)sender {
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert addButton:kSCLGoToRegisterTitle target:self selector:@selector(proceedToPlatformRegistration)];
    [alert showInfo:kSCLInfoTitle subTitle:kApplicationUpdateMessage closeButtonTitle:kSCLCloseButtonTitle duration:0.0f];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"WalletViewController"]) {
        // send data
    }
}

@end
