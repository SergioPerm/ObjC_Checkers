//
//  BlackCellView.m
//  Checkers
//
//  Created by kluv on 23.03.2019.
//  Copyright © 2019 Сергей Лепинин. All rights reserved.
//

#import "BlackCellView.h"

@implementation BlackCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.6f;
                
    }
    return self;
}

@end
