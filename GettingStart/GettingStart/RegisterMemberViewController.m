//
//  RegisterMemberViewController.m
//  GettingStart
//
//  Created by Cypac on 12/2/15.
//  Copyright © 2015 Modjadji. All rights reserved.
//

#import "RegisterMemberViewController.h"
#import "Constants.h"

@interface RegisterMemberViewController ()

@end

@implementation RegisterMemberViewController

@synthesize viewTop;
@synthesize btnGetAPIKey;

- (IBAction)btnGetAPIKeyClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kModjadjiPlatformRegistrationURL]];
}

- (IBAction)btnLearnMoreClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kModjadjiPlatformDocumentationURL]];
}

- (IBAction)btnBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    viewTop.layer.cornerRadius = 10.0;
    btnGetAPIKey.layer.cornerRadius = 10.0;
    btnGetAPIKey.layer.shadowColor = [UIColor blackColor].CGColor;
    btnGetAPIKey.layer.shadowOpacity = 0.5;
    btnGetAPIKey.layer.shadowRadius = 2.0f;
    btnGetAPIKey.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
