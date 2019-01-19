//
//  SoloPlayViewController.m
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import "SoloPlayViewController.h"
#import "GamePlayMethods.h"
#import "UserDefaults.h"



@interface SoloPlayViewController ()

@end

@implementation SoloPlayViewController


- (void)viewDidLoad {
    _btnAgain.alpha = 0;
    _Winner = NO;
    _startTimerValue = 60;
    _timerValue = _startTimerValue;
    _gamePlayMethods = [[GamePlayMethods alloc] init];
    
  self.navigationItem.hidesBackButton = YES;
  self.navigationController.navigationBar.hidden = YES;
   
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"whiteStone.jpg"]];
    
    _screenWidth  = [UIScreen mainScreen].bounds.size.width;
    _screenHeight = [UIScreen mainScreen].bounds.size.height;
    _calledMethod = [[GamePlayMethods alloc] initWithView:self.view selectorForWin:@selector(win) delegate:self];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self getLetters];
        [self setUpAgainButton];
        [self setUpBackButton];
        [self setUpLetters];
        [self setUpLights];
        [self setUpWordBoxes];
        [self setUpTimerLabel];
        [self setUpScoreLabel];
    
    });
    
    [super viewDidLoad];
     
    // Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated{
    if (_timerValue>0) {
        [self saveHighscore];
     
    }
    
}

-(void)setUpAgainButton{

    _btnAgain.frame = CGRectMake(_screenWidth/2-_screenWidth/6, _screenHeight- _screenHeight/15, _screenWidth/3 ,_screenHeight/15);
    [_btnAgain setTitle:@"Again" forState:UIControlStateNormal];
    _btnAgain.titleLabel.textColor = [UIColor redColor];
    _btnAgain.layer.borderWidth = 2;
    _btnAgain.layer.borderColor = [[UIColor brownColor] CGColor];
    _btnAgain.layer.cornerRadius = 15;
    _btnAgain.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    _btnAgain.titleLabel.textColor = [UIColor blackColor];
    _btnAgain.layer.shadowColor = [[UIColor blackColor] CGColor];
    _btnAgain.layer.shadowOffset = CGSizeMake(5.0, 5.0);
    _btnAgain.layer.shadowOpacity = 0.5;
   
    _btnAgain.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood.jpg"]];
    
    
}

-(void)setUpBackButton{
    _btnBack.frame = CGRectMake(_screenWidth/2-_screenWidth/8, 0, _screenWidth/4, _screenHeight/15);
    _btnBack.layer.borderWidth = 2;
    _btnBack.layer.borderColor = [[UIColor blueColor] CGColor];
    _btnBack.layer.cornerRadius = 15;
    _btnBack.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    _btnBack.titleLabel.textColor = [UIColor blueColor];
    
    
}

-(void)exitGameAlert{
    
    [_timer invalidate];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = self.view.frame;
   
    UIAlertController *exitAlert = [UIAlertController alertControllerWithTitle:@"Back So Soon?" message:@"Are you sure you want to end round early?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
         [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    
        
    }];
    
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
       [visualEffectView removeFromSuperview];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCountDown) userInfo:nil repeats:YES];
    
    
    }];
    [exitAlert addAction:yes];
    [exitAlert addAction:no];
    
     [self.view addSubview:visualEffectView];
     [self presentViewController:exitAlert animated:YES completion:nil];

    
}

-(void)runGameReset{
    
    for (UIButton *removeButton in _letterTiles) {
        [removeButton removeFromSuperview];
    }
    for (UILabel *removeBox in _wordBoxes) {
        [removeBox removeFromSuperview];
    }
    [self getLetters];
    [self setUpLetters];
    [self setUpWordBoxes];
    [self setUpTimerLabel];
    
    
    
}
-(void) win {
    _score = _score + 10 +_timerValue;
     _labelScore.text = [NSString stringWithFormat:@"%i",_score];
    [self stopTimer];
    [self winSolo];

    
  }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getLetters{
    
   _arrayOfLettersInOrder = [[NSMutableArray alloc]initWithArray:[_gamePlayMethods arrayOfLettersInOrder:_level]];
    [self randomizeLetters];
    
}

-(void)randomizeLetters{
     _arrayOfRandomLetters = [[NSMutableArray alloc] initWithArray:[_gamePlayMethods arrayOfRandomLetters:_arrayOfLettersInOrder]];
    
   for (int x=0; x<9; x++) {
        if (x!=0){
            _letters = [NSString stringWithFormat:@"%@%@",_letters,_arrayOfRandomLetters[x]];
        } else {
            _letters = [NSString stringWithFormat:@"%@",_arrayOfRandomLetters[x]];
        }
        
    }
   
    }

