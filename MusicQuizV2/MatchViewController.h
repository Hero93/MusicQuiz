//
//  MatchViewController.h
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 07/05/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicQuiz.h"


@interface MatchViewController : UIViewController <MusicQuizDelegate>

- (id)initWithQuizMode:(int)gameMode;

@property (weak, nonatomic)     IBOutlet UILabel *lblMbatchStatus;
@property (nonatomic, weak)     IBOutlet UILabel *lblQuestion;
@property (weak, nonatomic)     IBOutlet UILabel *lblRound;
@property (nonatomic, strong)   IBOutletCollection(UIButton) NSArray *btnAnswers;
@property (nonatomic, weak)     IBOutlet UILabel *lblTimer;
@property (weak, nonatomic)     IBOutlet UILabel *lblRisposta;

- (IBAction)replayMatch:(id)sender;
- (IBAction)showAnswer:(id)sender;

@end
