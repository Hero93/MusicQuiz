//
//  GameModeViewController.h
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 15/06/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameModeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblGameMode;
@property (weak, nonatomic) IBOutlet UIButton *btnSinglePlayer;
@property (weak, nonatomic) IBOutlet UIButton *btnMultiPlayer;



- (IBAction)playSingleplayer:(UIButton *)sender;
- (IBAction)playMultiplayer:(UIButton *)sender;

@end
