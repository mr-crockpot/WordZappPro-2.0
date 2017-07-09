//
//  SoloPlayViewController.m
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import "SoloPlayViewController.h"




@interface SoloPlayViewController ()

@end

@implementation SoloPlayViewController

- (void)viewDidLoad {
    
    self.navigationItem.hidesBackButton = YES;
    
    
    _screenWidth  = [UIScreen mainScreen].bounds.size.width;
    _screenHeight = [UIScreen mainScreen].bounds.size.height;

    
    _calledMethod = [[GamePlayMethods alloc] initWithView:self.view selectorForWin:@selector(win) delegate:self];
    _calledMethod.arrayOfLettersInOrder = _lettersInOrder;
    [self setUpLights];
    [self setUpLetters];
    [self setUpWordBoxes];
    [self setUpTimerLabel];
    

    [super viewDidLoad];
     
    // Do any additional setup after loading the view.
}

-(void) win {
    
    [_calledMethod stopTimer];
    
    [_calledMethod winSolo];
    
    self.navigationItem.hidesBackButton = NO;
    
  }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpLights {
    _lights = [_calledMethod setUpLights];
    
}
-(void)setUpLetters{
    
    _letterTiles = [_calledMethod setUpLetterButtons];
    for (int y =0; y<9; y++) {
        
        [(UIButton *)[_letterTiles objectAtIndex:y] setTitle:[NSString stringWithFormat:@"%c", [_strIncomingLetters characterAtIndex:y] ] forState: UIControlStateNormal];
        [(UIButton *)[_letterTiles objectAtIndex:y] setTag:y];
        
        
    }
}

-(void)setUpWordBoxes {
    _wordBoxes = [_calledMethod setupWordBoxes];
    
}

-(void)setUpTimerLabel {
    _labelTimer = [_calledMethod setUpTimerLabel];
    
}

-(void)endGame {
    self.navigationItem.hidesBackButton = YES;
}


@end
