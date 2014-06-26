//
//  GuestViewController.h
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 15/06/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuestViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *answers;
@property (weak, nonatomic) IBOutlet UILabel *lblTimer;

- (IBAction)showCorrectAnswer:(UIButton *)sender;

@end
