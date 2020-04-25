//
//  mytableView.h
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/24.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol mytableViewDelegate <NSObject>

-(void)tableViewsection:(UITableView *)tableView mytableViewClick:(NSIndexPath*)indexPath;
-(void)mytableViewtap;
@end
@interface mytableView : UIView
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic ,weak)id <mytableViewDelegate> mytableDelegate;
@end

NS_ASSUME_NONNULL_END
