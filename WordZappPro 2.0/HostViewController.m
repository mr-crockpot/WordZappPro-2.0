//
//  HostViewController.m
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/27/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import "HostViewController.h"
#import "GamePlayMethods.h"
#import "HeadPlayViewController.h"




@interface HostViewController ()

@end

@implementation HostViewController

- (void)viewDidLoad {
    
 

    
    _gamePlayMethods = [[GamePlayMethods alloc] init];
    
    [super viewDidLoad];
    
    _appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
  //  [[_appDelegate mcManager] setupPeerAndSessionWithDisplayName:[UIDevice currentDevice].name];
    [_appDelegate.mcManager setupPeerAndSessionWithDisplayName:_peerNameEntered];
    
    _arrConnectedDevices = [[NSMutableArray alloc] initWithObjects:_peerNameEntered,nil];
    
 
    [_appDelegate.mcManager setupMCBrowser];
    [_appDelegate.mcManager advertiseSelf:YES];
    
    _segmentLevel.selectedSegmentIndex = 0;
    

    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(peerDidChangeStateWithNotification:) name:@"MCDidChangeStateNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];
    
    _level = @"Nothing";
    switch (_segmentLevel.selectedSegmentIndex) {
            
        case 0:
            _level = @"Level: Easy";
            break;
        case 1:
            _level = @"Level: Medium";
            break;
        case 2:
            _level = @"Level: Hard";
            break;
            
        default:
            break;
    }
    
    
   

    
    
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
        
        [self sendData:_level];
        NSLog(@"Data was sent with level %@",_level);
        
        
        
    }
    else if (state == MCSessionStateNotConnected){
        if ([_arrConnectedDevices count] > 0) {
            NSInteger indexOfPeer = [_arrConnectedDevices indexOfObject:peerDisplayName];
            [_arrConnectedDevices removeObjectAtIndex:indexOfPeer];
            NSLog(@"Joiner disconnected");
            
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [_tblConnectedDevices reloadData];
    });

}

-(void)didReceiveDataWithNotification:(NSNotification *)notification{


}

-(void)randomizeLetters{
    _arrayOfRandomLetters = [[NSMutableArray alloc] initWithArray:[_gamePlayMethods arrayOfRandomLetters:_arrayOfLettersInOrder]];
    
    for (int x=0; x<9; x++) {
        if (x!=0){
            _letters = [NSString stringWithFormat:@"%@%@",_letters,_arrayOfRandomLetters[x]];
        } else {
            _letters = [NSString stringWithFormat:@"%@",_arrayOfRandomLetters[x]];
        }
        
    }
       
    
}



- (IBAction)btnPlayPressed:(id)sender {
    
    
    switch (_segmentLevel.selectedSegmentIndex) {
            
            
        case 0:
            _list = @"easyList";
            break;
        case 1:
            _list = @"mediumList";
            break;
        case 2:
            _list = @"hardList";
            break;
        default:
            break;
    }
    
  
    _arrayOfLettersInOrder = [[NSMutableArray alloc]initWithArray:[_gamePlayMethods arrayOfLettersInOrder:_list]];
    _arrayOfRandomLetters = [[NSMutableArray alloc] initWithArray:[_gamePlayMethods arrayOfRandomLetters:_arrayOfLettersInOrder]];

    
    for (int x=0; x<9; x++) {
        if (x!=0){
            _letters = [NSString stringWithFormat:@"%@%@",_letters,_arrayOfRandomLetters[x]];
        } else {
            _letters = [NSString stringWithFormat:@"%@",_arrayOfRandomLetters[x]];
        }
        
    }
    
    [self sendData:_letters];
    
    [self performSegueWithIdentifier:@"segueHostToHeadPlay" sender:self];

}

-(void)sendData: (NSString *)incomingData{
    
    NSData *dataToSend = [incomingData dataUsingEncoding:NSUTF8StringEncoding];
    
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



- (IBAction)segmentLevelChanged:(id)sender {
  
    _level = @"Nothing";
    switch (_segmentLevel.selectedSegmentIndex) {
   
        case 0:
            _level = @"Level: Easy";
            break;
        case 1:
            _level = @"Level: Medium";
            break;
        case 2:
            _level = @"Level: Hard";
            break;
            
        default:
            break;
    }
    
    
    [self sendData:_level];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"segueHostToHeadPlay"]) {
        
       [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MCDidReceiveDataNotification" object:nil];
       [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MCDidChangeStateNotification" object:nil];
        
       
        
        HeadPlayViewController *view = [segue destinationViewController];
        view.strIncomingLetters = _letters;
        view.playerName = _peerNameEntered;
        
        
        
    }
    
    
}

//TABLE VIEW
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return _arrConnectedDevices.count;
   
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Players";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
   
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_arrConnectedDevices[indexPath.row]];
    
    return cell;

    
}

@end
