//
//  StatusBar.h
//  Checkers
//
//  Created by Сергей Лепинин on 02/04/2019.
//  Copyright © 2019 Сергей Лепинин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"

NS_ASSUME_NONNULL_BEGIN

@interface StatusBar : UIView

@property (strong, nonatomic) UILabel* textLabel;
@property (assign, nonatomic) CheckerType moveStatus;

- (void) changePlayer;

@end

NS_ASSUME_NONNULL_END
