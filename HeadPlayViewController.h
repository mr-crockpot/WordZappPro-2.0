//
//  HeadPlayViewController.h
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

#import "GamePlayMethods.h"
#import "AppDelegate.h"


@interface HeadPlayViewController : UIViewController 

@property GamePlayMethods *gamePlayMethods;

@property NSString *strIncomingLetters;

@property (strong, nonatomic) IBOutlet UILabel *labelLetters;
@property GamePlayMethods *calledMethod;

@property (strong, nonatomic) NSString *playerName;


//LIGHTS
@property NSArray *lights;
//LETTERS
@property (strong, nonatomic) NSMutableArray *letterTiles;
//WORDS
@property (strong, nonatomic) NSMutableArray *wordBoxes;

//COMMUNICATION
@property (nonatomic, strong) AppDelegate *appDelegate;

@end
