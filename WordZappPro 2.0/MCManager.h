//
//  MCManager.h
//  WordZappPro 2.0
//
//  Created by Adam Schor on 6/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>


@interface MCManager : NSObject <MCSessionDelegate>
 
 @property (nonatomic, strong) MCPeerID *peerID;
 @property (nonatomic, strong) MCSession *session;
 @property (nonatomic, strong) MCBrowserViewController *browser;
 @property (nonatomic, strong) MCAdvertiserAssistant *advertiser;
 
 -(void)setupPeerAndSessionWithDisplayName:(NSString *)displayName;
 -(void)setupMCBrowser;
 -(void)advertiseSelf:(BOOL)shouldAdvertise;
 



@end
