//
//  EndMatchViewController.h
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 18/05/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EndMatchViewController : UIViewController
- (IBAction)replayMatch:(id)sender;
- (IBAction)backToHomeMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnReplay;
@property (weak, nonatomic) IBOutlet UIButton *btnBackToHomeMenu;

@property (nonatomic) int matchScore;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalScore;
@property (weak, nonatomic) IBOutlet UILabel *lblHeyPlayer;


@end
