//
//  HighScoresViewController.h
//  WordZappPro 2.0
//
//  Created by Adam Schor on 8/12/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HighScoresViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *tblViewHighScores;

@property (strong, nonatomic) NSMutableArray *arrayTopScores;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentHighScores;

- (IBAction)segmentHighScoresChanged:(id)sender;

@property (strong, nonatomic) NSString *level;

@end
