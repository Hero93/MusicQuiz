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

@property (nonatomic, weak)     IBOutlet UILabel *lblQuestion;
@property (nonatomic, weak)     IBOutlet UILabel *lblTimer;
@property (weak, nonatomic)     IBOutlet UILabel *lblRound;
@property (nonatomic, strong)   IBOutletCollection(UIButton) NSArray *btnAnswers;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgStatus;


@property (weak, nonatomic)     IBOutlet UILabel *lblRisposta;
@property (weak, nonatomic)     IBOutlet UIImageView *imgFace;
@property (weak, nonatomic)     IBOutlet UILabel *lblScore;

- (IBAction)showAnswer:(id)sender;

@end
