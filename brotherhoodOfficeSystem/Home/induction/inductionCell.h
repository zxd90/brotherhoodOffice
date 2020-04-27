//
//  inductionCell.h
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/11.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//@protocol ZSTextViewCellDelegate <UITableViewDelegate>
//@required
//- (void)updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath;
//
//@end
@interface inductionCell : UITableViewCell<UITextViewDelegate>
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong) UITextView* textView;
@property(nonatomic,strong) UILabel * placeholderLabel;
//@property (nonatomic,strong) NSIndexPath * indexPath;
//@property (nonatomic,assign)id<ZSTextViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
