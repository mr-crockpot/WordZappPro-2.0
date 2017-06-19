//
//  HeadPlayViewController.h
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GamePlayMethods.h"


@interface HeadPlayViewController : UIViewController

@property NSString *strIncomingLetters;

@property (strong, nonatomic) IBOutlet UILabel *labelLetters;
@property GamePlayMethods *calledMethod;

//LIGHTS
@property NSArray *lights;
//LETTERS
@property (strong, nonatomic) NSMutableArray *letterTiles;
//WORDS
@property (strong, nonatomic) NSMutableArray *wordBoxes;



@end
