//
//  MultiplayerViewController.h
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 15/06/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "MusicQuiz.h"

@interface MultiplayerViewController : UIViewController <MusicQuizDelegate>

// Before the Match
@property (nonatomic, weak) IBOutlet UIButton *btnStartGame;
@property (nonatomic, weak) IBOutlet UILabel *lblWhoStart;
-(IBAction)startGame:(id)sender;

// During the Match - Host
@property (nonatomic, weak) IBOutlet UILabel *lblTimer;
@property (nonatomic, weak) IBOutlet UILabel *lblNowPlayingSong;
@property (nonatomic, weak) IBOutlet UILabel *lblSongArtist;
@property (nonatomic, weak) IBOutlet UILabel *lblSongTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgSongCover;

// During the Mathc - Guest
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnAnswers;
-(IBAction)sendAnswer:(UIButton*)sender;

// End of the Match
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)goBackToMultiplayerOptions:(id)sender;

@end
