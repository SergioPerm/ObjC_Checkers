//
//  CheckerView.m
//  Checkers
//
//  Created by kluv on 23.03.2019.
//  Copyright © 2019 Сергей Лепинин. All rights reserved.
//

#import "CheckerView.h"

@implementation CheckerView

- (id)initWithFrameAndStatus:(CGRect)frame andStatus: (NSString*) statusChecker
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage* imageCheker = [[UIImage alloc] init];
        
        if ([statusChecker isEqualToString:@"white"]) {
            imageCheker = [UIImage imageNamed:@"checkerWhite.png"];
        } else {
            imageCheker = [UIImage imageNamed:@"checkerBlack.png"];
        }
        
        UIImageView* imageCheckerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetWidth(frame))];
        imageCheckerView.image = imageCheker;
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:imageCheckerView];
        
    }
    return self;
}

@end
