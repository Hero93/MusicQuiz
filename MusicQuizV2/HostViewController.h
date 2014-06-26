//
//  HostViewController.h
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 15/06/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HostViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblSongTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSongArtist;
@property (weak, nonatomic) IBOutlet UIImageView *imgSongCover;

@end
