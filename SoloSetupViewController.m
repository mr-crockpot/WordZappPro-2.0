//
//  SoloSetupViewController.m
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import "SoloSetupViewController.h"
#import "GamePlayMethods.h"
#import "SoloPlayViewController.h"


@interface SoloSetupViewController ()

@end

@implementation SoloSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _gamePlayMethods = [[GamePlayMethods alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnEasyPressed:(id)sender {
    
    _level = @"easyList";
    [self getLetters];

}

- (IBAction)btnMediumPressed:(id)sender{
    _level = @"mediumList";
    [self getLetters];
    
}

-(IBAction)btnHardPressed:(id)sender{
    _level = @"hardList";
    [self getLetters];
    
}

-(void)getLetters{
    
    _arrayOfLettersInOrder = [[NSMutableArray alloc]initWithArray:[_gamePlayMethods arrayOfLettersInOrder:_level]];
    NSLog(@"Solo Setup Order is %@",_gamePlayMethods.arrayOfLettersInOrder);
    [self randomizeLetters];
    
    
    [self performSegueWithIdentifier:@"segueSoloSetupToSoloPlay" sender:self];
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
    NSLog(@"Solo Setup Random is %@",_arrayOfRandomLetters);
    
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"segueSoloSetupToSoloPlay"]) {
        SoloPlayViewController *view = [segue destinationViewController];
        view.strIncomingLetters = _letters;
        view.lettersInOrder = _arrayOfLettersInOrder;
        
    }
}

@end
