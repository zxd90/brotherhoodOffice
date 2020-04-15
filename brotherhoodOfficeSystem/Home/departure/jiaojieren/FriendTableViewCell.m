//
//  FriendTableViewCell.m
//  核心动画
//
//  Created by 朱伟阁 on 2019/1/27.
//  Copyright © 2019 朱伟阁. All rights reserved.
//

#import "FriendTableViewCell.h"
#import "FriendModel.h"

@implementation FriendTableViewCell

+ (instancetype)friendTableViewCellWithTableView:(UITableView *)tableview{
    FriendTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:NSStringFromClass([FriendTableViewCell class])];
    if(cell == nil){
        cell = [[FriendTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSStringFromClass([FriendTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setFriendModel:(FriendModel *)friendModel{
    _friendModel = friendModel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:friendModel.headImg] placeholderImage:[UIImage imageNamed:@""]];
    self.textLabel.text = friendModel.userName ;
    self.detailTextLabel.text = friendModel.intro;
   self.detailTextLabel.textColor = [UIColor blackColor];
}

@end
