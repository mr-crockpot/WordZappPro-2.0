//
//  HeadPlayViewController.m
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import "HeadPlayViewController.h"
#import "AppDelegate.h"


@interface HeadPlayViewController ()

@end

@implementation HeadPlayViewController

- (void)viewDidLoad {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"whiteStone.jpg"]];

    
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBarHidden = YES;

    
    _appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];

   
    _calledMethod = [[GamePlayMethods alloc] initWithView:self.view selectorForWin:@selector(sendLostMessage) delegate:self];
    [super viewDidLoad];
    
    
    [self setUpLights];
  
    [self setUpLetters];
    [self setUpWordBoxes];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    
    
  
}

-(void)viewDidDisappear:(BOOL)animated {
   // [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MCDidReceiveDataNotification" object:nil];
   
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
    CGFloat boxWidth = self.view.frame.size.width/8;
    _letterTiles = [_calledMethod setUpLetterButtons];
    for (int y =0; y<9; y++) {
        
        /*   [(UIButton *)[_letterTiles objectAtIndex:y] setTitle:[NSString stringWithFormat:@"%c", [_strIncomingLetters characterAtIndex:y] ] forState: UIControlStateNormal];
         [(UIButton *)[_letterTiles objectAtIndex:y] setTag:y];*/
        
        NSString *theLetter = [NSString stringWithFormat:@"%c",[_strIncomingLetters characterAtIndex:y]];
        
        UIColor *letterColor = [UIColor blackColor];
        UIFont  *letterFont = [UIFont fontWithName:@"Helvetica" size:boxWidth*.8];
        
        
        NSDictionary *attributes = @{ NSForegroundColorAttributeName: letterColor,
                                      NSFontAttributeName: letterFont,
                                      NSTextEffectAttributeName: NSTextEffectLetterpressStyle};
        
        
        
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:theLetter
                                                                             attributes:attributes];
        
        
        
        [(UIButton *)[_letterTiles objectAtIndex:y] setAttributedTitle: attributedText forState: UIControlStateNormal];
        [(UIButton *)[_letterTiles objectAtIndex:y] setTag:y];
        
        
        
    }
}

-(void)setUpWordBoxes {
    _wordBoxes = [_calledMethod setupWordBoxes];
    
}

-(void)showLabel: (NSString*)winnerName{
    
    [_calledMethod stopButtons];
    
    UILabel *labelGameOver = [[UILabel alloc] init];
    labelGameOver.frame = CGRectMake(20, self.view.frame.size.height * .15, self.view.frame.size.width - 40, self.view.frame.size.height*.37);
    labelGameOver.layer.borderColor = [[UIColor redColor] CGColor];
    labelGameOver.layer.borderWidth = 2;
    labelGameOver.backgroundColor = [UIColor yellowColor];
    labelGameOver.textColor = [UIColor redColor];
    labelGameOver.layer.cornerRadius = 15;
    labelGameOver.clipsToBounds = YES;
    labelGameOver.text = winnerName;
    labelGameOver.numberOfLines = 0;
    labelGameOver.adjustsFontSizeToFitWidth = YES;
    
    
   // labelGameOver.text = @"Game Over";
    labelGameOver.font = [UIFont fontWithName:@"Helvetica" size:self.view.frame.size.height*.4*.2];
    labelGameOver.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelGameOver];
    
    [UIView animateWithDuration:4 animations:^{
        labelGameOver.alpha = 0;
    } completion:^(BOOL finished) {
        
        
    }];
    
    self.navigationItem.hidesBackButton = NO;
    self.navigationController.navigationBarHidden = NO;
    
}

-(void)sendLostMessage{
    
    NSString *message = [NSString stringWithFormat:@"W%@ Wins", _playerName];
    NSData *dataToSend = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *allPeers = _appDelegate.mcManager.session.connectedPeers;
    NSError *error;
    
    [_appDelegate.mcManager.session sendData:dataToSend
                                     toPeers:allPeers
                                    withMode:MCSessionSendDataUnreliable
                                       error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    [_calledMethod stopButtons];
    
    self.navigationItem.hidesBackButton = NO;
    self.navigationController.navigationBarHidden = NO;
    
}


-(void)didReceiveDataWithNotification:(NSNotification *)notification{
    
   
    
    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    NSString *receivedText = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    
    if ([[receivedText substringToIndex:1]  isEqual: @"W"]) {
        
        //do show label

        NSString *uncodedReceivedWin = [receivedText substringFromIndex:1];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showLabel:uncodedReceivedWin];
            [self.gamePlayMethods stopButtons];
        });
    }
 
    
    
    
    
  /*  if ([receivedText containsString:@"Wins"]) {
    
  
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self showLabel:receivedText];
    });
    }*/
}


@end
