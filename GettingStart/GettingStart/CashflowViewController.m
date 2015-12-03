//
//  CashflowViewController.m
//  GettingStart
//
//  Created by Cypac on 12/1/15.
//  Copyright © 2015 Modjadji. All rights reserved.
//

#import "CashflowViewController.h"
#import "APIServices.h"
#import "Constants.h"

#import <SCLAlertView-Objective-C/SCLAlertView.h>

@interface CashflowViewController ()

@end

@implementation CashflowViewController

@synthesize tblWalletHistory;
@synthesize actAnimating;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    arrWalletHistory = [[NSMutableArray alloc] init];
    
    [actAnimating startAnimating];
    [self performSelectorInBackground:@selector(getWalletHistory) withObject:nil];
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


- (void)getWalletHistory
{
    NSString *strStartDate = @"12/10/2015";
    NSString *strEndDate = @"12/12/2015";
    int pageSize = 0;
    int pageNum = 0;
    
    APIServices *server = [APIServices sharedAPIService];
    
    [server getWalletTransactions:kTempWalletCode withStartDate:strStartDate withEndDate:strEndDate withPageSize:pageSize withPageNumber:pageNum block:^(NSDictionary *dicResponse, NSMutableDictionary *dicFailMessage, NSError *error) {
        if (error == nil)
        {
            if (dicResponse)
            {
                NSLog(@"Wallet Transactions Success : %@", dicResponse);
                
                NSString *strMessageText;
                
                if ([[dicResponse objectForKey:@"Status"] isEqualToString:kModjadjiPlatformSuccessCode]) {
                    if ([[dicResponse objectForKey:@"ListOfObjects"] count] > 0) {
                        
                        [arrWalletHistory removeAllObjects];

                        NSMutableArray *arrList = [NSMutableArray arrayWithArray:[dicResponse objectForKey:@"ListOfObjects"]];
                        NSMutableDictionary *dicWalletRecord;
                        
                        for (int x=0; x < [arrList count]; x++) {
                            dicWalletRecord = [[NSMutableDictionary alloc] init];
                            [dicWalletRecord setObject:[[arrList objectAtIndex:x] objectForKey:@"Description"] forKey:@"Description"];
                            [dicWalletRecord setObject:[[arrList objectAtIndex:x] objectForKey:@"TranAmount"] forKey:@"TranAmount"];
                            [dicWalletRecord setObject:[[arrList objectAtIndex:x] objectForKey:@"CreateDate"] forKey:@"CreateDate"];
                            
                            [arrWalletHistory addObject:dicWalletRecord];
                        }
                    }
                    
                    strMessageText = [[dicResponse valueForKey:@"Message"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    
                    [self.tblWalletHistory reloadData];
                    [actAnimating stopAnimating];
                    
                    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                    [alert showSuccess:kSCLSuccessTitle subTitle:strMessageText closeButtonTitle:kSCLCloseButtonTitle duration:0.5f];
                }
                else
                {
                    [arrWalletHistory removeAllObjects];
                    
                    strMessageText = [[dicResponse valueForKey:@"Message"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    
                    [self.tblWalletHistory reloadData];
                    [actAnimating stopAnimating];
                    
                    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                    [alert showNotice:kSCLNoticeTitle subTitle:strMessageText closeButtonTitle:kSCLCloseButtonTitle duration:0.5f];
                }
                
                
            }
            else if (dicFailMessage)
            {
                NSLog(@"Wallet Transactions Failed : %@", dicFailMessage);
                
                [arrWalletHistory removeAllObjects];
                [self.tblWalletHistory reloadData];
                [actAnimating stopAnimating];
                
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert showWarning:[dicFailMessage valueForKey:@"Title"] subTitle:[dicFailMessage valueForKey:@"Message"] closeButtonTitle:kSCLCloseButtonTitle duration:0.0f];
            }
        }
        else
        {
            NSLog(@"Wallet Transactions Error : %@", [error debugDescription]);
            
            
            [arrWalletHistory removeAllObjects];
            [self.tblWalletHistory reloadData];
            
            [actAnimating stopAnimating];
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert showError:kSCLErrorTitle subTitle:[error localizedDescription] closeButtonTitle:kSCLCloseButtonTitle duration:0.0f];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrWalletHistory count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WalletHistoryCell"];
    
    CGFloat height = 0;
    
    //NSLog(@"Length : %d", [[[arrWalletHistory objectAtIndex:indexPath.row] objectForKey:@"Description"] length]);
    
    UILabel *lblDescription = (UILabel *)[cell viewWithTag:101];
    CGFloat width = lblDescription.frame.size.width;
    
    CGSize maximumSize = CGSizeMake(width, 10000);
    
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin;
    NSDictionary *attributDict = @{NSFontAttributeName: [UIFont systemFontOfSize:20.0f]};
    CGRect rectsize = [[[arrWalletHistory objectAtIndex:indexPath.row] objectForKey:@"Description"] boundingRectWithSize:maximumSize options:options attributes:attributDict context:nil];
    
    CGFloat lblHeight = ceilf(rectsize.size.height);
    
    if (lblHeight > 24)
    {
        height = cell.contentView.frame.size.height + lblHeight + 30;
    }
    else
        height = cell.contentView.frame.size.height;
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WalletHistoryCell"];
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    UIView *viewCell = (UIView *)[cell viewWithTag:100];
    viewCell.layer.cornerRadius = 7.0;
    
    UILabel *lblDescription = (UILabel *)[cell viewWithTag:101];
    lblDescription.text = [[arrWalletHistory objectAtIndex:indexPath.row] objectForKey:@"Description"];
    lblDescription.numberOfLines = 0;
    [lblDescription sizeToFit];
    
    UILabel *lblDate = (UILabel *)[cell viewWithTag:102];
    lblDate.text = [Constants getFormattedDateTimeFromAPIDateTime:[[arrWalletHistory objectAtIndex:indexPath.row] objectForKey:@"CreateDate"]];
    
    UILabel *lblAmount = (UILabel *)[cell viewWithTag:103];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.alwaysShowsDecimalSeparator = NO;
    numberFormatter.minimumFractionDigits = 2;
    numberFormatter.maximumFractionDigits = 2;
    numberFormatter.minimumIntegerDigits = 1;
    lblAmount.text = [NSString stringWithFormat:@"$%@", [numberFormatter stringFromNumber:[NSNumber numberWithFloat:[[[arrWalletHistory objectAtIndex:indexPath.row] objectForKey:@"TranAmount"] floatValue]]]];
    
    numberFormatter = nil;

    return cell;
}


@end
