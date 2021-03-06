//
//  GamePlayMethods.h
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "letterButton.h"

@interface GamePlayMethods : NSObject

@property UIView *view;
-(GamePlayMethods *)initWithView:(UIView *) view selectorForWin: (SEL)winMethod delegate:(id)delegate;

@property CGFloat screenWidth;
@property CGFloat screenHeight;



@property BOOL win;




//SET UP LIGHTS
@property (strong,nonatomic) UILabel *light2;
@property (strong,nonatomic) UILabel *light3;
@property (strong,nonatomic) UILabel *light4;
-(NSArray *)setUpLights;
//SET UP LETTERS
-(NSMutableArray *)setUpLetterButtons;

@property SEL winMethod;
@property id delegate;


@property NSMutableArray *letterButtons;

-(NSMutableArray *)arrayOfLettersInOrder: (NSString *)fromList;
-(NSMutableArray *)arrayOfRandomLetters: (NSMutableArray*)arrayOfLettersInOrder;


@property NSMutableArray *arrayOfLettersInOrder;

@property NSMutableArray *arrayOfRandomLetters;

@property letterButton *currentDraggedLetterButton;

@property UIPanGestureRecognizer *pan;

@property BOOL wasTapped;


//SET UP WORD BOXES
@property (strong, nonatomic) NSMutableArray *arrayWordBoxes;
-(NSMutableArray *)setupWordBoxes;

@property NSArray *masterWordList;

@property letterButton *selectedLetterButton;
@property UIGestureRecognizer *tapToMove;

-(void)stopButtons;


//REVEAL
-(void)revealWord: (NSArray *) letters;

//TILE DRAG
@property BOOL inPlace;






@end
