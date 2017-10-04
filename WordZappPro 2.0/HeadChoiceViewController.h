//
//  HeadChoiceViewController.h
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/27/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface HeadChoiceViewController : UIViewController < UITextFieldDelegate>



@property (strong, nonatomic) IBOutlet UITextField *textFieldPeerNameEntered;
@property NSString *peerNameEntered;

@property (strong, nonatomic) IBOutlet UIButton *btnBeHost;
- (IBAction)btnBeHostPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnJoin;
- (IBAction)btnJoinPressed:(id)sender;

- (IBAction)btnTouched:(UIButton *)sender;

@end
