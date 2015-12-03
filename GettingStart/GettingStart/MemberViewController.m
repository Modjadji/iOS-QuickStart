//
//  MemberViewController.m
//  GettingStart
//
//  Created by Cypac on 12/1/15.
//  Copyright © 2015 Modjadji. All rights reserved.
//

#import "MemberViewController.h"
#import "APIServices.h"
#import "Constants.h"

#import <SCLAlertView-Objective-C/SCLAlertView.h>

@interface MemberViewController ()

@end

@implementation MemberViewController

@synthesize viewTopMember;
@synthesize actAnimating;
@synthesize lblMemberName, lblMemberEmail, lblMemberDOB, lblMemberContactNumber;

- (void)viewDidLoad {
    viewTopMember.layer.cornerRadius = 10.0;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [lblMemberName setHidden:YES];
    [lblMemberEmail setHidden:YES];
    [lblMemberDOB setHidden:YES];
    [lblMemberContactNumber setHidden:YES];
    
    [actAnimating startAnimating];
    [self performSelectorInBackground:@selector(getMemberInfo) withObject:nil];
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

- (IBAction)btnLearnMoreClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kModjadjiPlatformDocumentationURL]];
}

- (IBAction)btnBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getMemberInfo
{
    APIServices *server = [APIServices sharedAPIService];
    
    [server getPersonalInfo:nil block:^(NSDictionary *dicResponse, NSMutableDictionary *dicFailMessage, NSError *error) {
        if (error == nil)
        {
            if (dicResponse)
            {
                NSLog(@"Member Info Success : %@", dicResponse);
                
                NSString *strMessageText;
                
                if ([[dicResponse objectForKey:@"Status"] isEqualToString:kModjadjiPlatformSuccessCode]) {
                    
                    lblMemberName.text = [NSString stringWithFormat:@"%@ %@", [[dicResponse objectForKey:@"DataObject"] objectForKey:@"FirstName"], [[dicResponse objectForKey:@"DataObject"] objectForKey:@"Surname"]];
                    lblMemberEmail.text = [[dicResponse objectForKey:@"DataObject"] objectForKey:@"Email"];
                    lblMemberDOB.text = [Constants getFormattedDateTimeFromAPIDateTime:[[dicResponse objectForKey:@"DataObject"] objectForKey:@"DateOfBirth"]];
                    lblMemberContactNumber.text = [[dicResponse objectForKey:@"DataObject"] objectForKey:@"RelationshipStatusFlag"];
                    
                    [self updateMemberInfo];
                    
                    strMessageText = [[dicResponse valueForKey:@"Message"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    
                    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                    [alert showSuccess:kSCLSuccessTitle subTitle:strMessageText closeButtonTitle:kSCLCloseButtonTitle duration:0.5f];
                }
                else
                {
                    lblMemberName.text = @"";
                    lblMemberEmail.text = @"";
                    lblMemberDOB.text = @"";
                    lblMemberContactNumber.text = @"";
                    
                    [self updateMemberInfo];
                    
                    strMessageText = [[dicResponse valueForKey:@"Message"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    
                    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                    [alert showNotice:kSCLNoticeTitle subTitle:strMessageText closeButtonTitle:kSCLCloseButtonTitle duration:0.5f];
                }
            }
            else if (dicFailMessage)
            {
                NSLog(@"Member Info Failed : %@", dicFailMessage);
                
                lblMemberName.text = @"";
                lblMemberEmail.text = @"";
                lblMemberDOB.text = @"";
                lblMemberContactNumber.text = @"";
                
                [self updateMemberInfo];
                
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert showWarning:[dicFailMessage valueForKey:@"Title"] subTitle:[dicFailMessage valueForKey:@"Message"] closeButtonTitle:kSCLCloseButtonTitle duration:0.0f];
            }
        }
        else
        {
            NSLog(@"Member Info Error : %@", [error debugDescription]);
            
            lblMemberName.text = @"";
            lblMemberEmail.text = @"";
            lblMemberDOB.text = @"";
            lblMemberContactNumber.text = @"";
            
            [self updateMemberInfo];
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert showError:kSCLErrorTitle subTitle:[error localizedDescription] closeButtonTitle:kSCLCloseButtonTitle duration:0.0f];
        }
    }];
}


- (void)updateMemberInfo
{
    [lblMemberName setHidden:NO];
    [lblMemberEmail setHidden:NO];
    [lblMemberDOB setHidden:NO];
    [lblMemberContactNumber setHidden:NO];
    
    [actAnimating stopAnimating];
}



@end
