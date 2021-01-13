//
//  IMLocationViewController.m
//  DesignIM
//
//  Created by 朱运 on 2021/1/13.
//

#import "IMLocationViewController.h"

@interface IMLocationViewController ()<MKMapViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    CLLocationManager *location;
    CLLocation *location2D;
    
    NSMutableArray *addressArr;
    UITableView *addressTableView;
    NSUInteger selectCode;
}
@property(nonatomic,strong)MKMapView *map;
@end

@implementation IMLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     功能,发送当前位置信息;
     */
    self.title = @"当前位置";
    selectCode = 0;
    //左边item
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"send" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];

    
    location = [[CLLocationManager alloc]init];
    [location requestWhenInUseAuthorization];
    
    CGRect mapRect = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height *0.4);
    self.map = [[MKMapView alloc]initWithFrame:mapRect];
    self.map.userTrackingMode = MKUserTrackingModeFollow;
    self.map.mapType = MKMapTypeStandard;
    self.map.showsTraffic = YES;
    self.map.delegate = self;
    self.map.showsUserLocation = YES;
    [self.view addSubview:self.map];
    
    
    addressArr = [[NSMutableArray alloc]init];
    
    addressTableView = [[UITableView alloc]init];
    addressTableView.frame = CGRectMake(0,CGRectGetMaxY(self.map.frame),self.view.frame.size.width,self.view.frame.size.height *0.4);
    addressTableView.delegate = self;
    addressTableView.dataSource = self;
    addressTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:addressTableView];

}
-(void)sendAction{
    NSLog(@"发送位置信息:%@",addressArr[selectCode]);
    NSString *str = addressArr[selectCode];
    UIGraphicsBeginImageContext(self.map.frame.size);
    [self.map.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (self.block) {
        self.block(viewImage,str,location2D);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)getLoactionMessage:(LocationBlock)myBlock{
    self.block = myBlock;
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    NSLog(@"%f--%f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude);
    location2D = userLocation.location;
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *array, NSError *error) {
        if (!error && array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
//            NSLog(@"%@ = %@",placemark.thoroughfare,placemark.subThoroughfare);
            userLocation.title = placemark.locality;
            userLocation.subtitle = placemark.name;
            NSString *str = [NSString stringWithFormat:@"%@%@%@%@",placemark.administrativeArea,placemark.locality,placemark.subLocality,placemark.name];
//            NSLog(@"address = %@",str);
            if (![addressArr containsObject:str]) {
                [addressArr addObject:str];
                [addressTableView reloadData];
            }
        }
        
    }];

}
-(void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    NSLog(@"定位失败!");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return addressArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"addressStr";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row < addressArr.count) {
        cell.textLabel.text = addressArr[indexPath.row];
        if (indexPath.row == selectCode) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row != selectCode) {
        selectCode = indexPath.row;
        [addressTableView reloadData];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.frame.size.height *0.08;
}
@end
