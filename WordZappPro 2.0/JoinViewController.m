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
                                             selector:@selector(peerDidChangeStateWithNotification:)
                                                 name:@"MCDidChangeStateNotification"
                                               object:nil];
    
    _appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSLog(@"The incoming peer name is %@",_peerNameEntered);
    
    _arrConnectedDevices = [[NSMutableArray alloc] init];
 
    [_appDelegate.mcManager setupPeerAndSessionWithDisplayName:_peerNameEntered];
    [_appDelegate.mcManager setupMCBrowser];
    [_appDelegate.mcManager advertiseSelf:NO];
     _lblLevel.text = @"Level: Easy";
    [self browseForDevices];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];
    
    
    if (_connected) {
        _lblStatus.text = @"Connected";
        
      
    }

}

-(void)viewDidDisappear:(BOOL)animated {
 
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MCDidReceiveDataNotification" object:nil];
 
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
                       
        }
    }
    
}

-(void)didReceiveDataWithNotification:(NSNotification *)notification{
    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    NSString *receivedText = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    if ([receivedText containsString:@"Level"]) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
        _lblLevel.text = receivedText;
        });
    }
    else {
    _letters = receivedText;
    
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
        
        
}
    
    
}




- (IBAction)btnDisconnectPressed:(id)sender {
     [_appDelegate.mcManager.session disconnect];
}


  
  
  
  @end
