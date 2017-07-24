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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"whiteStone.jpg"]];
    
    
    _screenWidth  = [UIScreen mainScreen].bounds.size.width;
    _screenHeight = [UIScreen mainScreen].bounds.size.height;

    
    _calledMethod = [[GamePlayMethods alloc] initWithView:self.view selectorForWin:@selector(win) delegate:self];
    _calledMethod.arrayOfLettersInOrder = _lettersInOrder;
    [self setUpLights];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self setUpLetters];
    });

 //   [self setUpLetters];
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
    CGFloat boxWidth = self.view.frame.size.width/8;
    _letterTiles = [_calledMethod setUpLetterButtons];
    for (int y =0; y<9; y++) {
        
     /*   [(UIButton *)[_letterTiles objectAtIndex:y] setTitle:[NSString stringWithFormat:@"%c", [_strIncomingLetters characterAtIndex:y] ] forState: UIControlStateNormal];
        [(UIButton *)[_letterTiles objectAtIndex:y] setTag:y];*/
        
         NSString *theLetter = [NSString stringWithFormat:@"%c",[_strIncomingLetters characterAtIndex:y]];
        
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
    _labelTimer = [_calledMethod setUpTimerLabel];
    
}

-(void)endGame {
    self.navigationItem.hidesBackButton = YES;
}


@end
