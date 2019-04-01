//
//  BlackCellView.h
//  Checkers
//
//  Created by kluv on 23.03.2019.
//  Copyright © 2019 Сергей Лепинин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlackCellView : UIView

@property (assign, nonatomic) CGPoint coordinates;
@property (assign, nonatomic) BOOL greenLight;

@end

NS_ASSUME_NONNULL_END
