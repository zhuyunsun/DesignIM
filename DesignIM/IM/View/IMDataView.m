//
//  DataView.m
//  DesignIM
//
//  Created by 朱运 on 2020/12/24.
//

#import "IMDataView.h"

@interface IMDataView()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *dataSource;
}
@end
@implementation IMDataView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self addView];
    }
    return self;
}
-(void)addView{
    self.IMTableView = [[UITableView alloc]init];
    self.IMTableView.frame = CGRectMake(0, 0, self.width, self.height);
    self.IMTableView.dataSource = self;
    self.IMTableView.delegate = self;
    self.IMTableView.tableFooterView = [[UIView alloc]init];
    [self addSubview:self.IMTableView];
    
    
    self.userInteractionEnabled = YES;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = dataSource[indexPath.row];
    if ([model isKindOfClass:[TextModel class]]) {
        return [FFTextCell cellHeight];
    }
    return 70;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
- (CommonCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = dataSource[indexPath.row];
    CommonCell *cell;
    if ([model isKindOfClass:[TextModel class]]) {
        //加载文本
        static NSString *normalStr = @"normalStr";
        cell = [tableView dequeueReusableCellWithIdentifier:normalStr];
        if (cell == nil) {
            cell = [[FFTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalStr];
        }
        [cell changeModel:model];
        TextModel *modelText = (TextModel *)model;
        cell.nameLabel.text = modelText.nickName;

    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
//
- (void)setIMDataArray:(NSArray *)IMDataArray{
    dataSource = [IMDataArray copy];
    [self.IMTableView reloadData];
}

-(void)addData:(CommonModel *)model{
    NSMutableArray *newArr = [[NSMutableArray alloc]initWithArray:dataSource];
    [newArr addObject:model];
    dataSource = [newArr copy];
    [self.IMTableView reloadData];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"发生改变");
}
@end
