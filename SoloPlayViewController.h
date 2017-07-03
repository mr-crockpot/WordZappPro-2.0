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

@property CGFloat screenWidth;
@property CGFloat screenHeight;

@end
