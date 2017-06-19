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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    NSMutableArray *arrayOfLetters = [[NSMutableArray alloc]initWithArray:[GamePlayMethods arrayOfLetters:_level]];
    
    for (int x=0; x<9; x++) {
        if (x!=0){
            _letters = [NSString stringWithFormat:@"%@%@",_letters,arrayOfLetters[x]];
        } else {
            _letters = [NSString stringWithFormat:@"%@",arrayOfLetters[x]];
        }
        
    }
    
    NSLog(@"The letters are %@",arrayOfLetters);
    
    [self performSegueWithIdentifier:@"segueSoloSetupToSoloPlay" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"segueSoloSetupToSoloPlay"]) {
        SoloPlayViewController *view = [segue destinationViewController];
        view.strIncomingLetters = _letters;
    }
}

@end
