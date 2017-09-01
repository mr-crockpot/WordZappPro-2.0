//
//  SoloPlayViewController.h
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GamePlayMethods.h"


@interface SoloPlayViewController : UIViewController
@property (strong,nonatomic) NSString *strIncomingLetters;
@property (strong,nonatomic) NSMutableArray *lettersInOrder;


@property GamePlayMethods *calledMethod;

//LIGHTS
@property NSArray *lights;
//LETTERS
@property (strong, nonatomic) NSMutableArray *letterTiles;
//WORDS
@property (strong, nonatomic) NSMutableArray *wordBoxes;

//TIMER
@property (strong, nonatomic) UILabel *labelTimer;
@property int startTimerValue;
@property NSTimer *timer;

@property CGFloat screenWidth;
@property CGFloat screenHeight;

@property BOOL GameOver;


@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnAgain;
- (IBAction)btnAgainPressed:(id)sender;

@property (strong,nonatomic) NSString *level;

@property NSMutableArray *arrayOfRandomLetters;
@property NSMutableArray *arrayOfLettersInOrder;
@property GamePlayMethods *gamePlayMethods;
@property NSString *letters;

@property int timerValue;

//SCORE
@property UILabel *labelScore;
@property int score;

- (IBAction)viewTapped:(id)sender;



@end
