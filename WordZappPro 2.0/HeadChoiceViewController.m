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
    
   self.navigationController.navigationBarHidden = NO;
   
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"woodPattern.jpg"]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;

    
    _btnBeHost.frame = CGRectMake(width*.125, height*.35-25,width*.75, 50);
    _btnBeHost.backgroundColor = [UIColor yellowColor];
    _btnBeHost.titleLabel.textColor = [UIColor redColor];
    _btnBeHost.layer.borderWidth = 2;
    _btnBeHost.layer.borderColor = [[UIColor brownColor] CGColor];
    _btnBeHost.layer.cornerRadius = 15;
    _btnBeHost.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    _btnBeHost.layer.shadowColor = [[UIColor blackColor] CGColor];
    _btnBeHost.layer.shadowOffset = CGSizeMake(5.0, 5.0);
    _btnBeHost.layer.shadowOpacity = 0.5;
    _btnBeHost.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood.jpg"]];
    
    
    _btnJoin.frame = CGRectMake(width*.125, height*.5-25, width*.75, 50);
    _btnJoin.backgroundColor = [UIColor yellowColor];
    _btnJoin.titleLabel.textColor = [UIColor redColor];
    _btnJoin.layer.borderWidth = 2;
    _btnJoin.layer.borderColor = [[UIColor brownColor] CGColor];
    _btnJoin.layer.cornerRadius = 15;
    _btnJoin.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    _btnJoin.layer.shadowColor = [[UIColor blackColor] CGColor];
    _btnJoin.layer.shadowOffset = CGSizeMake(5.0, 5.0);
    _btnJoin.layer.shadowOpacity = 0.5;
    _btnJoin.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood.jpg"]];
    
    _textFieldPeerNameEntered.frame = CGRectMake(width*.125, height*.15-25, width*.75, 50);
    _textFieldPeerNameEntered.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood.jpg"]];
    _textFieldPeerNameEntered.layer.borderColor = [[UIColor brownColor] CGColor];
    _textFieldPeerNameEntered.layer.borderWidth = 2;
    _textFieldPeerNameEntered.layer.cornerRadius = 15;
    
    _textFieldPeerNameEntered.font = [UIFont fontWithName:@"Helvetica" size:30];
    _textFieldPeerNameEntered.textColor = [UIColor redColor];
    _textFieldPeerNameEntered.textAlignment = NSTextAlignmentCenter;
    
    
    [super viewDidLoad];
    
    _textFieldPeerNameEntered.text = [UIDevice currentDevice].name;
    _peerNameEntered = _textFieldPeerNameEntered.text;
    
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    _btnBeHost.frame = CGRectMake(width*.125, height*.25-25,width*.75, 50);
    _btnBeHost.layer.shadowColor = [[UIColor blackColor] CGColor];
    _btnBeHost.layer.shadowOffset = CGSizeMake(5.0, 5.0);
    _btnBeHost.layer.shadowOpacity = 0.5;
    
    _btnJoin.frame = CGRectMake(width*.125, height*.5-25, width*.75, 50);
    _btnJoin.layer.shadowColor = [[UIColor blackColor] CGColor];
    _btnJoin.layer.shadowOffset = CGSizeMake(5.0, 5.0);
    _btnJoin.layer.shadowOpacity = 0.5;

     self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    _peerNameEntered = _textFieldPeerNameEntered.text;
    
    [textField resignFirstResponder];
    
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    _peerNameEntered = _textFieldPeerNameEntered.text;
    
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

-(void)dismissKeyboard{
    
    _peerNameEntered = _textFieldPeerNameEntered.text;
    [_textFieldPeerNameEntered resignFirstResponder];
}
- (IBAction)btnTouched:(UIButton *)sender {
    CGFloat currentX = sender.frame.origin.x;
    CGFloat currentY = sender.frame.origin.y;
    CGFloat currentW = sender.frame.size.width;
    CGFloat currentH = sender.frame.size.height;
    
    
    sender.frame = CGRectMake(currentX+3, currentY+3, currentW, currentH);
    sender.layer.shadowOffset = CGSizeMake(0, 0);
    
}

@end
