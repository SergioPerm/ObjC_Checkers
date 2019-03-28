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
#import "Constants.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckerView : UIView

@property (weak, nonatomic) BlackCellView* currentCell;
//@property (assign, nonatomic) NSString

- (id)initWithFrameAndStatus:(CGRect)frame andStatus:(NSString*) statusChecker;

@end

NS_ASSUME_NONNULL_END