-(void)setUpLights {
    _lights = [_calledMethod setUpLights];
    
}
-(void)setUpLetters{
    CGFloat boxWidth = self.view.frame.size.width/8;
    _letterTiles = [_calledMethod setUpLetterButtons];
    for (int y =0; y<9; y++) {
        
        NSString *theLetter = [NSString stringWithFormat:@"%c",[_letters characterAtIndex:y]];
        
        UIColor *letterColor = [UIColor blackColor];
        UIFont  *letterFont = [UIFont fontWithName:@"Helvetica" size:boxWidth*.8];
        
        
        NSDictionary *attributes = @{ NSForegroundColorAttributeName: letterColor,
                                      NSFontAttributeName: letterFont,
                                      NSTextEffectAttributeName: NSTextEffectLetterpressStyle};
        
        
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:theLetter
                                                                             attributes:attributes];
        
        
        
        [(UIButton *)[_letterTiles objectAtIndex:y] setAttributedTitle: attributedText forState: UIControlStateNormal];
        [(UIButton *)[_letterTiles objectAtIndex:y] setTag:y];
        
    }
    
}

-(void)setUpWordBoxes {
    _wordBoxes = [_calledMethod setupWordBoxes];
    
}


- (IBAction)btnAgainPressed:(id)sender {
    
    for (UILabel *light in _lights) {
        light.backgroundColor = [UIColor redColor];
    }
    
    
    _Winner = NO;
    
    //  [_calledMethod setWin:NO]; is equivalent to
    _calledMethod.win = NO;
   
//  self.navigationItem.hidesBackButton = YES;
 // self.navigationController.navigationBar.hidden = YES;
    _btnAgain.alpha = 0;
    if (_timerValue>0) {
        
        _timerValue = [_labelTimer.text integerValue] + 20;}
    
    
    else {
        
    _timerValue = _startTimerValue;
        [_labelTimer removeFromSuperview];
        _score = 0;
         _labelScore.text = [NSString stringWithFormat:@"%i",_score];
        
    }
    
     [self runGameReset];
    
    
}

//NEW STUFF
-(UILabel *)setUpTimerLabel{
    
    
    _labelTimer = [[UILabel alloc] initWithFrame:CGRectMake(0, _screenHeight-_screenHeight/15, _screenWidth/3, _screenHeight/15)];
    _labelTimer.backgroundColor = [UIColor blackColor];
    _labelTimer.textColor = [UIColor yellowColor];
    _labelTimer.text = [NSString stringWithFormat:@"%i",_timerValue];
    _labelTimer.layer.borderWidth = 2;
    _labelTimer.layer.borderColor = [[UIColor blackColor] CGColor];
    _labelTimer.font = [UIFont fontWithName:@"Helvetica" size:_screenHeight/10*.6];
    _labelTimer.textAlignment = NSTextAlignmentCenter;
    _labelTimer.layer.cornerRadius = _screenHeight/15/2;
    
   
    _labelTimer.clipsToBounds = YES;
    
    
    
    NSDateComponentsFormatter *componentFormatter = [[NSDateComponentsFormatter alloc] init];
    componentFormatter.unitsStyle = NSDateComponentsFormatterUnitsStylePositional;
    componentFormatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorDefault;
    
    NSTimeInterval interval = _timerValue;
    NSString *formattedString = [componentFormatter stringFromTimeInterval:interval];
    
    _labelTimer.text = formattedString;
    
    
    [self.view addSubview:_labelTimer];
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCountDown) userInfo:nil repeats:YES];
    
    
    
    return _labelTimer;
    
}

-(UILabel *)setUpScoreLabel{
    _labelScore = [[UILabel alloc] initWithFrame:CGRectMake(_screenWidth-_screenWidth/3, _screenHeight-_screenHeight/15, _screenWidth/3, _screenHeight/15)];
    _labelScore.backgroundColor = [UIColor clearColor];
    _labelScore.textColor = [UIColor blackColor];
    _labelScore.text = [NSString stringWithFormat:@"%i",_score];
    _labelScore.layer.borderWidth = 2;
    _labelScore.layer.borderColor = [[UIColor blackColor] CGColor];
    _labelScore.font = [UIFont fontWithName:@"Helvetica" size:_screenHeight/10*.6];
    _labelScore.textAlignment = NSTextAlignmentCenter;
    _labelScore.layer.cornerRadius = _screenHeight/15/2;
    
    _labelScore.backgroundColor = [UIColor whiteColor];
    _labelScore.clipsToBounds = YES;
    
    [self.view addSubview:_labelScore];
    
    return _labelScore;
    
    
}



