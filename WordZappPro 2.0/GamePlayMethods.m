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

-(GamePlayMethods *)initWithView:(UIView *) view selectorForWin: (SEL)winMethod delegate:(id)delegate{
    self.winMethod = winMethod;
    self.delegate = delegate;
    self.view = view;
    self.screenWidth = view.frame.size.width;
    self.screenHeight = view.frame.size.height;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"wordlist"  ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    self.masterWordList = [content componentsSeparatedByString:@"\n"];    return self;
}



-(NSMutableArray *)arrayOfLettersInOrder: (NSString *)fromList {
    
    NSArray *activeWordList = [[NSArray alloc] init];
    NSString *nameActiveWordList = fromList;
    
    NSMutableArray *arrayWordTwo = [[NSMutableArray alloc] init];
    NSMutableArray *arrayWordThree = [[NSMutableArray alloc] init];
    NSMutableArray *arrayWordFour = [[NSMutableArray alloc] init];
    _arrayOfLettersInOrder = [[NSMutableArray alloc] init];
    
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
    
    
    
    for (int w = 1; w<3; w++) {
        NSString *eachLetter = [NSString stringWithFormat:@"%c", [word2 characterAtIndex:w-1]];
        [_arrayOfLettersInOrder addObject:eachLetter];
        
    }
    
    for (int w = 1; w<4; w++) {
        NSString *eachLetter = [NSString stringWithFormat:@"%c", [word3 characterAtIndex:w-1]];
        [_arrayOfLettersInOrder addObject:eachLetter];
        
        
    }
    
    for (int w = 1; w<5; w++) {
        NSString *eachLetter = [NSString stringWithFormat:@"%c", [word4 characterAtIndex:w-1]];
        [_arrayOfLettersInOrder addObject:eachLetter];
        
    }
    NSLog(@"array set to: %@", _arrayOfLettersInOrder);

    return _arrayOfLettersInOrder;
}


