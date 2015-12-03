//
//  CashflowViewController.h
//  GettingStart
//
//  Created by Cypac on 12/1/15.
//  Copyright © 2015 Modjadji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashflowViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *arrWalletHistory;
}

@property (weak, nonatomic) IBOutlet UITableView *tblWalletHistory;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actAnimating;

- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnLearnMoreClicked:(id)sender;

@end
