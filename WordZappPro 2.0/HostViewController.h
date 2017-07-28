//
//  HostViewController.h
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/27/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "GamePlayMethods.h"




@interface HostViewController : UIViewController <MCBrowserViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tblConnectedDevices;

@property GamePlayMethods *gamePlayMethods;
@property NSMutableArray *arrayOfLettersInOrder;
@property NSMutableArray *arrayOfRandomLetters;

@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) NSMutableArray *arrConnectedDevices;

-(void)didReceiveDataWithNotification:(NSNotification *)notification;
- (IBAction)btnPlayPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnPlay;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentLevel;
- (IBAction)segmentLevelChanged:(id)sender;

@property NSString *theWords;
@property NSString *letters;

@property (strong, nonatomic) NSString *level;
@property (strong, nonatomic) NSString *list;


@property (strong, nonatomic) NSString *dataToSend;
@property NSString *peerNameEntered;

@property (strong, nonatomic) NSMutableArray *arrayJoiners;




@end