-(NSMutableArray *)arrayOfRandomLetters: (NSMutableArray*)arrayOfLettersInOrder{
    
    _arrayOfRandomLetters = [[NSMutableArray alloc] initWithArray:arrayOfLettersInOrder];
    
    NSUInteger countLetters;
    countLetters = arrayOfLettersInOrder.count;
    
    int z;
    
    for (z=0; z<countLetters; z++) {
        u_int32_t countRemaining;
        
        countRemaining = countLetters - z;
        
        int exchangeIndex = z + arc4random_uniform(countRemaining);
        [_arrayOfRandomLetters exchangeObjectAtIndex:z withObjectAtIndex:exchangeIndex];
    }
    return _arrayOfRandomLetters;
    
    
    
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
        
        [_delegate performSelector:_winMethod];
        
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
    
    _startTimerValue = 6;
    
    _labelTimer = [[UILabel alloc] initWithFrame:CGRectMake(_screenWidth/2-_screenWidth/6, _screenHeight-_screenHeight/15, _screenWidth/3, _screenHeight/15)];
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

-(void)timerCountDown{
    
    _startTimerValue = _startTimerValue - 1;
    _labelTimer.text = [NSString stringWithFormat:@"%i",_startTimerValue];
    
    NSDateComponentsFormatter *componentFormatter = [[NSDateComponentsFormatter alloc] init];
    componentFormatter.unitsStyle = NSDateComponentsFormatterUnitsStylePositional;
    componentFormatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorDefault;
    
    NSTimeInterval interval = _startTimerValue;
    NSString *formattedString = [componentFormatter stringFromTimeInterval:interval];
    
    _labelTimer.text = formattedString;
    
    
    
    if (_startTimerValue <11) {
        _labelTimer.backgroundColor = [UIColor redColor];
        _labelTimer.textColor = [UIColor yellowColor];
        _labelTimer.clipsToBounds = YES;
    }
    else {_labelTimer.backgroundColor = [UIColor whiteColor];
        _labelTimer.textColor = [UIColor blackColor];
    }
    
    if (_startTimerValue == 0) {
        UILabel *labelGameOver = [[UILabel alloc] init];
        labelGameOver.frame = CGRectMake(20, _screenHeight * .15, _screenWidth - 40, _screenHeight*.37);
        labelGameOver.layer.borderColor = [[UIColor redColor] CGColor];
        labelGameOver.layer.borderWidth = 2;
        labelGameOver.backgroundColor = [UIColor yellowColor];
        labelGameOver.textColor = [UIColor redColor];
        labelGameOver.layer.cornerRadius = 15;
        labelGameOver.clipsToBounds = YES;
        labelGameOver.text = @"Game Over";
        labelGameOver.font = [UIFont fontWithName:@"Courier" size:_screenHeight*.4*.2];
        labelGameOver.textAlignment = NSTextAlignmentCenter;
        [self stopButtons];
        
     //   [self saveHighscore];
        
        [self.view addSubview:labelGameOver];
  //      _points = 0;
        _startTimerValue = 6;
        [_timer invalidate];
        
        
        NSLog(@"Timer countdown say letters in order %@",_arrayOfLettersInOrder);
        [UIView animateWithDuration:4 animations:^{
            labelGameOver.alpha = 0;
        } completion:^(BOOL finished) {
            [self revealWord: _arrayOfLettersInOrder];
            
        }];
        
        
        
        
        
        
        
    }
    
    
    
}



-(void)stopTimer {
    [_timer invalidate];
}

-(void)winSolo{
    NSArray *arraySplashWords = [[NSArray alloc] initWithObjects:@"Hooray",@"Terrific",@"Wow",@"Nifty",@"Amazing",@"Yahoo!",@"Great",@"Brilliant",@"Inspiring",@"Yay", nil];
    NSArray *arraySplashColors = [[NSArray alloc] initWithObjects:[UIColor redColor],[UIColor blueColor],[UIColor purpleColor],[UIColor orangeColor],[UIColor magentaColor], nil];
    
    NSArray *arrayX = [[NSArray alloc]initWithObjects:@5 ,@-5, @5, @-5, @0.2, @10, nil];
    NSArray *arrayY = [[NSArray alloc]initWithObjects:@-5,@5 , @5, @-5, @0.2, @10, nil];
    
    
    int randomNumberWord = arc4random_uniform(arraySplashWords.count);
    int randomNumberColor = arc4random_uniform(arraySplashColors.count);
    //int randomNumberScale = arc4random_uniform(arrayScales.count);
    
    NSString *splashWord = [arraySplashWords objectAtIndex:randomNumberWord];
    UIColor *splashColor = [arraySplashColors objectAtIndex:randomNumberColor];
    //randomScale = [[arrayScales objectAtIndex:randomNumberScale] floatValue];
    
    
    
    UILabel *winLabel = [[UILabel alloc] init];
    winLabel.frame = CGRectMake(0, _screenHeight*.65, _screenWidth,_screenHeight*.3);
    winLabel.text = splashWord;
    winLabel.textColor = splashColor;
    
    winLabel.font = [UIFont fontWithName:@"Helvetica" size:_screenWidth * 0.05];
    winLabel.backgroundColor = [UIColor clearColor];
    winLabel.layer.cornerRadius = _screenHeight*.05;
    //winLabel.layer.borderColor = [[UIColor redColor] CGColor];
    //winLabel.layer.borderWidth = 2;
    winLabel.clipsToBounds = YES;
    winLabel.alpha = 1;
    winLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:winLabel];
    [self.view bringSubviewToFront:winLabel];
    
    
    
    
    
    int rand_index = ((arc4random() % arrayX.count));
    //int rand_index = 0;
    [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        winLabel.alpha = 1;
        //winLabel.frame = CGRectMake(-_screenWidth, _screenHeight*.7, _screenWidth*.5, _screenHeight*.1);
        // CGAffineTransform affineTransform = CGAffineTransformMakeRotation(degreesToRadians(-270));
        
        if (fabs([arrayX[rand_index]floatValue])<1)
        {
            winLabel.font = [UIFont fontWithName:@"Helvetica" size:_screenWidth * 0.2];
        }
        CGAffineTransform affineScale = CGAffineTransformMakeScale([arrayX[rand_index] floatValue], [arrayY[rand_index] floatValue]);
        
        // winLabel.transform = affineTransform;
        winLabel.transform = affineScale;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
            CGAffineTransform affineScale = CGAffineTransformMakeScale(fabs([arrayX[rand_index] floatValue]), fabs([arrayY[rand_index] floatValue]));
            winLabel.transform = affineScale;
        } completion:^(BOOL finished) {
            //  _buttonAgain.enabled = YES;
            //  _buttonAgain.alpha = 1;
            winLabel.alpha = 0;
        }];
    }];
    
    
}

-(void)revealWord: (NSArray *) letters{
   
    for (letterButton *button in _letterButtons) {
        [button removeFromSuperview];
    }
    
    for (int i = 0; i<letters.count; i++) {
        wordBox *label = ((wordBox *)_arrayWordBoxes[i]);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"Helvetica" size:0.8*(_screenWidth/8)];
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tile.png"]];
        
        
        _light2.backgroundColor= [UIColor greenColor];
        _light3.backgroundColor = [UIColor greenColor];
        _light4.backgroundColor = [UIColor greenColor];
        
        label.text = letters[i];
    }
  //  _buttonAgain.enabled = YES;
  //  _buttonAgain.alpha = 1;
    
}


@end
