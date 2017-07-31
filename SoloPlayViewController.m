//
//  SoloPlayViewController.m
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import "SoloPlayViewController.h"
#import "GamePlayMethods.h"


@interface SoloPlayViewController ()

@end

@implementation SoloPlayViewController

- (void)viewDidLoad {
    
    _timerValue = 6;
    _gamePlayMethods = [[GamePlayMethods alloc] init];
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"whiteStone.jpg"]];
    
    
    _screenWidth  = [UIScreen mainScreen].bounds.size.width;
    _screenHeight = [UIScreen mainScreen].bounds.size.height;

    
    _calledMethod = [[GamePlayMethods alloc] initWithView:self.view selectorForWin:@selector(win) delegate:self];
    _calledMethod.arrayOfLettersInOrder = _lettersInOrder;
   
  dispatch_async(dispatch_get_main_queue(), ^{
      [self runGameSetup];
        });
  
    
      [super viewDidLoad];
     
    // Do any additional setup after loading the view.
}

-(void)runGameSetup{
    
        [self getLetters];
        [self setUpLetters];
        [self setUpLights];
        [self setUpWordBoxes];
        [self setUpTimerLabel];
   
   
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
    
    [_calledMethod stopTimer];
    
    [_calledMethod winSolo];
    
    self.navigationItem.hidesBackButton = NO;
    self.navigationController.navigationBar.hidden = NO;
    
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

-(void)setUpTimerLabel {
   
    _labelTimer = [_calledMethod setUpTimerLabel:_timerValue];
    
    
}

-(void)endGame {
    self.navigationItem.hidesBackButton = YES;
}


- (IBAction)btnAgainPressed:(id)sender {
   
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.hidden = YES;
    
    _timerValue = [_labelTimer.text integerValue] + 10;
     [self runGameReset];
    
    
}
@end
