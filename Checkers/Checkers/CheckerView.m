//
//  CheckerView.m
//  Checkers
//
//  Created by kluv on 23.03.2019.
//  Copyright © 2019 Сергей Лепинин. All rights reserved.
//

#import "CheckerView.h"

@implementation CheckerView

- (id)initWithFrameAndStatus:(CGRect)frame andStatus: (CheckerType) statusChecker
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage* imageCheker = [[UIImage alloc] init];
        
        if (statusChecker == WHITE) {
            imageCheker = [UIImage imageNamed:@"whiteChecker.png"];
        } else if (statusChecker == BLACK) {
            imageCheker = [UIImage imageNamed:@"blackChecker.png"];
        }
        
        self.checkerStatus = statusChecker;
        
        UIImageView* imageCheckerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetWidth(frame))];
        imageCheckerView.image = imageCheker;
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:imageCheckerView];
        
    }
    return self;
}

@end
