//
//  MultiplayerOptionsViewController.m
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 23/06/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import "MultiplayerOptionsViewController.h"
#import "MultiplayerViewController.h"
#import "AppDelegate.h"

@interface MultiplayerOptionsViewController ()

@property (strong, nonatomic) AppDelegate *appDelegate;

@end

@implementation MultiplayerOptionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self.appDelegate.multiplayerHandler setupPeerWithDisplayName:[UIDevice currentDevice].name];
    [self.appDelegate.multiplayerHandler setupSession];
    [self.appDelegate.multiplayerHandler advertiseSelf:self.swVisible.isOn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(peerChangedStateWithNotification:)
                                                 name:@"MusicQuiz_DidChangeStateNotification"
                                               object:nil];
    
    self.btnStartGame.hidden = YES;
    self.btnDisconnect.hidden = YES;
}

#pragma mark - Browser View Controller Delegate Methods
- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController {
    [self.appDelegate.multiplayerHandler.browser dismissViewControllerAnimated:YES completion:nil];
}

- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController {
    [self.appDelegate.multiplayerHandler.browser dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Actions
- (IBAction)disconnect:(id)sender {
    [self.appDelegate.multiplayerHandler.session disconnect];
}

- (IBAction)searchForPlayers:(id)sender {
    if (self.appDelegate.multiplayerHandler.session != nil) {
        [[self.appDelegate multiplayerHandler] setupBrowser];
        [[[self.appDelegate multiplayerHandler] browser] setDelegate:self];
        
        [self presentViewController:self.appDelegate.multiplayerHandler.browser
                           animated:YES
                         completion:nil];
    }
}

- (IBAction)toggleVisibility:(id)sender {
    [self.appDelegate.multiplayerHandler advertiseSelf:self.swVisible.isOn];
}

#pragma mark - Notification Handling
- (void)peerChangedStateWithNotification:(NSNotification *)notification {
    // Get the state of the peer.
    int state = [[[notification userInfo] objectForKey:@"state"] intValue];
    
    // We care only for the Connected and the Not Connected states.
    // The Connecting state will be simply ignored.
    if (state != MCSessionStateConnecting) {
        // We'll just display all the connected peers (players) to the text view.
        NSString *allPlayers = @"Other players connected with:\n\n";
        
        for (int i = 0; i < self.appDelegate.multiplayerHandler.session.connectedPeers.count; i++) {
            NSString *displayName = [[self.appDelegate.multiplayerHandler.session.connectedPeers objectAtIndex:i] displayName];
            
            allPlayers = [allPlayers stringByAppendingString:@"\n"];
            allPlayers = [allPlayers stringByAppendingString:displayName];
            
            self.btnStartGame.hidden = NO;
            self.btnDisconnect.hidden = NO;
        }
        
        [self.tvPlayerList setText:allPlayers];
    }
}

-(void)startTheGame:(id)sender
{
    MultiplayerViewController *multiplayerVC = [[MultiplayerViewController alloc] initWithNibName:@"MultiplayerViewController" bundle:nil];
    multiplayerVC.quizMode = self.quizMode;
    [self.navigationController pushViewController:multiplayerVC animated:YES];
}


@end
