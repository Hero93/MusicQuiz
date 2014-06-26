//
//  FirstTimeViewController.h
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 25/05/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstTimeViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblHi;
@property (weak, nonatomic) IBOutlet UIButton *btnReady;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
- (IBAction)takeMeToTheGameMode:(id)sender;

@end
