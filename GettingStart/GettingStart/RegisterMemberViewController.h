//
//  RegisterMemberViewController.h
//  GettingStart
//
//  Created by Cypac on 12/2/15.
//  Copyright © 2015 Modjadji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterMemberViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewTop;
@property (weak, nonatomic) IBOutlet UIButton *btnGetAPIKey;

- (IBAction)btnGetAPIKeyClicked:(id)sender;
- (IBAction)btnLearnMoreClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;

@end
