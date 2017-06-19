//
//  GamePlayMethods.h
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface GamePlayMethods : NSObject

@property UIView *view;
-(GamePlayMethods *)initWithView:(UIView *) view;

@property CGFloat screenWidth;
@property CGFloat screenHeight;





//SET UP LIGHTS
@property (strong,nonatomic) UILabel *light2;
@property (strong,nonatomic) UILabel *light3;
@property (strong,nonatomic) UILabel *light4;
-(NSArray *)setUpLights;
//SET UP LETTERS
-(NSMutableArray *)setUpLetterButtons;

@property NSMutableArray *letterButtons;

+(NSMutableArray *)arrayOfLetters: (NSString *)fromList;

//SET UP WORD BOXES
@property (strong, nonatomic) NSMutableArray *arrayWordBoxes;
-(NSMutableArray *)setupWordBoxes;

@property NSArray *masterWordList;

//SET UP TIMER LABEL
-(UILabel *)setUpTimerLabel;

@property NSTimer *timer;
@property int startTimerValue;
@property (strong,nonatomic) UILabel *labelTimer;





@end
