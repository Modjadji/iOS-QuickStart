//
//  ViewController.h
//  GettingStart
//
//  Created by Cypac on 11/30/15.
//  Copyright © 2015 Modjadji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnViewMember;
@property (weak, nonatomic) IBOutlet UIButton *btnRegisterMember;
@property (weak, nonatomic) IBOutlet UIButton *btnTransactionHistory;
@property (weak, nonatomic) IBOutlet UIButton *btnWalletInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnMoreFunctions;

- (IBAction)btnMoreFunctionsClicked:(id)sender;

@end

