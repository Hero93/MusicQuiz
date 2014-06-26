//
//  MultiplayerOptionsViewController.h
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 23/06/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQMultiplayerHandler.h"

@interface MultiplayerOptionsViewController : UIViewController <MCBrowserViewControllerDelegate>

@property IBOutlet UITextView *tvPlayerList;
@property IBOutlet UISwitch *swVisible;
@property (weak, nonatomic) IBOutlet UIButton *btnStartGame;
@property (weak, nonatomic) IBOutlet UIButton *btnStartPlayerResearch;
@property (weak, nonatomic) IBOutlet UIButton *btnDisconnect;


- (IBAction)disconnect:(id)sender;
- (IBAction)searchForPlayers:(id)sender;
- (IBAction)toggleVisibility:(id)sender;

-(IBAction)startTheGame:(id)sender;

@end
