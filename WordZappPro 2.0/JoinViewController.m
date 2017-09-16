//
//  JoinViewController.m
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/27/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import "JoinViewController.h"
#import "HeadPlayViewController.h"


@interface JoinViewController ()

@end

@implementation JoinViewController

- (void)viewDidLoad {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];

    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"woodPattern.jpg"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(peerDidChangeStateWithNotification:)
                                                 name:@"MCDidChangeStateNotification"
                                               object:nil];
    
    _appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
   
    _arrConnectedDevices = [[NSMutableArray alloc] init];
 
    [_appDelegate.mcManager setupPeerAndSessionWithDisplayName:_peerNameEntered];
    [_appDelegate.mcManager setupMCBrowser];
    [_appDelegate.mcManager advertiseSelf:NO];
         //SET UP LABELS
    
    _lblStatus.frame = CGRectMake(width*.125, height*.25-25,width*.75, 50);
    _lblStatus.backgroundColor = [UIColor yellowColor];
    _lblStatus.textColor = [UIColor redColor];
    _lblStatus.layer.borderWidth = 2;
    _lblStatus.layer.borderColor = [[UIColor brownColor] CGColor];
    _lblStatus.layer.cornerRadius = 15;
    _lblStatus.clipsToBounds = YES;
    _lblStatus.font = [UIFont fontWithName:@"Helvetica" size:30];
    _lblStatus.layer.shadowColor = [[UIColor blackColor] CGColor];
    _lblStatus.layer.shadowOffset = CGSizeMake(5.0, 5.0);
    _lblStatus.layer.shadowOpacity = 0.5;
    _lblStatus.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood.jpg"]];
    _lblStatus.text = @"Not Connected";
    
    
    _lblLevel.frame = CGRectMake(width*.125, height*.45-25,width*.75, 50);
    _lblLevel.backgroundColor = [UIColor yellowColor];
    _lblLevel.textColor = [UIColor redColor];
    _lblLevel.layer.borderWidth = 2;
    _lblLevel.layer.borderColor = [[UIColor brownColor] CGColor];
    _lblLevel.layer.cornerRadius = 15;
    _lblLevel.clipsToBounds = YES;
    _lblLevel.font = [UIFont fontWithName:@"Helvetica" size:30];
    _lblLevel.layer.shadowColor = [[UIColor blackColor] CGColor];
    _lblLevel.layer.shadowOffset = CGSizeMake(5.0, 5.0);
    _lblLevel.layer.shadowOpacity = 0.5;
    _lblLevel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood.jpg"]];
    
    _lblLevel.text = @"Level: Easy";
    
    
    _btnDisconnect.frame = CGRectMake(width*.125, height*.65-25,width*.75, 50);
    _btnDisconnect.backgroundColor = [UIColor yellowColor];
    _btnDisconnect.titleLabel.textColor = [UIColor redColor];
    _btnDisconnect.layer.borderWidth = 2;
    _btnDisconnect.layer.borderColor = [[UIColor brownColor] CGColor];
    _btnDisconnect.layer.cornerRadius = 15;
    _btnDisconnect.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    _btnDisconnect.layer.shadowColor = [[UIColor blackColor] CGColor];
    _btnDisconnect.layer.shadowOffset = CGSizeMake(5.0, 5.0);
    _btnDisconnect.layer.shadowOpacity = 0.5;
    _btnDisconnect.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood.jpg"]];


    [self browseForDevices];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    
   
    
    
    if (_connected) {
        _lblStatus.text = @"Connected";
        NSString *codedPeerName = [NSString stringWithFormat:@"U%@",_peerNameEntered];
        [self sendData:codedPeerName];
        
    }

}

-(void)viewDidDisappear:(BOOL)animated {
 
  //  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MCDidReceiveDataNotification" object:nil];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController{
    [_appDelegate.mcManager.browser dismissViewControllerAnimated:YES completion:nil];
}

-(void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController {
    [_appDelegate.mcManager.browser dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)peerDidChangeStateWithNotification:(NSNotification *)notification{
    
    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    MCSessionState state = [[[notification userInfo] objectForKey:@"state"] intValue];
    
    if (state != MCSessionStateConnecting) {
       // [_tblConnectedDevices reloadData];
        
        //BOOL peersExist = ([[_appDelegate.mcManager.session connectedPeers] count] == 0);
        
    }
    
    if (state == MCSessionStateConnected) {
        [_arrConnectedDevices addObject:peerDisplayName];
       
        [_appDelegate.mcManager.browser dismissViewControllerAnimated:YES completion:nil];
        [_appDelegate.mcManager advertiseSelf:false];
        _connected = YES;
       
        
        
        }
    
    else if (state == MCSessionStateNotConnected){
        if ([_arrConnectedDevices count] > 0) {
            NSInteger indexOfPeer = [_arrConnectedDevices indexOfObject:peerDisplayName];
            [_arrConnectedDevices removeObjectAtIndex:indexOfPeer];
            _lblStatus.text = @"Not Connected";
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        }
    }
    
 

    
}

-(void)didReceiveDataWithNotification:(NSNotification *)notification{
    
    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    NSString *receivedText = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
   
    
  
    if ([[receivedText substringToIndex:1]  isEqual: @"W"] ) {
        //NSLog(@"This was triggered W");
        //Do something for win
    }
    
    if ([[receivedText substringToIndex:1]  isEqual: @"S"]) {
        //NSLog(@"This was triggered S");
        //Do command to start
    }
    
    if ([[receivedText substringToIndex:1]  isEqual: @"L"]) {
        //Do command to send Level
       // NSLog(@"This was triggered L");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *uncodedReceivedLevel = [receivedText substringFromIndex:1];
            _lblLevel.text = uncodedReceivedLevel;
        });
    }
    
    if ([[receivedText substringToIndex:1]  isEqual: @"U"]) {
      //  NSLog(@"This was triggered U");
        //Do command to incorporate User info
    }
    
    if ([[receivedText substringToIndex:1]  isEqual: @"A"]) {
        //Sending Letters
     //   NSLog(@"This was triggered A");
        NSString *uncodedReceivedLetters = [receivedText substringFromIndex:1];
        _letters = uncodedReceivedLetters;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"segueJoinToHeadPlay" sender:self];
            
            
        });
        
    }
    
 
 
  
}

-(void)browseForDevices{
    
    [[_appDelegate mcManager]setupMCBrowser];
    [[[_appDelegate mcManager]browser]setDelegate:self];
    [self presentViewController:[[_appDelegate mcManager]browser] animated:YES completion:nil];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"segueJoinToHeadPlay"]) {
     
        HeadPlayViewController *view = [segue destinationViewController];
        view.strIncomingLetters = _letters;
        view.playerName = _peerNameEntered;
        
        
}
    
    
}




- (IBAction)btnDisconnectPressed:(id)sender {
     [_appDelegate.mcManager.session disconnect];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}


-(void)sendData: (NSString *)playerInfo{
    
    
    NSData *dataToSend = [playerInfo dataUsingEncoding:NSUTF8StringEncoding];
    
    NSArray *allPeers = _appDelegate.mcManager.session.connectedPeers;
    NSError *error;
    
    [_appDelegate.mcManager.session sendData:dataToSend
                                     toPeers:allPeers
                                    withMode:MCSessionSendDataUnreliable
                                       error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
}
  
  
  @end
