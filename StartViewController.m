//
//  StartViewController.m
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"woodPattern.jpg"]];

}

-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    _btnSolo.frame = CGRectMake(width*.125, height*.25-25,width*.75, 50);
    _btnSolo.backgroundColor = [UIColor yellowColor];
    _btnSolo.titleLabel.textColor = [UIColor redColor];
    _btnSolo.layer.borderWidth = 2;
    _btnSolo.layer.borderColor = [[UIColor brownColor] CGColor];
    _btnSolo.layer.cornerRadius = 15;
    _btnSolo.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    _btnSolo.layer.shadowColor = [[UIColor blackColor] CGColor];
    _btnSolo.layer.shadowOffset = CGSizeMake(5.0, 5.0);
    _btnSolo.layer.shadowOpacity = 0.5;
    _btnSolo.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood.jpg"]];
    
    
    _btnHead.frame = CGRectMake(width*.125, height*.5-25, width*.75, 50);
    _btnHead.backgroundColor = [UIColor yellowColor];
    _btnHead.titleLabel.textColor = [UIColor redColor];
    _btnHead.layer.borderWidth = 2;
    _btnHead.layer.borderColor = [[UIColor brownColor] CGColor];
    _btnHead.layer.cornerRadius = 15;
    _btnHead.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    _btnHead.layer.shadowColor = [[UIColor blackColor] CGColor];
    _btnHead.layer.shadowOffset = CGSizeMake(5.0, 5.0);
    _btnHead.layer.shadowOpacity = 0.5;
    _btnHead.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood.jpg"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnTouched:(UIButton*)sender{
    CGFloat currentX = sender.frame.origin.x;
    CGFloat currentY = sender.frame.origin.y;
    CGFloat currentW = sender.frame.size.width;
    CGFloat currentH = sender.frame.size.height;
    
    
    sender.frame = CGRectMake(currentX+3, currentY+3, currentW, currentH);
    sender.layer.shadowOffset = CGSizeMake(0, 0);
}


@end
