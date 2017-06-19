//
//  GamePlayMethods.m
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import "GamePlayMethods.h"
#import "letterButton.h"
#import "wordBox.h"


@implementation GamePlayMethods

-(GamePlayMethods *)initWithView:(UIView *) view {
    self.view = view;
    self.screenWidth = view.frame.size.width;
    self.screenHeight = view.frame.size.height;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"wordlist"  ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    self.masterWordList = [content componentsSeparatedByString:@"\n"];    return self;
}



+(NSMutableArray *)arrayOfLetters: (NSString *)fromList {
    
    NSArray *activeWordList = [[NSArray alloc] init];
    NSString *nameActiveWordList = fromList;
    
    NSMutableArray *arrayWordTwo = [[NSMutableArray alloc] init];
    NSMutableArray *arrayWordThree = [[NSMutableArray alloc] init];
    NSMutableArray *arrayWordFour = [[NSMutableArray alloc] init];
    NSMutableArray *arrayRandomLetters = [[NSMutableArray alloc] init];
    NSMutableArray *arrayLettersInOrder = [[NSMutableArray alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:nameActiveWordList ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    activeWordList = [content componentsSeparatedByString:@"\n"];
    
   
    
    arrayWordTwo = [[NSMutableArray alloc] initWithObjects:@"",@"", nil];
    arrayWordThree = [[NSMutableArray alloc] initWithObjects:@"",@"",@"", nil];
    arrayWordFour = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"", nil];
    
    NSString *word4;
    NSString *word3;
    NSString *word2;
    
    
    
    int randomNumber1;
    int randomNumber2;
    int randomNumber3;
    
    do {randomNumber1 = arc4random_uniform(activeWordList.count);
        word4=[[activeWordList objectAtIndex:randomNumber1] uppercaseString];
        
    }
    while (word4.length != 4);//was 6 and so on
    
    
    do {randomNumber2 = arc4random_uniform(activeWordList.count);
        word3=[[activeWordList objectAtIndex:randomNumber2] uppercaseString];
        
    }
    while (word3.length != 3);
    
    
    do {randomNumber3 = arc4random_uniform(activeWordList.count);
        word2=[[activeWordList objectAtIndex:randomNumber3] uppercaseString];
    }
    while (word2.length != 2);
    
    
    NSLog(@"the words are %@ %@ %@",word2,word3,word4);
    
    //randomize the letters
    
    arrayRandomLetters = [[NSMutableArray alloc] init];
    
    
    for (int w = 1; w<3; w++) {
        NSString *eachLetter = [NSString stringWithFormat:@"%c", [word2 characterAtIndex:w-1]];
        [arrayRandomLetters addObject:eachLetter];
        
    }
    
    for (int w = 1; w<4; w++) {
        NSString *eachLetter = [NSString stringWithFormat:@"%c", [word3 characterAtIndex:w-1]];
        [arrayRandomLetters addObject:eachLetter];
        
        
    }
    
    for (int w = 1; w<5; w++) {
        NSString *eachLetter = [NSString stringWithFormat:@"%c", [word4 characterAtIndex:w-1]];
        [arrayRandomLetters addObject:eachLetter];
        
    }
    
    arrayLettersInOrder = [[NSMutableArray alloc] initWithArray:arrayRandomLetters];
    
    
    //randomize the letterArray
    
    
    NSUInteger countLetters;
    countLetters = arrayRandomLetters.count;
    
    
    int z;
    
    for (z=0; z<countLetters; z++) {
        u_int32_t countRemaining;
        
        countRemaining = countLetters - z;
        
        int exchangeIndex = z + arc4random_uniform(countRemaining);
        [arrayRandomLetters exchangeObjectAtIndex:z withObjectAtIndex:exchangeIndex];
}
    
    return arrayRandomLetters;
}

#pragma mark SET UP SCREEN

-(NSArray *)setUpLights {
    
    CGFloat screenHeight = _view.frame.size.height;
    CGFloat boxWidth = _screenWidth/10;
    CGFloat boxHeight = boxWidth;
    
    CGFloat paddingTop = 0;
  
    _light2 = [[UILabel alloc]init];
    _light2.frame = CGRectMake(0, screenHeight*.45 + paddingTop, boxWidth, boxHeight);
    _light2.layer.cornerRadius = boxHeight/2;
    _light2.clipsToBounds = YES;
    _light2.backgroundColor = [UIColor redColor];
    [_view addSubview:_light2];
    
    _light3 = [[UILabel alloc]init];
    _light3.frame = CGRectMake(0, screenHeight*.3 + paddingTop, boxWidth, boxHeight);
    _light3.layer.cornerRadius = boxHeight/2;
    _light3.clipsToBounds = YES;
    _light3.backgroundColor = [UIColor redColor];
    [_view addSubview:_light3];
    
    _light4 = [[UILabel alloc]init];
    _light4.frame = CGRectMake(0, screenHeight*.15 + paddingTop, boxWidth, boxHeight);
    _light4.layer.cornerRadius = boxHeight/2;
    _light4.clipsToBounds = YES;
    _light4.backgroundColor = [UIColor redColor];
    [_view addSubview:_light4];
    
    
    return [NSArray arrayWithObjects:_light2, _light3, _light4, nil];
}

//SET UP LETTER TILES

-(NSMutableArray *)setUpLetterButtons{
    
    letterButton *letter;
    _letterButtons = [[NSMutableArray alloc] init];
    CGFloat boxWidth = _screenWidth/8;
    CGFloat boxHeight = boxWidth;
    CGFloat xPositionFactorRow1 = 5;
    CGFloat xPositionFactorRow2 = 5;
    CGFloat paddingTop = 0;
    
    for (int y = 0; y < 9; y++) {
        letter = [[letterButton alloc] init];
        
        if (y < 4) {
            letter.frame = CGRectMake(10 + boxWidth + _screenWidth/xPositionFactorRow1   * y, _screenHeight*.7 + paddingTop, boxWidth, boxHeight);
        }
        
        else if (y < 9) {
            letter.frame = CGRectMake(20 + _screenWidth/xPositionFactorRow2 * (y-4), _screenHeight*.8 + paddingTop, boxWidth, boxHeight);
        }
        
        [letter setBackgroundImage:[UIImage imageNamed:@"tile.png"] forState:UIControlStateNormal];
        letter.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:boxWidth*.9];
        [letter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [letter addTarget:self action:@selector(wasDragged:withEvent:)forControlEvents:UIControlEventTouchDragInside];
        [letter addTarget:self action:@selector(dragStopped:) forControlEvents:UIControlEventTouchUpInside];
        
       
        
        [_letterButtons addObject:letter];
        [self.view addSubview:letter];
    }
    
    return _letterButtons;
}



//TOUCH AND DRAG


-(float)distanceBetween:(CGRect )rect and: (CGRect ) rect2 {
    
    float deltaX = (rect.origin.x + rect.size.width/2) - (rect2.origin.x + rect.size.width/2);
    float deltaY = (rect.origin.y + rect.size.height/2) - (rect2.origin.y + rect.size.height/2);
    
    float deltaP = sqrtf(deltaX*deltaX + deltaY*deltaY);
    
    
    return fabsf(deltaP);
}


-(IBAction)wasDragged: (UIButton *)button withEvent: (UIEvent *)event {
        UITouch *touch = [[event touchesForView:button]anyObject];
        CGPoint previousLocation = [touch previousLocationInView:button];
        CGPoint location = [touch locationInView:button];
        CGFloat deltaX = location.x - previousLocation.x;
        CGFloat deltaY = location.y - previousLocation.y;
        button.center = CGPointMake(button.center.x + deltaX, button.center.y + deltaY);
        [self.view bringSubviewToFront:button];
   
    }

-(void)dragStopped: (letterButton *)sender {
    
    CGFloat tolerance = sender.frame.size.width/1.5;
    
    
    
    sender.linkedLabel.linkedButton = nil;
    sender.linkedLabel = nil;
    
    for (wordBox *label in _arrayWordBoxes) {
        if ([self distanceBetween:sender.frame and:label.frame] < tolerance) {
            if (label.linkedButton == nil) {
                sender.frame = label.frame;
                sender.linkedLabel = label;
                label.linkedButton = sender;
                
            }
        }
    }
    
    if ([self checkWords]) {
        [self stopButtons];
        NSLog(@"Done");
// TODO: tell other player they lose here
    }
    
    
    
}

-(void)stopButtons {
    for (int x =0; x<9; x++) {
        letterButton *buttonToStop = (letterButton *)[_letterButtons objectAtIndex:x];
        
        [buttonToStop removeTarget:self action:@selector(wasDragged:withEvent:) forControlEvents:UIControlEventAllEvents];
        [buttonToStop removeTarget:self action:@selector(dragStopped:) forControlEvents:UIControlEventAllEvents];
        
        
    }
}

-(BOOL) checkWords {
    
    NSMutableArray *letters = [[NSMutableArray alloc] init];
    
    for (wordBox *label in _arrayWordBoxes) {
        if (label.linkedButton.titleLabel.text != nil) {
            [letters addObject:label.linkedButton.titleLabel.text];
        } else {
            [letters addObject:@" -"];
        }
    }
    
    NSString *word4 = [NSString stringWithFormat:@"%@%@%@%@", letters[5], letters[6], letters[7], letters[8]];
    NSString *word3 = [NSString stringWithFormat:@"%@%@%@", letters[2], letters[3], letters[4]];
    NSString *word2 = [NSString stringWithFormat:@"%@%@", letters[0], letters[1]];
    NSLog(@"%@ (%d), %@ (%d), %@ (%d)", word2, [_masterWordList containsObject:word2], word3, [_masterWordList containsObject:word3], word4, [_masterWordList containsObject:word4]);
    
    if ([_masterWordList containsObject:word4]) {
        _light4.backgroundColor = [UIColor greenColor];}
    else {
        _light4.backgroundColor = [UIColor redColor];
        
    }
    
    
    if ([_masterWordList containsObject:word3]) {
        _light3.backgroundColor = [UIColor greenColor];}
    else {
        _light3.backgroundColor = [UIColor redColor];
        
    }
    
    if ([_masterWordList containsObject:word2]) {
        _light2.backgroundColor = [UIColor greenColor];}
    else {
        _light2.backgroundColor = [UIColor redColor];
        
    }
    
    
    return ([_masterWordList containsObject:word4] && [_masterWordList containsObject:word3] && [_masterWordList containsObject:word2]);
    
}



//SET UP WORD BOXES

-(NSMutableArray *)setupWordBoxes{
    _arrayWordBoxes = [[NSMutableArray alloc] init];
    wordBox *wordSquare =[[wordBox alloc] init];
    CGFloat boxWidth = _screenWidth/8;
    CGFloat boxHeight = boxWidth;
    CGFloat xPositionFactor = 5;
    CGFloat paddingTop = 0;
    
    for (int x = 0; x<9; x++) {
        
        
        if (x<2) {
            
            wordSquare = [[wordBox alloc] initWithFrame:CGRectMake(_screenWidth/xPositionFactor * (x+1), _screenHeight*.45 + paddingTop, boxWidth, boxHeight)];
        }
        
        else if (x <5){
            wordSquare = [[wordBox alloc] initWithFrame:CGRectMake(_screenWidth/xPositionFactor * (x+1-2), _screenHeight*.3 + paddingTop, boxWidth, boxHeight)];
            
        }
        
        else if (x <9){
            wordSquare = [[wordBox alloc] initWithFrame:CGRectMake(_screenWidth/xPositionFactor * (x+1-5), _screenHeight*.15 + paddingTop, boxWidth, boxHeight)];
            
        }
        
        wordSquare.layer.borderColor = [[UIColor blackColor] CGColor];
        wordSquare.layer.borderWidth = 2;
        
        wordSquare.backgroundColor = [UIColor whiteColor];
        
        [_arrayWordBoxes addObject:wordSquare];
        [self.view addSubview:wordSquare];
        
        
        
    }
    return _arrayWordBoxes;
}

//TIMER

-(UILabel *)setUpTimerLabel {
    
    _startTimerValue = 60;
    CGFloat paddingTop = 0;
    
    _labelTimer = [[UILabel alloc] initWithFrame:CGRectMake(0, _screenHeight*.05 + paddingTop, _screenWidth/3, _screenHeight/15)];
    _labelTimer.backgroundColor = [UIColor clearColor];
    _labelTimer.textColor = [UIColor blackColor];
    _labelTimer.text = [NSString stringWithFormat:@"%i",_startTimerValue];
    _labelTimer.layer.borderWidth = 2;
    _labelTimer.layer.borderColor = [[UIColor blackColor] CGColor];
    _labelTimer.font = [UIFont fontWithName:@"Helvetica" size:_screenHeight/10*.6];
    _labelTimer.textAlignment = NSTextAlignmentCenter;
    _labelTimer.layer.cornerRadius = _screenHeight/15/2;
    
    _labelTimer.backgroundColor = [UIColor whiteColor];
    _labelTimer.clipsToBounds = YES;
    
    
    
    NSDateComponentsFormatter *componentFormatter = [[NSDateComponentsFormatter alloc] init];
    componentFormatter.unitsStyle = NSDateComponentsFormatterUnitsStylePositional;
    componentFormatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorDefault;
    
    NSTimeInterval interval = _startTimerValue;
    NSString *formattedString = [componentFormatter stringFromTimeInterval:interval];
    
    _labelTimer.text = formattedString;
    
    
    [self.view addSubview:_labelTimer];
    
     _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCountDown) userInfo:nil repeats:YES];
    
    return _labelTimer;
    
    
}

-(void)timerCountDown {
    _startTimerValue = _startTimerValue - 1;
    _labelTimer.text = [NSString stringWithFormat:@"%i",_startTimerValue];
    
    NSDateComponentsFormatter *componentFormatter = [[NSDateComponentsFormatter alloc] init];
    componentFormatter.unitsStyle = NSDateComponentsFormatterUnitsStylePositional;
    componentFormatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorDefault;
    
    NSTimeInterval interval = _startTimerValue;
    NSString *formattedString = [componentFormatter stringFromTimeInterval:interval];
    
    _labelTimer.text = formattedString;}
// TODO: Add timer functionality


@end
