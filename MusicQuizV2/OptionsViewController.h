//
//  OptionsViewController.h
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 15/07/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionsViewController : UIViewController

- (IBAction)numberOfQuestionChanged:(UISlider *)sender;
- (IBAction)questionDurationChanged:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblNumberOfQuestions;
@property (weak, nonatomic) IBOutlet UILabel *lblQuestionDuration;
@property (weak, nonatomic) IBOutlet UISlider *sliderNumberOfQuestions;
@property (weak, nonatomic) IBOutlet UISlider *sliderQuestionDuration;




@end
