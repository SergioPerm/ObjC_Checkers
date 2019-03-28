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

@property (strong, nonatomic) NSMutableArray* checkersArray;
@property (strong, nonatomic) NSMutableArray* blackCellsArray;

@property (weak, nonatomic) UIView* dragingView;
@property (weak, nonatomic) UIView* currentBlackCell;

@property (assign, nonatomic) CGPoint touchOffset;

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
    
    self.blackCellsArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 4; j++) {
        
            BlackCellView* blackCell = [[BlackCellView alloc] initWithFrame:cellFrame];
            
            [viewDesk addSubview:blackCell];
            [self.blackCellsArray addObject:blackCell];
            
            cellFrame.origin.x += 2 * CGRectGetWidth(cellFrame);
            
        }
        
        !(i%2) ? (cellFrame.origin.x = 0) : (cellFrame.origin.x = CGRectGetWidth(cellFrame));
        cellFrame.origin.y += CGRectGetWidth(cellFrame);
    }
    
    NSString* statusChecker;
    CGRect checkerFrame = CGRectMake(cellLength, 0, cellLength, cellLength);
    
    self.checkersArray = [[NSMutableArray alloc] init];
    
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
            [self.checkersArray addObject:checker];
            
            checkerFrame.origin.x += 2 * CGRectGetWidth(checkerFrame);
            
        }
        
        !(i%2) ? (checkerFrame.origin.x = 0) : (checkerFrame.origin.x = CGRectGetWidth(checkerFrame));
        checkerFrame.origin.y += CGRectGetWidth(checkerFrame);
        
    }
    
    self.viewDesk = viewDesk;
    
}

- (BOOL) isCheckerView: (UIView*) touchView {
    
    BOOL touchViewIsChecker = false;
    
    for (UIView* anyView in self.checkersArray) {
        
        if ([anyView isEqual:touchView]) {
            touchViewIsChecker = true;
            break;
        }
        
    }
    
    return touchViewIsChecker;
}

- (UIView*) searchNearBlackCellAndBackLight: (UIView*) checkerView {
    
    UIView* cellView = [[UIView alloc] init];

    CGPoint checkerCenter = checkerView.center;
    
    CGFloat minDistance = 1000;
    
    for (UIView* blackCellView in self.blackCellsArray) {
        
        CGFloat diffX = checkerCenter.x - blackCellView.center.x;
        diffX = diffX > 0 ? diffX : -diffX;
        
        CGFloat diffY = checkerCenter.y - blackCellView.center.y;
        diffY = diffY > 0 ? diffY : -diffY;
        
        CGFloat currentDist = diffX + diffY;
        
        if (currentDist < minDistance) {
            minDistance = currentDist;
            cellView = blackCellView;
        }

        blackCellView.backgroundColor = [UIColor blackColor];
        blackCellView.layer.borderWidth = 0.f;
        blackCellView.layer.borderColor = [UIColor clearColor].CGColor;
        
    }
    
    cellView.backgroundColor = [UIColor whiteColor];
    cellView.layer.borderColor = [UIColor redColor].CGColor;
    cellView.layer.borderWidth = 3.f;
    
    return cellView;
    
}

#pragma mark - touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch* anyTouch = [touches anyObject];
    CGPoint pointTouchView = [anyTouch locationInView:self.viewDesk];
    
    UIView* anyTouchView = [self.viewDesk hitTest:pointTouchView withEvent:event];
    
    self.startTouchPoint = pointTouchView;
    
    if ([self isCheckerView:anyTouchView]) {
        
        self.dragingView = anyTouchView;
        
        [UIView animateWithDuration:.3f animations:^{
            self.dragingView.transform = CGAffineTransformMakeScale(1.3f, 1.3f);
        }];
        
        [self.viewDesk bringSubviewToFront:self.dragingView];
        
        CGPoint touchPoint = [anyTouch locationInView:self.dragingView];
        self.touchOffset = CGPointMake(CGRectGetMidX(self.dragingView.bounds) - touchPoint.x,
                                       CGRectGetMidY(self.dragingView.bounds) - touchPoint.y);
        
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (self.dragingView) {
        
        UITouch* anyTouch = [touches anyObject];
        
        CGPoint pointTouchView = [anyTouch locationInView:self.viewDesk];
        
        CGPoint correctionPoint = CGPointMake(pointTouchView.x + self.touchOffset.x, pointTouchView.y + self.touchOffset.y);
        
        self.dragingView.center = correctionPoint;
        
        self.currentBlackCell = [self searchNearBlackCellAndBackLight:self.dragingView];
        
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [UIView animateWithDuration:.3f animations:^{
        self.dragingView.transform = CGAffineTransformIdentity;
        
    }];
    
    self.dragingView.center = self.currentBlackCell.center;
    self.currentBlackCell.backgroundColor = [UIColor blackColor];
    
    self.dragingView = nil;
    self.currentBlackCell = nil;
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
    self.dragingView = nil;
}

@end
