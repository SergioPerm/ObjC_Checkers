//
//  ViewController.m
//  Checkers
//
//  Created by Сергей Лепинин on 22/03/2019.
//  Copyright © 2019 Сергей Лепинин. All rights reserved.
//

#import "ViewController.h"
#import "BlackCellView.h"
#import "CheckerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createDesk];
    
}

#pragma mark - create desk

- (void) createDesk {
    
    self.view.backgroundColor = [UIColor blackColor];
    
    CGFloat originYDesk = CGRectGetMidY(self.view.frame) - (CGRectGetWidth(self.view.frame)/2);
    CGFloat sideLength = CGRectGetWidth(self.view.frame);
    
    UIView* viewDesk = [[UIView alloc] initWithFrame:CGRectMake(0, originYDesk, sideLength, sideLength)];
    
    viewDesk.backgroundColor = [UIColor clearColor];
    viewDesk.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    [self.view addSubview:viewDesk];
    
    UIImageView* imageViewDesk = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sideLength, sideLength)];
    imageViewDesk.image = [UIImage imageNamed:@"desk.jpg"];
    
    [viewDesk addSubview:imageViewDesk];
    
    CGFloat cellLength = sideLength/8;
    
    CGRect cellFrame = CGRectMake(cellLength, 0, cellLength, cellLength);
    
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 4; j++) {
        
            BlackCellView* blackCell = [[BlackCellView alloc] initWithFrame:cellFrame];
            
            [viewDesk addSubview:blackCell];
            
            cellFrame.origin.x += 2 * CGRectGetWidth(cellFrame);
            
        }
        
        !(i%2) ? (cellFrame.origin.x = 0) : (cellFrame.origin.x = CGRectGetWidth(cellFrame));
        cellFrame.origin.y += CGRectGetWidth(cellFrame);
    }
    
    CheckerView* checker = [[CheckerView alloc] initWithFrameAndStatus:CGRectMake(0, 0, 40, 40) andStatus:@"white"];
    
}

@end
