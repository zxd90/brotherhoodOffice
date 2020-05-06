//
//  ClockView.h
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/28.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ClockonDelegate <NSObject>
-(void)Clockontap;
-(void)AccessDateAttendancetap;
@end
@interface ClockView : UIView

@property (nonatomic ,weak)id <ClockonDelegate> clockonDelegate;
-(void)addClockonarray:(NSArray*)arr addrestr:(NSString*)addrestr;
@end

NS_ASSUME_NONNULL_END
