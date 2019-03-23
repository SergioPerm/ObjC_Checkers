//
//  CheckerView.h
//  Checkers
//
//  Created by kluv on 23.03.2019.
//  Copyright © 2019 Сергей Лепинин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckerView : UIView

- (id)initWithFrameAndStatus:(CGRect)frame andStatus:(NSString*) statusChecker;

@end

NS_ASSUME_NONNULL_END
