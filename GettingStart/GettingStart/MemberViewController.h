//
//  MemberViewController.h
//  GettingStart
//
//  Created by Cypac on 12/1/15.
//  Copyright © 2015 Modjadji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberViewController : UIViewController {
    NSMutableDictionary *dicMemberInfo;
}

@property (weak, nonatomic) IBOutlet UILabel *lblMemberName;
@property (weak, nonatomic) IBOutlet UILabel *lblMemberDOB;
@property (weak, nonatomic) IBOutlet UILabel *lblMemberEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblMemberContactNumber;
@property (weak, nonatomic) IBOutlet UIView *viewTopMember;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actAnimating;

- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnLearnMoreClicked:(id)sender;

@end
