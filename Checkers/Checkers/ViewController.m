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
#import "StatusBar.h"

@interface ViewController ()

@property (weak, nonatomic) UIView* viewDesk;
@property (assign, nonatomic) CGPoint startTouchPoint;

@property (strong, nonatomic) NSMutableArray* checkersArray;
@property (strong, nonatomic) NSMutableArray* blackCellsArray;

@property (weak, nonatomic) CheckerView* dragingView;
@property (weak, nonatomic) BlackCellView* currentBlackCell;

@property (assign, nonatomic) CGPoint touchOffset;

@property (strong, nonatomic) StatusBar* statusBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createStatusBar];
    [self createDesk];
    
    self.statusBar.moveStatus = @"white";
    
}

#pragma mark - create status bar

- (void) createStatusBar {
    
    self.statusBar = [[StatusBar alloc] initWithFrame:CGRectMake(10, 30, CGRectGetWidth(self.view.frame) * 0.9f, 30)];
    
    [self.view addSubview:self.statusBar];
    
}

#pragma mark - create desk

- (void) createDesk {
    
    self.view.backgroundColor = [UIColor colorWithRed:34.0/255.0 green:34.0/255.0 blue:51.0/255.0 alpha:1.0];
    
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
    
    int k = 0;
    int l = 0;
    
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 4; j++) {
        
            BlackCellView* blackCell = [[BlackCellView alloc] initWithFrame:cellFrame];
            
            k = l + 1;
            l++;
            
//            0 1 2 3
//            1 3 5 7
//            2 4 6 8
            
            blackCell.coordinates = CGPointMake(j + k,i + 1);
            
            [viewDesk addSubview:blackCell];
            [self.blackCellsArray addObject:blackCell];
            
            cellFrame.origin.x += 2 * CGRectGetWidth(cellFrame);
            
        }
        
        !(i%2) ? (cellFrame.origin.x = 0) : (cellFrame.origin.x = CGRectGetWidth(cellFrame));
        
        !(i%2) ? (l = 0) : (l = 1);
        
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
            
            BlackCellView* currentCell = [self searchNearBlackCellAndBackLight:checker withBackLight:false];
            checker.currentCell = currentCell;
            
            [viewDesk addSubview:checker];
            [self.checkersArray addObject:checker];
            
            checkerFrame.origin.x += 2 * CGRectGetWidth(checkerFrame);
            
        }
        
        !(i%2) ? (checkerFrame.origin.x = 0) : (checkerFrame.origin.x = CGRectGetWidth(checkerFrame));
        checkerFrame.origin.y += CGRectGetWidth(checkerFrame);
        
    }
    
    self.viewDesk = viewDesk;
    
}

#pragma mark - game logic

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

- (BOOL) cellIsFree: (BlackCellView*) cellView {
    
    for (CheckerView* checker in self.checkersArray) {
        
        if ([cellView isEqual:checker.currentCell]) {
            return false;
        }
        
    }
    
    return true;
    
}

- (void) markFreeCells: (CGPoint) currentCoordinates {
    
    NSMutableArray* checkCoordinatesArray = [[NSMutableArray alloc] init];
    
    //check two lines
    [checkCoordinatesArray addObject:[NSValue valueWithCGPoint:CGPointMake(currentCoordinates.x-1, currentCoordinates.y-1)]];
    [checkCoordinatesArray addObject:[NSValue valueWithCGPoint:CGPointMake(currentCoordinates.x-1, currentCoordinates.y+1)]];
    [checkCoordinatesArray addObject:[NSValue valueWithCGPoint:CGPointMake(currentCoordinates.x+1, currentCoordinates.y-1)]];
    [checkCoordinatesArray addObject:[NSValue valueWithCGPoint:CGPointMake(currentCoordinates.x+1, currentCoordinates.y+1)]];
    
    BlackCellView* cellView = nil;
    
    for (int i = 0; i < [self.blackCellsArray count]; i++) {
        
        cellView = [self.blackCellsArray objectAtIndex:i];
        
        if ([checkCoordinatesArray containsObject:[NSValue valueWithCGPoint:cellView.coordinates]]) {
            if ([self cellIsFree:cellView]) {
                cellView.greenLight = true;
            }
        }
        
    }
    
}

- (void) deleteMarkFreeCells {
    
    for (BlackCellView* cellView in self.blackCellsArray) {
        cellView.greenLight = false;
    }
    
}

- (BlackCellView*) searchNearBlackCellAndBackLight: (CheckerView*) checkerView withBackLight:(BOOL) backLight {
    
    BlackCellView* cellView;
    
    CGPoint checkerCenter = checkerView.center;
    
    CGFloat minDistance = 1000;
    
    for (BlackCellView* blackCellView in self.blackCellsArray) {
        
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
    
    if (backLight) {
        cellView.backgroundColor = [UIColor whiteColor];
        cellView.layer.borderColor = [UIColor redColor].CGColor;
        cellView.layer.borderWidth = 3.f;
    }
    
    return cellView;
    
}

#pragma mark - touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch* anyTouch = [touches anyObject];
    CGPoint pointTouchView = [anyTouch locationInView:self.viewDesk];
    
    CheckerView* anyTouchView = (CheckerView*)[self.viewDesk hitTest:pointTouchView withEvent:event];
    
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
        
        self.currentBlackCell = [self searchNearBlackCellAndBackLight:self.dragingView withBackLight:true];
        [self markFreeCells:self.dragingView.currentCell.coordinates];
        
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [UIView animateWithDuration:.3f animations:^{
        self.dragingView.transform = CGAffineTransformIdentity;
        
    }];
    
    if (!self.currentBlackCell.greenLight) {
        self.dragingView.center = self.dragingView.currentCell.center;
    } else {
        self.dragingView.center = self.currentBlackCell.center;
        self.dragingView.currentCell = self.currentBlackCell;
    }

    self.currentBlackCell.backgroundColor = [UIColor blackColor];
    
    self.dragingView = nil;
    self.currentBlackCell = nil;
    
    [self deleteMarkFreeCells];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
    self.dragingView = nil;
}

@end
