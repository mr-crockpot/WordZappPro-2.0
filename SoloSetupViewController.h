//
//  SoloSetupViewController.h
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GamePlayMethods.h"

@interface SoloSetupViewController : UIViewController

- (IBAction)btnEasyPressed:(id)sender;
- (IBAction)btnMediumPressed:(id)sender;
- (IBAction)btnHardPressed:(id)sender;


@property NSString *theWords;
@property NSString *letters;
@property NSString *level;

@property NSMutableArray *arrayOfRandomLetters;
@property NSMutableArray *arrayOfLettersInOrder;

@property GamePlayMethods *gamePlayMethods;

@property (strong, nonatomic) IBOutlet UIButton *btnEasy;
@property (strong, nonatomic) IBOutlet UIButton *btnMedium;
@property (strong, nonatomic) IBOutlet UIButton *btnHard;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *levelButtons;

@property (strong, nonatomic) IBOutlet UILabel *lblSolo;



@end
