//
//  RqtDetailsCell.m
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/18.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "RqtDetailsCell.h"
#import "rqtDetModel.h"
@implementation RqtDetailsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews {
    self.timeLine = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 1, 60)];
       self.timeLine.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:231.0f/255.0f alpha:1.0f];
       [self.contentView addSubview:self.timeLine];
    self.cirlePoint = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 6)];
     self.cirlePoint.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:231.0f/255.0f alpha:1.0f];
     [self.contentView addSubview:self.cirlePoint];
     self.cirlePoint.layer.cornerRadius = 3;
     self.cirlePoint.layer.masksToBounds = YES;
     self.cirlePoint.centerX = 20 + self.timeLine.width * 0.5;
    
}


- (void)setModel:(rqtDetModel *)model {
    
    _model = model;
    
    UIColor *contextColor;
    if (model.wuliuCellPosition == WuliuCellPositionTop) {
        contextColor = [UIColor colorWithRed:60.0f/255.0f green:60.0f/255.0f blue:60.0f/255.0f alpha:1];
    }else {
        contextColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1];
    }
  
    model.rowHeight = self.timeLabel.bottom + 8;
    self.timeLine.top = 0;
    self.timeLine.height = model.rowHeight;
    self.cirlePoint.centerY = model.rowHeight * 0.5;
    
    if (model.wuliuCellPosition == WuliuCellPositionTop) {
        self.timeLine.top = model.rowHeight * 0.5;
        self.timeLine.height = model.rowHeight * 0.5;
    }else if (model.wuliuCellPosition == WuliuCellPositionTail){
        self.timeLine.height = model.rowHeight * 0.5;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
