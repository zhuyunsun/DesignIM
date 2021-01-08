//
//  IMFaceView.m
//  DesignIM
//
//  Created by 朱运 on 2021/1/6.
//

#import "IMFaceView.h"
@interface IMFaceView()<UICollectionViewDelegate,UICollectionViewDataSource>{
    CGFloat height;
    CGFloat width;
    UICollectionView *faceCollectView;
    NSArray *dataSource;
}
@end
static NSString *cellStr = @"faceCell1";
@implementation IMFaceView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        height = frame.size.height;
        width = frame.size.width;
        
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        NSUInteger allCount = 106 + 8;
        for (NSUInteger i = 1; i < allCount; i ++) {
            NSString *str = [NSString stringWithFormat:@"Expression_%ld",i];
            [arr addObject:str];
        }
        dataSource = [arr copy];
        
        CGRect rect = CGRectMake(0, 0, width, height);
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        CGFloat itemHei = width *0.09;
        CGFloat itemLine = (width - itemHei *8) / 9;
        layout.sectionInset = UIEdgeInsetsMake(itemLine, itemLine,itemLine,itemLine);
        layout.minimumLineSpacing = itemLine;
        layout.itemSize = CGSizeMake(itemHei,itemHei);
        
        faceCollectView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:layout];
        faceCollectView.delegate = self;
        faceCollectView.dataSource = self;
        faceCollectView.backgroundColor = [UIColor clearColor];
        [faceCollectView registerClass:[FaceCell class] forCellWithReuseIdentifier:@"faceCell"];
        [self addSubview:faceCollectView];
        
        //
        CGFloat btnHeight = width *0.1;
        UIImage *delectImage = [UIImage imageNamed:@"delete"];
        UIButton *delectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        delectButton.frame = CGRectMake(width *0.70,height *0.98 - btnHeight,btnHeight,btnHeight);
        [delectButton setImage:delectImage forState:UIControlStateNormal];
        delectButton.backgroundColor = [UIColor whiteColor];
        [delectButton addTarget:self action:@selector(delectAction) forControlEvents:UIControlEventTouchDown];
        [self addSubview:delectButton];
        
        UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sendButton.frame = CGRectMake(CGRectGetMaxX(delectButton.frame) + width *0.01,height *0.98 - btnHeight,width *0.15,btnHeight);
        [sendButton setTitle:@"send" forState:UIControlStateNormal];
        [sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        sendButton.backgroundColor = [UIColor whiteColor];
        [sendButton addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchDown];
        [self addSubview:sendButton];

        /*
         思考:
         如果表情个数刚好被删除按钮和发送按钮挡住怎么办?
         
         填充空数据进数组,增加cell的个数;
         
         */
        NSLog(@"高度 = %f",faceCollectView.collectionViewLayout.collectionViewContentSize.height);
        
    }
    return self;
}
#pragma mark actions
-(void)sendAction{
    if ([self.delegate respondsToSelector:@selector(getSendAction)]) {
        [self.delegate getSendAction];
    }
}

-(void)delectAction{
    if ([self.delegate respondsToSelector:@selector(getDeleteAction)]) {
        [self.delegate getDeleteAction];
    }
}
#pragma mark delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataSource.count;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSUInteger row = indexPath.row;
    if (row > 104) {
        NSLog(@"越界?NO,插入的空数据图片名称");
        return;
    }
    if ([self.delegate respondsToSelector:@selector(getFaceName:)]) {
        NSString *name = dataSource[row];
        //左右加[],保证和文本不一样.
        name = [@"[" stringByAppendingString:name];
        name = [name stringByAppendingString:@"]"];
        
        [self.delegate getFaceName:name];
    }
}
- (FaceCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"faceCell" forIndexPath:indexPath];
    if (!cell) {
        NSLog(@"复用");
    }
    if (indexPath.row < dataSource.count) {
        NSString *imageName = dataSource[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:imageName];
    }
    return cell;
}

@end


@implementation FaceCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]init];
        self.imageView.frame = CGRectMake(0,0,frame.size.width,frame.size.height);
        self.imageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}
@end
