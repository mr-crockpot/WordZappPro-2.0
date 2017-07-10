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
    
    self.navigationItem.hidesBackButton = YES;
    _appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];

   
    _calledMethod = [[GamePlayMethods alloc] initWithView:self.view selectorForWin:@selector(sendLostMessage) delegate:self];
    [super viewDidLoad];
    
    
    
    _labelLetters.text = _strIncomingLetters;
    
    [self setUpLights];
  
    [self setUpLetters];
    [self setUpWordBoxes];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    
   // _playerName = @"Adam";
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];
}

-(void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MCDidReceiveDataNotification" object:nil];
   
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
    
        _letterTiles = [_calledMethod setUpLetterButtons];
        for (int y =0; y<9; y++) {
            
           [(UIButton *)[_letterTiles objectAtIndex:y] setTitle:[NSString stringWithFormat:@"%c", [_strIncomingLetters characterAtIndex:y] ] forState: UIControlStateNormal];
            [(UIButton *)[_letterTiles objectAtIndex:y] setTag:y];
            
            
        }
    
}

-(void)setUpWordBoxes {
    _wordBoxes = [_calledMethod setupWordBoxes];
    
}

-(void)showLabel: (NSString*)winnerName{
    
    UILabel *labelGameOver = [[UILabel alloc] init];
    labelGameOver.frame = CGRectMake(20, self.view.frame.size.height * .15, self.view.frame.size.width - 40, self.view.frame.size.height*.37);
    labelGameOver.layer.borderColor = [[UIColor redColor] CGColor];
    labelGameOver.layer.borderWidth = 2;
    labelGameOver.backgroundColor = [UIColor yellowColor];
    labelGameOver.textColor = [UIColor redColor];
    labelGameOver.layer.cornerRadius = 15;
    labelGameOver.clipsToBounds = YES;
    labelGameOver.text = [NSString stringWithFormat:@"%@ Wins",winnerName];
    
   // labelGameOver.text = @"Game Over";
    labelGameOver.font = [UIFont fontWithName:@"Courier" size:self.view.frame.size.height*.4*.2];
    labelGameOver.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelGameOver];
    
    self.navigationItem.hidesBackButton = NO;
    
    
    
}

-(void)sendLostMessage{
    
    NSString *message = _playerName;
    
    
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
    self.navigationItem.hidesBackButton = NO;
        
}


-(void)didReceiveDataWithNotification:(NSNotification *)notification{
    
    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    NSString *receivedText = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"Received text from winner is %@",receivedText);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self showLabel:receivedText];
    });
    
    
}


@end
