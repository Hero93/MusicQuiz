//
//  MQMultiplayerHandler.m
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 23/06/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import "MQMultiplayerHandler.h"

@implementation MQMultiplayerHandler

#pragma mark - Public Methods
- (void)setupPeerWithDisplayName:(NSString *)displayName {
    self.peerID = [[MCPeerID alloc] initWithDisplayName:displayName];
}

- (void)setupSession {
    self.session = [[MCSession alloc] initWithPeer:self.peerID];
    self.session.delegate = self;
}

- (void)setupBrowser {
    self.browser = [[MCBrowserViewController alloc] initWithServiceType:@"my-game" session:_session];
}

- (void)advertiseSelf:(BOOL)advertise {
    if (advertise) {
        self.advertiser = [[MCAdvertiserAssistant alloc] initWithServiceType:@"my-game" discoveryInfo:nil session:self.session];
        [self.advertiser start];
        
    } else {
        [self.advertiser stop];
        self.advertiser = nil;
    }
}

#pragma mark - Session Delegate Methods
- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    NSDictionary *userInfo = @{ @"peerID": peerID,
                                @"state" : @(state) };
    
    
    // We post the notification inside a "dispatch_async" block to ensure that the notification is posted on the main thread.
    // This is important as we cannot guarantee that the delegate method is invoked on the main thread.
    // The notification, however, needs to be posted on the main thread to make sure that every observer receives the notification.
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MusicQuiz_DidChangeStateNotification"
                                                            object:nil
                                                          userInfo:userInfo];
    });
}

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    // DATA
    
    NSDictionary *userInfo = @{ @"data": data,
                                @"peerID": peerID };
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MusicQuiz_DidReceiveDataNotification"
                                                            object:nil
                                                          userInfo:userInfo];
    });
}

- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress {
    // RESOURCES
}

- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error {
    // STREAMING
}

- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID {
    // STREAMING
}

@end
