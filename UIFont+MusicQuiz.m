//
//  UIFont+UIFont_MusicQuiz.m
//  MusicQuizV2
//
//  Created by Luca Gramaglia on 16/06/14.
//  Copyright (c) 2014 Luca Gramaglia. All rights reserved.
//

#import "UIFont+MusicQuiz.h"

@implementation UIFont (MusicQuiz)

+ (id) musicQuizFontRegularWithSize:(CGFloat) size
{
    return [UIFont fontWithName:@"Montserrat-Regular" size:size];
}

+ (id) musicQuizFontBoldWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Montserrat-Bold" size:size];
}
@end
