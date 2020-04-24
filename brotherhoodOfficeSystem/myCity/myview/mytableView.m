//
//  mytableView.m
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/24.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "mytableView.h"
#import "LBClearCacheTool.h"
@interface mytableView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;

@property (nonatomic, strong) UILabel *accountLabel;
@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, copy) NSArray *detailText;
@property (nonatomic, strong)  NSString *fileSize;
@end
@implementation mytableView
-(instancetype)initWithFrame:(CGRect)frame{

    if(self = [super initWithFrame:frame]){
         
          _fileSize = [LBClearCacheTool getCacheSizeWithFilePath:kCachePath];
          _dataArray=@[@[@"部门",@"职位"],@[@"清除缓存",@"版本号"],@[@"修改密码"]];
          _imageArray=@[@[@"bumen",@"zhiwu"],@[@"huancun",@"banbenhao"],@[@"anquanzhongxin"]];
          _detailText=@[@[kFetchMyDefault(@"depName"),kFetchMyDefault(@"roleName")],@[_fileSize, APP_VERSION],@[@""]];
          self.tableView.hidden = NO;
    }
    return  self;
}
#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, ScreenH-SK_TabbarSafeBottomMargin) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
         [self addSubview:_tableView];
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 187)];
              [self setUpHeadView:headView];
              headView.userInteractionEnabled = YES;
            _tableView.tableHeaderView = headView;
              UITapGestureRecognizer *icoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIcon:)];
              [headView addGestureRecognizer:icoTap];
       
    }
    return _tableView;
}
- (void)setUpHeadView:(UIView *)supView{
    //头像
    self.image = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.image.layer.cornerRadius = 34;
    self.image.layer.masksToBounds = YES;
    self.image.userInteractionEnabled = YES;
    [supView addSubview:self.image];
    /*在这里使用masonry控制，会爆出约束冲突，但是不影响使用，所以就不管了*/
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(70);
        make.left.mas_equalTo(32);
        make.width.height.mas_equalTo(68);
    }];
    [self.image sd_setImageWithURL:[NSURL URLWithString:kFetchMyDefault(@"headImg") ] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    //账号
    self.accountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [supView addSubview:self.accountLabel];
    self.accountLabel.font = [UIFont systemFontOfSize:18];
    self.accountLabel.text = kFetchMyDefault(@"userName");
    /*在这里使用masonry控制，会爆出约束冲突，但是不影响使用，所以就不管了*/
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.image.mas_centerY);
        make.left.equalTo(self.image.mas_right).mas_equalTo(27);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(30);
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
return 50;
     
}
#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
return [_dataArray[section]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
         static NSString *cellID = @"testCell";
                   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                   if (!cell) {
                       cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
                   }
              cell.selectionStyle = UITableViewCellSelectionStyleNone;
              cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",_imageArray[indexPath.section][indexPath.row]]];
              cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
              cell.textLabel.text =_dataArray[indexPath.section][indexPath.row];
              cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0f];
              cell.detailTextLabel.text=_detailText[indexPath.section][indexPath.row];
             if(indexPath.section==2){
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
              }
    return cell;
}
//使cell的下划线顶头
-(void)tableView:(UITableView* )tableView willDisplayCell:(UITableViewCell* )cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
    [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
}
#pragma mark - delegate
//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    if(indexPath.section==1&&indexPath.row==0){
        NSLog(@"23123123");
          kSaveMyDefault(@"asName",@"");
        //清楚缓存
        BOOL isSuccess = [LBClearCacheTool clearCacheWithFilePath:kCachePath];
        if (isSuccess) {
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               
            });
        }
    }else{
        if([self.mytableDelegate respondsToSelector:@selector(tableViewsection: mytableViewClick:)]){
                           [self.mytableDelegate tableViewsection:indexPath.section mytableViewClick:indexPath.row];
                       }
    }
   
   
     
}

//点击头像
- (void)tapIcon:(UITapGestureRecognizer *)tap{

    if ([self.mytableDelegate respondsToSelector:@selector(mytableViewtap)]) {
        [self.mytableDelegate mytableViewtap];
    }
}
//底部
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
      
    return 15 ;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, 15)];
    if (section!=4) {
       headerView.backgroundColor=RGB(238, 238, 238);
    }
    return headerView;
}

@end
