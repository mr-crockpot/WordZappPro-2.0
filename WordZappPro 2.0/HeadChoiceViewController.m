//
//  HeadChoiceViewController.m
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/27/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import "HeadChoiceViewController.h"
#import "JoinViewController.h"
#import "HostViewController.h"

@interface HeadChoiceViewController ()

@end

@implementation HeadChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textFieldPeerNameEntered.text = [UIDevice currentDevice].name;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    _peerNameEntered = _textFieldPeerNameEntered.text;
    NSLog(@"This is the peer name: %@",_peerNameEntered);
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"segueHeadChoiceToJoin"]) {
        JoinViewController *view = [segue destinationViewController];
               view.peerNameEntered = _peerNameEntered;
        
    }
    if ([segue.identifier isEqualToString:@"segueHeadChoiceToHost"]) {
        HostViewController *view = [segue destinationViewController];
        view.peerNameEntered = _peerNameEntered;
        
    }


    
}

- (IBAction)btnBeHostPressed:(id)sender {
    
   // [self performSegueWithIdentifier:@"segueHeadChoicetoJoin" sender:self];
}
- (IBAction)btnJoinPressed:(id)sender {
  //  [self performSegueWithIdentifier:@"segueHeadChoiceToJoin" sender:self];
}
@end
