//
//  ViewController.m
//  Checkers
//
//  Created by Сергей Лепинин on 22/03/2019.
//  Copyright © 2019 Сергей Лепинин. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createDesk];
    
}

#pragma mark - create desk

- (void) createDesk {
    
    CGFloat originYDesk = CGRectGetMidY(self.view.frame) - (CGRectGetWidth(self.view.frame)/2);
    CGFloat sideLength = CGRectGetWidth(self.view.frame);
    
    UIView* viewDesk = [[UIView alloc] initWithFrame:CGRectMake(0, originYDesk, sideLength, sideLength)];
    
    viewDesk.backgroundColor = [UIColor clearColor];
    viewDesk.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    [self.view addSubview:viewDesk];
    
    UIImageView* imageViewDesk = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sideLength, sideLength)];
    imageViewDesk.image = [UIImage imageNamed:@"woodDesk.jpg"];
    
    [viewDesk addSubview:imageViewDesk];
    
    
    
}

@end
