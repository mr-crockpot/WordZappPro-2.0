//
//  StartViewController.h
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *btnSolo;
@property (strong, nonatomic) IBOutlet UIButton *btnHead;

-(IBAction)btnTouched:(UIButton*)sender;

@end