-(void)timerCountDown{
    
        _timerValue = _timerValue - 1;
        _labelTimer.text = [NSString stringWithFormat:@"%i",_timerValue];
        
        NSDateComponentsFormatter *componentFormatter = [[NSDateComponentsFormatter alloc] init];
        componentFormatter.unitsStyle = NSDateComponentsFormatterUnitsStylePositional;
        componentFormatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorDefault;
        
        NSTimeInterval interval = _timerValue;
        NSString *formattedString = [componentFormatter stringFromTimeInterval:interval];
        
        _labelTimer.text = formattedString;
        
        
        
        if (_timerValue <11) {
            
            
            _labelTimer.backgroundColor = [UIColor redColor];
            _labelTimer.textColor = [UIColor yellowColor];
            _labelTimer.clipsToBounds = YES;
        }
        else {_labelTimer.backgroundColor = [UIColor blackColor];
            _labelTimer.textColor = [UIColor yellowColor];
        }
    
    if (_timerValue == 0) {
        
        //[self showNavBar];
        [_calledMethod stopButtons];
       
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
    
        
        [self.view addSubview:labelGameOver];
        
        [self stopTimer];
        
        [self saveHighscore];

        
        [UIView animateWithDuration:4 animations:^{
            labelGameOver.alpha = 0;
            _btnAgain.alpha = 1;
        } completion:^(BOOL finished) {
          //  _btnAgain.alpha = 1;
         
            [self revealWord];
            
            
        }];
        
    }
}



-(void)stopTimer {
    [_timer invalidate];
    
}

-(void)winSolo{
    
    [_calledMethod stopButtons];
    _Winner = YES;
   
    NSArray *arraySplashWords = [[NSArray alloc] initWithObjects:@"Hooray",@"Terrific",@"Wow",@"Nifty",@"Amazing",@"Yahoo!",@"Great",@"Brilliant",@"Inspiring",@"Yay",@"Boom",@"Nailed It", nil];
    NSArray *arraySplashColors = [[NSArray alloc] initWithObjects:[UIColor redColor],[UIColor blueColor],[UIColor purpleColor],[UIColor orangeColor],[UIColor magentaColor], nil];
    
    NSArray *arrayX = [[NSArray alloc]initWithObjects:@5 ,@-5, @5, @-5, @0.2, @10, nil];
    NSArray *arrayY = [[NSArray alloc]initWithObjects:@-5,@5 , @5, @-5, @0.2, @10, nil];
    
    int randomNumberWord = arc4random_uniform(arraySplashWords.count);
    int randomNumberColor = arc4random_uniform(arraySplashColors.count);
    //int randomNumberScale = arc4random_uniform(arrayScales.count);
    
    NSString *splashWord = [arraySplashWords objectAtIndex:randomNumberWord];
    UIColor *splashColor = [arraySplashColors objectAtIndex:randomNumberColor];
    
    UILabel *winLabel = [[UILabel alloc] init];
    winLabel.frame = CGRectMake(0, _screenHeight*.65, _screenWidth,_screenHeight*.3);
    winLabel.text = splashWord;
    winLabel.textColor = splashColor;
    
    winLabel.contentScaleFactor = [[UIScreen mainScreen] scale]*8;
    
    
    winLabel.font = [UIFont fontWithName:@"Helvetica" size:_screenWidth * 0.05];
    winLabel.backgroundColor = [UIColor clearColor];
    winLabel.layer.cornerRadius = _screenHeight*.05;
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
            _btnAgain.alpha = 1;
        } completion:^(BOOL finished) {
            winLabel.alpha = 0;
        }];
    }];
    
    
}

-(void)revealWord {
   // self.navigationItem.hidesBackButton=YES;
   // self.navigationController.navigationBarHidden = NO;
   [_calledMethod revealWord:_arrayOfLettersInOrder];
  
}

-(void) saveHighscore {
    
    if (_score>0) {
        
        NSArray *oldScores = [UserDefaults getDataForKey:_level];
        NSMutableArray *newScores = [NSMutableArray arrayWithArray:oldScores];
        [newScores addObject:[NSNumber numberWithInt:_score]];
        
        
        // Used sort with descriptors to allow for ascending:no instead of using sort with selector
        
        
        NSSortDescriptor *scoreSortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"intValue" ascending:NO];
        NSArray *sortDescriptors = @[scoreSortDescriptor];
        NSArray *sortedScores = [newScores sortedArrayUsingDescriptors:sortDescriptors];
        NSArray *topTen = [sortedScores subarrayWithRange:NSMakeRange(0, MIN(10, sortedScores.count))];
        
        [UserDefaults saveData:topTen forKey:_level];
    }
    
}



- (IBAction)btnBackPressed:(id)sender {
    if (_timerValue>0 && _Winner == NO) {
        [self exitGameAlert];
    }
    else    {
         [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
    
}
@end
