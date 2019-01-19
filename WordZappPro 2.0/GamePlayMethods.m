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
#import "SoloPlayViewController.h"


@implementation GamePlayMethods

-(GamePlayMethods *)initWithView:(UIView *) view selectorForWin: (SEL)winMethod delegate:(id)delegate{
    self.winMethod = winMethod;
    self.delegate = delegate;
    self.view = view;
    self.screenWidth = view.frame.size.width;
    self.screenHeight = view.frame.size.height;
    _win = NO;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"wordlist"  ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    self.masterWordList = [content componentsSeparatedByString:@"\n"];

    return self;
}

#pragma mark NEW DRAG SYSTEM
-(void) handlePan: (UIPanGestureRecognizer *) recognizer {
 
    CGPoint currentLocation = [recognizer locationInView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        for (letterButton *button in _letterButtons) {
            if (CGRectContainsPoint(button.frame, currentLocation)) {
                _currentDraggedLetterButton = button;
            }
        }
        _currentDraggedLetterButton.layer.borderWidth = 0;
        [self beginDrag:_currentDraggedLetterButton location:currentLocation];
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged && _currentDraggedLetterButton != nil) {
        _currentDraggedLetterButton.center = currentLocation;
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        for (letterButton *button in _letterButtons) {
            if (CGRectContainsPoint(button.frame, currentLocation)) {
                _currentDraggedLetterButton = button;
                [self beginDrag:_currentDraggedLetterButton location:currentLocation];
            }
        }

    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        _wasTapped = NO;
       
        [self dragStopped:_currentDraggedLetterButton];
        _currentDraggedLetterButton.layer.borderWidth = 0;
        _currentDraggedLetterButton = nil;
        
    }
}


-(void) beginDrag: (letterButton *) button location: (CGPoint) location {
    _currentDraggedLetterButton = button;
    _inPlace = NO;
    if (!button.big) {
        button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, button.frame.size.width+15, button.frame.size.height + 15);
        button.big = YES;
    }
    [self.view bringSubviewToFront:button];

}

-(void)dragStopped: (letterButton *)sender {
    CGFloat tolerance = sender.frame.size.width/1.5;
    
    if (!_wasTapped) {
        _selectedLetterButton = nil;
    }
    
    if (sender.big) {
        sender.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y, sender.frame.size.width-15, sender.frame.size.height - 15);
        sender.big = NO;
    }

    
    sender.linkedLabel.linkedButton = nil;
    sender.linkedLabel = nil;
    
    for (wordBox *label in _arrayWordBoxes) {
        if ([self distanceBetween:sender.frame and:label.frame] < tolerance) {
            if (label.linkedButton == nil) {
                sender.frame = label.frame;
                sender.linkedLabel = label;
                label.linkedButton = sender;
                [self.view bringSubviewToFront:sender];
                _inPlace = YES;
                sender.big = NO;
                
            }
        }
    }
    
    if ([self checkWords]) {
        _win = YES;
        [self stopButtons];
         
        [_delegate performSelector:_winMethod];
        
        
    }
    
    
    
}



// END NEW SYSTEM

