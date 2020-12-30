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
    self.IMTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.IMTableView];
    
    self.userInteractionEnabled = YES;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = dataSource[indexPath.row];
    if ([model isKindOfClass:[IMModel class]]) {
        return [IMCell cellHeightModel:model];
    }
    return [UIScreen mainScreen].bounds.size.height / 35;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = dataSource[indexPath.row];
    if ([model isKindOfClass:[IMModel class]]) {
        //
        IMModel *m1 = (IMModel *)model;
        NSString *normalStr = [IMCell cellStrModel:m1];
        IMCell *cell = [tableView dequeueReusableCellWithIdentifier:normalStr];
        if (cell == nil) {
            cell = [[IMCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalStr model:m1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell changeModel:m1];//数据在这里加载
        /*
         关于时间model添加,每添加一条消息的时候,判断当前消息和上一条消息的时间差,在某个范围之内不添加,范围之外则添加;
         */
        return cell;

    }else{
        //
        IMTimeModel *m2 = (IMTimeModel *)model;
        static NSString *timeStr = @"timeStr";
        IMTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:timeStr];
        if (cell == nil) {
            cell = [[IMTimeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:timeStr];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.timeLabel.text = m2.time;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
//
- (void)setIMDataArray:(NSArray *)IMDataArray{
    dataSource = [IMDataArray copy];
    [self.IMTableView reloadData];
}

-(void)addData:(IMModel *)model{
    NSMutableArray *newArr = [[NSMutableArray alloc]initWithArray:dataSource];
    NSInteger code = 0;
    //这个方法插入的数据肯定是数据而不是时间model,时间model只是在判断下觉得是否要插入(是不是跟最新的时间model比较?)
#pragma mark 对时间进行判断,是否要插入时间model;
    NSMutableArray *timeArr = [[NSMutableArray alloc]init];
    for (NSUInteger i = 0; i < newArr.count; i ++) {
        id m = newArr[i];
        if ([m isKindOfClass:[IMTimeModel class]]) {
            [timeArr addObject:m];
        }
    }
    
    
    if (timeArr.count > 0) {
        id model1 = [timeArr lastObject];//找出最新的timeModel,跟最新的消息比较,如果没有新加;
        IMTimeModel *model2 = (IMTimeModel *)model1;
        
        NSDateFormatter *matter = [[NSDateFormatter alloc]init];
        [matter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSDate *date = [matter dateFromString:model2.time];//最新时间model的时间
        NSDate *date1 = [matter dateFromString:model.time];//当前消息的时间
        
        NSTimeInterval timeInterval = - [date timeIntervalSinceDate:date1];
        if (timeInterval < 60) {//60秒
            NSLog(@"不超过");
            code = 0;
        }else{
            NSLog(@"超过");
            //添加时间Model,内部处理
            IMTimeModel *timeModel = [[IMTimeModel alloc]init];
            timeModel.time = model.time;
            [newArr addObject:timeModel];
            code = 1;
        }

    }
    
    [newArr addObject:model];
    dataSource = [newArr copy];

    if (code == 0) {
        NSIndexPath *myIndexPath = [NSIndexPath indexPathForRow:dataSource.count - 1 inSection:0];
        [self.IMTableView insertRowsAtIndexPaths:@[myIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self.IMTableView selectRowAtIndexPath:myIndexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
    }else{
        NSIndexPath *myIndexPath = [NSIndexPath indexPathForRow:dataSource.count - 2 inSection:0];
        NSIndexPath *myIndexPath1 = [NSIndexPath indexPathForRow:dataSource.count - 1 inSection:0];
        [self.IMTableView insertRowsAtIndexPaths:@[myIndexPath,myIndexPath1] withRowAnimation:UITableViewRowAnimationNone];
        [self.IMTableView selectRowAtIndexPath:myIndexPath1 animated:YES scrollPosition:UITableViewScrollPositionBottom];
    }

//    [self.IMTableView reloadData];
    
//    [self scrollBottom:YES];
}
-(void)scrollBottom:(BOOL)animated{
    NSIndexPath *path = [NSIndexPath indexPathForRow:dataSource.count - 1 inSection:0];
    [self.IMTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:animated];
}
- (void)layoutSubviews{
    [super layoutSubviews];
}

@end

/*
 多个cell和model
 根据model来判断加载那个cell;不用判断加载那些子控件
 单个cell和model
 根据model中的数据类型来决定cell中加载那些子控件;cell创建时要把model传进去,决定add那些子控件
 性能是一样的,都要判断,都要决定加载cell的那些子控件;
 
 创建cell时,把子控件加载到cell上面;
 根据model类型,赋值子控件frame和数据;
 
 复用cell,在创建时,根据model类型,赋予不同的复用标识;
 
 cell高度,根据model来赋值不同的高度,高度跟整个屏幕高度相关,唯一变化的是富文本时需要计算富文本的高度;
 */
