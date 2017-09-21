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
    
    _btnHighScores.frame = CGRectMake(width*.125, height*.75-25, width*.75, 50);
    _btnHighScores.backgroundColor = [UIColor yellowColor];
    _btnHighScores.titleLabel.textColor = [UIColor redColor];
    _btnHighScores.layer.borderWidth = 2;
    _btnHighScores.layer.borderColor = [[UIColor brownColor] CGColor];
    _btnHighScores.layer.cornerRadius = 15;
    _btnHighScores.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    _btnHighScores.layer.shadowColor = [[UIColor blackColor] CGColor];
    _btnHighScores.layer.shadowOffset = CGSizeMake(5.0, 5.0);
    _btnHighScores.layer.shadowOpacity = 0.5;
    _btnHighScores.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood.jpg"]];
    
    [self addTitle];
}

-(void)viewWillDisappear:(BOOL)animated {
    for (UIButton *tile in _arrayTileTitle) {
        [tile removeFromSuperview];
    }
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

-(void)addTitle {
    _arrayTileTitle = [[NSMutableArray alloc]init];
    
    NSString *letter;
    float rotateAdjustment;
    float width=[UIScreen mainScreen].bounds.size.width/6;
    float yValue;
    float xValue;
    int multiplier;
    float screenHeight = self.view.frame.size.height;
    UIColor *letterColor;
    
    for (int l = 0; l<8; l++) {
        
        UIButton *tileTitle = [[UIButton alloc]init];
      
        
        if (l<5) {
            yValue = 50;
            xValue = 10;
            multiplier = l;
        }
        else {
            yValue = screenHeight - width;
            multiplier = l-4;
            xValue = width/2-15;
        }
        tileTitle.frame =CGRectMake (xValue+multiplier *(width+15), yValue, width,width);
        [tileTitle setBackgroundImage:[UIImage imageNamed: @"wood.jpg"] forState:UIControlStateNormal];
        
        switch (l) {
            case 0:
                letter = @"W";
                rotateAdjustment = .5;
                letterColor = [UIColor redColor];
                
                break;
            case 1:
                letter = @"O";
                rotateAdjustment = .25;
                letterColor = [UIColor blueColor];
                break;
            case 2:
                letter = @"R";
                rotateAdjustment = -.25;
                letterColor = [UIColor greenColor];
                break;
            case 3:
                letter = @"D";
                rotateAdjustment = -.5;
                letterColor = [UIColor orangeColor];
                break;
            case 4:
                letter = @"Z";
                rotateAdjustment = 0;
                letterColor = [UIColor magentaColor];
                break;
                
            case 5:
                letter = @"A";
                rotateAdjustment = 0;
                letterColor = [UIColor blueColor];
                break;
            case 6:
                letter = @"P";
                rotateAdjustment = -.5;
                letterColor = [UIColor greenColor];
                break;
            case 7:
                letter = @"P";
                rotateAdjustment = .5;
                letterColor = [UIColor orangeColor];
                break;
                
            default:
                rotateAdjustment = 0;
                break;
        }
        [tileTitle setTitle:letter forState:UIControlStateNormal];
        [tileTitle setTitleColor:letterColor forState:UIControlStateNormal];
        tileTitle.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:width];
        
        CGAffineTransform affineTransform = CGAffineTransformMakeRotation(-M_PI_4*rotateAdjustment);
        tileTitle.transform = affineTransform;
        
        [_arrayTileTitle addObject:tileTitle];
        
        
        
        [self.view addSubview:tileTitle];
    }
    
    
    
    [UIView animateWithDuration:5 delay:1 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
        _movingButton.alpha = 1;
        _movingButton = (UIButton *)_arrayTileTitle[4];
        _movingButton.frame = CGRectMake((width+15)/4, screenHeight - width, width, width);
        CGAffineTransform affineTransform = CGAffineTransformMakeRotation(-M_PI_4*.5);
        _movingButton.transform = affineTransform;
    } completion:^(BOOL finished) {
        //MAYBE DO SOMETHING
    }];
    
}



@end
