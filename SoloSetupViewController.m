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
      self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"woodPattern.jpg"]];
    
    
    [super viewDidLoad];
    _gamePlayMethods = [[GamePlayMethods alloc] init];
    
    [self formatButtons];
    
    
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
    
    
    
    
}


-(void)formatButtons{
    
        CGFloat width = self.view.frame.size.width;
        CGFloat height = self.view.frame.size.height;
    
    for (UIButton *button in _levelButtons) {
        
        button.frame = CGRectMake(width*.125, height*button.tag*.25-25,width*.75, 50);
        button.backgroundColor = [UIColor yellowColor];
        button.titleLabel.textColor = [UIColor redColor];
        button.layer.borderWidth = 2;
        button.layer.borderColor = [[UIColor brownColor] CGColor];
        button.layer.cornerRadius = 15;
        button.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
        button.layer.shadowColor = [[UIColor blackColor] CGColor];
        button.layer.shadowOffset = CGSizeMake(5.0, 5.0);
        button.layer.shadowOpacity = 0.5;
        button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood.jpg"]];
    }
    
    
    
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"segueSoloSetupToSoloPlay"]) {
        SoloPlayViewController *view = [segue destinationViewController];
        view.strIncomingLetters = _letters;
        view.lettersInOrder = _arrayOfLettersInOrder;
        
    }
}

@end
