//
//  HeadSetupViewController.h
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "AppDelegate.h"
#import "GamePlayMethods.h"



@interface HeadSetupViewController : UIViewController <MCBrowserViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tblConnectedDevices;

- (IBAction)browseForDevices:(id)sender;

@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) NSMutableArray *arrConnectedDevices;

-(void)didReceiveDataWithNotification:(NSNotification *)notification;

@property NSString *theWords;
@property NSString *letters;
@property (strong, nonatomic) IBOutlet UIButton *btnPlay;

- (IBAction)btnPlayPressed:(id)sender;
- (IBAction)segmentLevelChanged:(id)sender;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentLevel;

@property (strong, nonatomic) NSString *level;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;

@property BOOL isOrganizer;

@property GamePlayMethods *gamePlayMethods;

@end
