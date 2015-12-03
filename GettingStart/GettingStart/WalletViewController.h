//
//  WalletViewController.h
//  GettingStart
//
//  Created by Cypac on 11/30/15.
//  Copyright © 2015 Modjadji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalletViewController : UIViewController {
    NSMutableDictionary *dicWalletInfo;
}

@property (weak, nonatomic) IBOutlet UIView *viewTopWallet;
@property (weak, nonatomic) IBOutlet UILabel *lblWalletAmount;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actAnimating;

- (IBAction)btnLearnMoreClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;


@end
