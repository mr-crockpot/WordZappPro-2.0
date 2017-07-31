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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(peerDidChangeStateWithNotification:) name:@"MCDidChangeStateNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];

    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"woodPattern.jpg"]];
    
   _arrayJoiners = [[NSMutableArray alloc] initWithObjects:_peerNameEntered, nil];
    
    _gamePlayMethods = [[GamePlayMethods alloc] init];
    
    [super viewDidLoad];
    
     _appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [_appDelegate.mcManager setupPeerAndSessionWithDisplayName:_peerNameEntered];
    
    
  //  [[_appDelegate mcManager] setupPeerAndSessionWithDisplayName:[UIDevice currentDevice].name];
    
    
    _arrConnectedDevices = [[NSMutableArray alloc] initWithObjects:_peerNameEntered,nil];
    
 
    [_appDelegate.mcManager setupMCBrowser];
    [_appDelegate.mcManager advertiseSelf:YES];
    
    _segmentLevel.selectedSegmentIndex = 0;
    
    //SET UP BUTTONS AND TABLE
    _tblConnectedDevices.frame = CGRectMake(width*.125, height*.5, width*.75, height*.5);
    
    _tblConnectedDevices.layer.borderColor = [[UIColor blueColor] CGColor];
    _tblConnectedDevices.layer.borderWidth = 2;
    _tblConnectedDevices.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood.jpg"]];
    
    _segmentLevel.frame = CGRectMake(width*.125, height*.5-100, width*.75, 50);
    NSDictionary *segAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont fontWithName:@"Helvetica" size:18],
                                   NSFontAttributeName,[UIColor blueColor],
                                   NSForegroundColorAttributeName,
                                   nil];
    _segmentLevel.layer.borderWidth = 2;
    _segmentLevel.layer.borderColor = [[UIColor blueColor] CGColor];
    
    
    
    [_segmentLevel setTitleTextAttributes:segAttributes forState:UIControlStateNormal];
    
    
    _btnPlay.frame = CGRectMake(width*.125, height*.25-25,width*.75, 50);
    _btnPlay.backgroundColor = [UIColor yellowColor];
    _btnPlay.titleLabel.textColor = [UIColor redColor];
    _btnPlay.layer.borderWidth = 2;
    _btnPlay.layer.borderColor = [[UIColor brownColor] CGColor];
    _btnPlay.layer.cornerRadius = 15;
    _btnPlay.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    _btnPlay.layer.shadowColor = [[UIColor blackColor] CGColor];
    _btnPlay.layer.shadowOffset = CGSizeMake(5.0, 5.0);
    _btnPlay.layer.shadowOpacity = 0.5;
    _btnPlay.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood.jpg"]];
    
    if (_arrConnectedDevices.count==1) {
        _btnPlay.enabled = NO;
        [_btnPlay setTitle:@"Find Player(s)" forState:UIControlStateNormal];
        
    }


    
}

-(void)viewDidAppear:(BOOL)animated {
    
    
    
    
    
    
//    _level = @"Nothing";
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

-(void)viewDidDisappear:(BOOL)animated{
     _arrayJoiners = [[NSMutableArray alloc] initWithObjects:_peerNameEntered, nil];
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
        
        [_arrConnectedDevices addObject: peerDisplayName];
        
      dispatch_async(dispatch_get_main_queue(), ^{
          
          [_btnPlay setTitle:@"Start" forState:UIControlStateNormal];
        _btnPlay.enabled =YES;
        [self sendData:_level];
        
      });
        
    }
    else if (state == MCSessionStateNotConnected){
        if ([_arrConnectedDevices count] > 1) {
            NSInteger indexOfPeer = [_arrConnectedDevices indexOfObject:peerDisplayName];
            [_arrConnectedDevices removeObjectAtIndex:indexOfPeer];
            if (_arrConnectedDevices.count==1) {
                _btnPlay.enabled = NO;
               dispatch_async(dispatch_get_main_queue(), ^{
                   [_btnPlay setTitle:@"Find Player(s)" forState:UIControlStateNormal];
               });
            }

            
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [_tblConnectedDevices reloadData];
    });

}

-(void)didReceiveDataWithNotification:(NSNotification *)notification{

    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    NSString *receivedText = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    if (![receivedText containsString:@"Wins"]) {
        
       [_arrayJoiners addObject:receivedText];}
    
    if ([_arrayJoiners isEqualToArray:_arrConnectedDevices]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _btnPlay.enabled = YES;
        });
        
        
    }
    
    
     NSLog(@"Host received something and the array joiners is %@",_arrayJoiners);

    
   
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
    
    _btnPlay.enabled = NO;
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
   dispatch_async(dispatch_get_main_queue(), ^{
    
    [self sendData:_letters];
    [self performSegueWithIdentifier:@"segueHostToHeadPlay" sender:self];
     });
    
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
        
 
   //     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MCDidReceiveDataNotification" object:nil];
   //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MCDidChangeStateNotification" object:nil];
        
       
        
        HeadPlayViewController *view = [segue destinationViewController];
        view.strIncomingLetters = _letters;
        view.playerName = _peerNameEntered;
        
        
        
    }
    
    
}

//TABLE VIEW
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return _arrConnectedDevices.count;
   
}

/*-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    return @"Players";
}*/

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
   
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_arrConnectedDevices[indexPath.row]];
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood.jpg"]];
    cell.textLabel.textColor= [UIColor redColor];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
    
    
    return cell;

    
}

@end