-(NSMutableArray *)arrayOfLettersInOrder: (NSString *)fromList {
    
    NSArray *activeWordList = [[NSArray alloc] init];
    NSString *nameActiveWordList = fromList;
    
    NSArray *easyListStandard = [[NSArray alloc] init];
    NSArray *mediumListStandard = [[NSArray alloc]init];
    
    
    NSMutableArray *arrayWordTwo = [[NSMutableArray alloc] init];
    NSMutableArray *arrayWordThree = [[NSMutableArray alloc] init];
    NSMutableArray *arrayWordFour = [[NSMutableArray alloc] init];
    _arrayOfLettersInOrder = [[NSMutableArray alloc] init];
   
    NSString *pathEasy = [[NSBundle mainBundle] pathForResource:@"easyList" ofType:@"txt"];
    NSString *contentEasy = [NSString stringWithContentsOfFile:pathEasy encoding:NSUTF8StringEncoding error:nil];
    easyListStandard = [contentEasy componentsSeparatedByString:@"\n"];

    NSString *pathMedium = [[NSBundle mainBundle] pathForResource:@"mediumList" ofType:@"txt"];
    NSString *contentMedium = [NSString stringWithContentsOfFile:pathMedium encoding:NSUTF8StringEncoding error:nil];
    mediumListStandard = [contentMedium componentsSeparatedByString:@"\n"];

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
    
  //CREATE TWO PATHS. ONE IF HARD LIST, AND OTHERWISE
    
    //IF HARD LIST
    
    if ([nameActiveWordList isEqualToString: @"hardList"]) {
        
        do {randomNumber1 = arc4random_uniform(activeWordList.count);
            word4=[[activeWordList objectAtIndex:randomNumber1] uppercaseString];
            
        }
        while (word4.length != 4 || [easyListStandard containsObject:word4] || [mediumListStandard containsObject:word4]);
        
        do {randomNumber2 = arc4random_uniform(activeWordList.count);
            word3=[[activeWordList objectAtIndex:randomNumber2] uppercaseString];
            
        }
        while (word3.length != 3 || [easyListStandard containsObject:word3] || [mediumListStandard containsObject:word3]);
        
        
        do {randomNumber3 = arc4random_uniform(activeWordList.count);
            word2=[[activeWordList objectAtIndex:randomNumber3] uppercaseString];
        }
        while (word2.length != 2 || [easyListStandard containsObject:word2] || [mediumListStandard containsObject:word2]);
        
    
    }
    
    else {
    
    do {randomNumber1 = arc4random_uniform(activeWordList.count);
        word4=[[activeWordList objectAtIndex:randomNumber1] uppercaseString];
        
    }
    while (word4.length != 4);
    
    do {randomNumber2 = arc4random_uniform(activeWordList.count);
        word3=[[activeWordList objectAtIndex:randomNumber2] uppercaseString];
        
    }
    while (word3.length != 3);
    
    
    do {randomNumber3 = arc4random_uniform(activeWordList.count);
        word2=[[activeWordList objectAtIndex:randomNumber3] uppercaseString];
    }
    while (word2.length != 2);
    
        
       
    }
    
    
    
    
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
   
   
    

    return _arrayOfLettersInOrder;
}


-(NSMutableArray *)arrayOfRandomLetters: (NSMutableArray*)arrayOfLettersInOrder{
    
    _arrayOfRandomLetters = [[NSMutableArray alloc] initWithArray:_arrayOfLettersInOrder];
    
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
   
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:_pan];
    
    
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
        
        [letter setBackgroundImage:[UIImage imageNamed:@"wood.jpg"] forState:UIControlStateNormal];
  
        letter.layer.shadowColor = [[UIColor blackColor] CGColor];
        letter.layer.shadowOffset = CGSizeMake(2, 2);
        letter.layer.shadowOpacity = 0.75;
        
//        [letter addTarget:self action:@selector(wasDragged:withEvent:)forControlEvents:UIControlEventTouchDragInside];
//        [letter addTarget:self action:@selector(wasDragged:withEvent:)forControlEvents:UIControlEventTouchDragEnter];
//        
//        [letter addTarget:self action:@selector(dragStopped:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [letter addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
//        [letter addTarget:self action:@selector(buttonUntouched:) forControlEvents:UIControlEventTouchUpInside];
       
        
        
        
        [letter addTarget:self action:@selector(tapToSelectLetter:withEvent:) forControlEvents:UIControlEventTouchDown];
        [letter addTarget:self action:@selector(dragStopped:) forControlEvents:UIControlEventTouchUpInside];
        
        [_letterButtons addObject:letter];
        [self.view addSubview:letter];
    }
    
  
    return _letterButtons;
}


//TAP AND MOVE


-(void)tapToSelectLetter: (UIButton*)button withEvent: (UIEvent *)event {
    _selectedLetterButton.layer.borderWidth = 0;
    _currentDraggedLetterButton = (letterButton *)button;
    _selectedLetterButton = (letterButton *)button;
    button.layer.borderColor =[[UIColor blueColor] CGColor];
    button.layer.borderWidth = 2;
   
    _tapToMove = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToSelectDestination:)];
    [self.view addGestureRecognizer:_tapToMove];
    
    _wasTapped = YES;
}

