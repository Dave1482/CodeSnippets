#import "DAInfo.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize infoLabel;

NSString *deviceAndAppInfo()
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *devicesPlistPath = [[NSBundle mainBundle] pathForResource:@"devices" ofType:@"plist"];
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *iOSDevices = [NSDictionary dictionaryWithContentsOfFile:devicesPlistPath];
    NSString* deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString* deviceModelKey = [iOSDevices valueForKey:deviceModel];
    if (deviceModelKey == nil){
        deviceModelKey = deviceModel;
    }
    NSString* iOSVersion = [[UIDevice currentDevice] systemVersion];
    NSString *info = [NSString stringWithFormat:@"%@, iOS %@\n App v%@", deviceModelKey, iOSVersion, appVersion];
    
    return info;
}

- (void)viewDidLoad {
    infoLabel.text = deviceAndAppInfo();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
