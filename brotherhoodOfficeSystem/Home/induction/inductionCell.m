//
//  inductionCell.m
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/11.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "inductionCell.h"

@implementation inductionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

       [self.contentView addSubview:self.titleLabel]; //标题文字
//     [self addSubview:self.rightImg] ; //右侧箭头
    
       [self.contentView addSubview:self.textView]; //右侧扩展说明内容
       [self.textView addSubview:self.placeholderLabel];
        
    }
    return self;
}
//布局
-(void)layoutSubviews{
[super layoutSubviews];
    //计算文字的宽度

  CGFloat  width = [ZXDmethod calculateRowWidth:self.titleLabel.text Font:17.0];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(self.contentView.mas_left).offset(15);
      make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
      make.width.mas_equalTo(width);
           }];
     //顶部的约束优先级最高，那么会先改变约束优先级高的，这样避免了底部在输入的换行自适应是的上下跳动问题
      [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
      
       make.left.mas_equalTo(self.titleLabel.mas_right).offset(5);
       make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
       make.top.mas_equalTo(self.contentView.mas_top).offset(5).priority(999);;
//       make.height.mas_equalTo(20);
      make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5).priority(777);;
          }];
     [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          
          make.left.mas_equalTo(self.textView.mas_left).offset(3);
          make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
          make.top.mas_equalTo(self.textView.mas_top).offset(-5);
          make.height.mas_equalTo(50);
     }];
}
#pragma mark--懒加载
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.numberOfLines = 1;
         _titleLabel.font = [UIFont systemFontOfSize:16.0];
    }
    return _titleLabel ;
}
-(UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _placeholderLabel.numberOfLines = 1;
        _placeholderLabel.textColor=[UIColor lightGrayColor];
        _placeholderLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return _placeholderLabel ;
}

-(UITextView *)textView{
    if (!_textView) {
            _textView = [[UITextView alloc]initWithFrame:CGRectZero];
//           _textView.delegate=self;
           _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _textView.font=[UIFont systemFontOfSize:15.0];
           _textView.scrollEnabled=NO;
           _textView.showsVerticalScrollIndicator = NO;
           _textView.showsHorizontalScrollIndicator = NO;
           _textView.returnKeyType=UIReturnKeyDone;
           _textView.keyboardType=UIKeyboardTypeDefault;
           _textView.backgroundColor=[UIColor clearColor];
       
    }
    return _textView ;
}
//- (void)setIndexPath:(NSIndexPath *)indexPath {
//    _indexPath=indexPath;
//}
//-(void)textViewDidChange:(UITextView *)textView{
//    if (textView.text.length==0) {
//        _placeholderLabel.hidden=NO;
//    } else {
//        _placeholderLabel.hidden=YES;
//    }
//    if ([self.delegate respondsToSelector:@selector(updatedText:atIndexPath:)]) {
//        [self.delegate updatedText:textView.text atIndexPath:_indexPath];
//    }
//    CGRect frame = textView.frame;
//    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
//    CGSize size = [textView sizeThatFits:constraintSize];
//    textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
//    [_tableView beginUpdates];
//    [_tableView endUpdates];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