-(void)tapToSelectDestination: (UITapGestureRecognizer *)recognizer {
    if (!_win) {
        CGPoint location = [recognizer locationInView:[recognizer.view superview]];
        _selectedLetterButton.center = location;
        
         _selectedLetterButton.layer.borderWidth = 0;
        
        [self.view bringSubviewToFront:_selectedLetterButton];
        NSLog(@"tap trigger");
        [self dragStopped:_selectedLetterButton];
        _selectedLetterButton = nil;
        [self.view removeGestureRecognizer:recognizer];
        _wasTapped = NO;
    }
}





-(float)distanceBetween:(CGRect )rect and: (CGRect ) rect2 {
    
    float deltaX = (rect.origin.x + rect.size.width/2) - (rect2.origin.x + rect.size.width/2);
    float deltaY = (rect.origin.y + rect.size.height/2) - (rect2.origin.y + rect.size.height/2);
    
    float deltaP = sqrtf(deltaX*deltaX + deltaY*deltaY);
    
    
    return fabsf(deltaP);
}


-(void) handleDrag: (UIButton *)button withLocation:(CGPoint) location {
    button.center = location;
    [self.view bringSubviewToFront:button];
}
-(IBAction)wasDragged: (UIButton *)button withEvent: (UIEvent *)event {
//    UITouch *touch = [[event touchesForView:button]anyObject];
//    CGPoint previousLocation = [touch previousLocationInView:button];
//    CGPoint location = [touch locationInView:button];
//    CGFloat deltaX = location.x - previousLocation.x;
//    CGFloat deltaY = location.y - previousLocation.y;
//    if (fabs(deltaX)>5 || fabs(deltaY)>5) {
//        [self.view removeGestureRecognizer:_tapToMove];
//        _selectedLetterButton = nil;
//    }
//    button.center = CGPointMake(button.center.x + deltaX, button.center.y + deltaY);
//    [self.view bringSubviewToFront:button];

    
    UITouch *touch = [[event touchesForView:button]anyObject];
    CGPoint location = [touch locationInView:self.view];
    [self handleDrag:button withLocation: location];
    
    
    }

-(void)buttonTouched: (letterButton*)button{
    
    _inPlace = NO;
    if (!button.big) {
        button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, button.frame.size.width+15, button.frame.size.height + 15);
        button.big = YES;
    }
}

-(void)buttonUntouched: (letterButton*)button{
    if (!_inPlace) {
        button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, button.frame.size.width -15, button.frame.size.height - 15);
        button.big = NO;
    }
}



-(void)stopButtons {
    [self.view removeGestureRecognizer:_pan];
    [self.view removeGestureRecognizer:_tapToMove];

    for (int x =0; x<9; x++) {
        letterButton *buttonToStop = (letterButton *)[_letterButtons objectAtIndex:x];
        [buttonToStop removeTarget:self action:@selector(tapToSelectLetter:withEvent:) forControlEvents:UIControlEventTouchDown];
        [buttonToStop removeTarget:self action:@selector(dragStopped:) forControlEvents:UIControlEventTouchUpInside];

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
        wordSquare.layer.shadowColor = [[UIColor blackColor] CGColor];
        wordSquare.layer.shadowOffset = CGSizeMake(2,2);
        wordSquare.layer.shadowOpacity = 1.0;
        
        
        
        [_arrayWordBoxes addObject:wordSquare];
        [self.view addSubview:wordSquare];
        
      
        
        
    }
    return _arrayWordBoxes;
}


-(void)revealWord: (NSMutableArray *) revealLetters {
    
       
    for (letterButton *button in _letterButtons) {
        [button removeFromSuperview];
    }
    
    for (int i = 0; i<revealLetters.count; i++) {
        wordBox *label = ((wordBox *)_arrayWordBoxes[i]);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"Helvetica" size:0.8*(_screenWidth/8)];
        label.textColor = [UIColor redColor];
        label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood.jpg"]];
        
        
        
        _light2.backgroundColor= [UIColor greenColor];
        _light3.backgroundColor = [UIColor greenColor];
        _light4.backgroundColor = [UIColor greenColor];
        
        label.text = revealLetters[i];
    }
    
    
}





@end
