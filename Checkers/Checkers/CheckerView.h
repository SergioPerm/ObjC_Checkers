//
//  CheckerView.h
//  Checkers
//
//  Created by kluv on 23.03.2019.
//  Copyright © 2019 Сергей Лепинин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BlackCellView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckerView : UIView

@property (weak, nonatomic) BlackCellView* currentCell;

- (id)initWithFrameAndStatus:(CGRect)frame andStatus:(NSString*) statusChecker;

@end

NS_ASSUME_NONNULL_END
