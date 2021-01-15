//
//  IMShowLocationController.m
//  DesignIM
//
//  Created by 朱运 on 2021/1/13.
//

#import "IMShowLocationController.h"

@interface IMShowLocationController ()<MKMapViewDelegate>{
    MKMapView *showMapView;
    
    CLLocationManager *location;

}
@end

@implementation IMShowLocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"location";
    location = [[CLLocationManager alloc]init];
    [location requestWhenInUseAuthorization];

    
    CGFloat height = self.view.bounds.size.height - 88 - 34;
    CGFloat width = self.view.bounds.size.width;
    CGRect rect = CGRectMake(0, 0, width, height);
    showMapView = [[MKMapView alloc]init];
    showMapView.frame = rect;
    showMapView.userTrackingMode = MKUserTrackingModeFollow;
    showMapView.mapType = MKMapTypeStandard;
    showMapView.showsTraffic = NO;
    showMapView.delegate = self;
    showMapView.showsUserLocation = YES;
    [self.view addSubview:showMapView];

    CLLocationCoordinate2D coordinate = self.showLocation.coordinate;
    MKCoordinateSpan span;//设置精度
    span.latitudeDelta = 0.05;
    span.longitudeDelta = 0.05;
    MKCoordinateRegion region = {coordinate,span};
    [showMapView setRegion:region animated:YES];
    
    
    UILabel *addressLabel = [[UILabel alloc]init];
    addressLabel.frame = CGRectMake(20, 20, width - 40, height *0.08);
    addressLabel.text = self.addressStr;
    addressLabel.textAlignment = NSTextAlignmentCenter;
    addressLabel.adjustsFontSizeToFitWidth = YES;
    addressLabel.font = [UIFont systemFontOfSize:15];
    addressLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    [self.view addSubview:addressLabel];
}
@end
