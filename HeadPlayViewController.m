//
//  HeadPlayViewController.m
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import "HeadPlayViewController.h"

@interface HeadPlayViewController ()

@end

@implementation HeadPlayViewController

- (void)viewDidLoad {
    
    _calledMethod = [[GamePlayMethods alloc] initWithView:self.view];
    [super viewDidLoad];
    
    _labelLetters.text = _strIncomingLetters;
    
    [self setUpLights];
  //EXAMPLE FOR LATER  [self changeLightsColor:0 newColor:[UIColor orangeColor]];
    [self setUpLetters];
    [self setUpWordBoxes];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setUpLights {
    _lights = [_calledMethod setUpLights];
    
}

-(void)changeLightsColor: (NSInteger)row  newColor:(UIColor *) color {
    
    [_lights[row] setBackgroundColor:color];
     
    
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



@end
