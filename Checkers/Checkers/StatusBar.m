//
//  StatusBar.m
//  Checkers
//
//  Created by Сергей Лепинин on 02/04/2019.
//  Copyright © 2019 Сергей Лепинин. All rights reserved.
//

#import "StatusBar.h"

@implementation StatusBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //self.backgroundColor = [UIColor colorWithRed:34.0/255.0 green:34.0/255.0 blue:51.0/255.0 alpha:1.0];
        //self.alpha = 0.4f;
        
        self.textLabel = [[UILabel alloc] initWithFrame:frame];
        
        [self.textLabel setText:@"Game test text!"];
        [self.textLabel setBackgroundColor:[UIColor clearColor]];
        [self.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:20.0f]];
        [self.textLabel setTextColor:[UIColor colorWithRed:170.0/255.0 green:204.0/255.0 blue:255.0/255.0 alpha:1.0]];
        [self addSubview:self.textLabel];
        
    }
    return self;
}

- (void) setMoveStatus:(NSString *)moveStatus {
    
    if ([moveStatus isEqualToString:@"white"]) {
        [_textLabel setText:@"WHITE'S MOVE!"];
    } else {
        [_textLabel setText:@"BLACK MOVE!"];
    }
    
}

@end
