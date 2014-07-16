//
//  GameModeViewController.h
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 13/05/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicQuizModeTypes.h"

@interface MatchModeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblGameMode;

@property (weak, nonatomic) IBOutlet UIButton *TitleMode;
@property (weak, nonatomic) IBOutlet UIButton *ArtistMode;
@property (weak, nonatomic) IBOutlet UIButton *ArtistAndTitleMode;

@property (weak, nonatomic) NSString *gameMode;

- (IBAction)launchTitleMode:(id)sender;
- (IBAction)lauchArtistMode:(id)sender;
- (IBAction)launchArtistAndTitleMode:(id)sender;

@end
