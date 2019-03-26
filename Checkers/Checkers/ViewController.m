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

@property (weak, nonatomic) UIView* viewDesk;
@property (assign, nonatomic) CGPoint startTouchPoint;


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
    
    NSString* statusChecker;
    CGRect checkerFrame = CGRectMake(cellLength, 0, cellLength, cellLength);
    
    for (int i = 0; i < 8; i++) {
        
        if (i < 3) {
            statusChecker = @"white";
        } else if (i > 4) {
            statusChecker = @"black";
        } else {
            checkerFrame.origin.y += cellLength;
            continue;
        }
        
        for (int j = 0; j < 4; j++) {
            
            CheckerView* checker = [[CheckerView alloc] initWithFrameAndStatus:checkerFrame andStatus:statusChecker];
            [viewDesk addSubview:checker];
            
            checkerFrame.origin.x += 2 * CGRectGetWidth(checkerFrame);
            
        }
        
        !(i%2) ? (checkerFrame.origin.x = 0) : (checkerFrame.origin.x = CGRectGetWidth(checkerFrame));
        checkerFrame.origin.y += CGRectGetWidth(checkerFrame);
        
    }
    
}

#pragma mark - touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch* anyTouch = [touches anyObject];
    CGPoint pointTouchView = [anyTouch locationInView:self.viewDesk];
    
    UIView* anyTouchView = [self.viewDesk hitTest:pointTouchView withEvent:event];
    
    self.startTouchPoint = pointTouchView;
    
    
    
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
}

@end
