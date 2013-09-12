#import "XXViewController.h"

#import <sys/utsname.h>

@interface XXViewController ()

@end

@implementation XXViewController

- (NSDictionary *) allSystemInfo {

    NSProcessInfo *processInfo = [NSProcessInfo processInfo];

    NSArray *keys = @[ @"environment", @"arguments", @"hostName",
                        @"processName", @"processIdentifier",
                        @"globallyUniqueString",
                        @"operatingSystem", @"operatingSystemName",
                        @"operatingSystemVersionString", @"processorCount",
                        @"activeProcessorCount", @"physicalMemory",
                        @"systemUptime" ];

    NSMutableDictionary *info = [[processInfo dictionaryWithValuesForKeys: keys] mutableCopy];

    struct utsname unamen;
    int success = uname (&unamen);
    if (success == 0) {
        info[@"uname-sysname"] = @( unamen.sysname );
        info[@"uname-nodename"] = @( unamen.nodename );
        info[@"uname-release"] = @( unamen.release );
        info[@"uname-version"] = @( unamen.version );
        info[@"uname-machine"] = @( unamen.machine );
    }

    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    
    info[@"name"] = infoDict[(__bridge id)kCFBundleNameKey];
    info[@"short-app-version"] = infoDict[@"CFBundleShortVersionString"];
    info[@"app-version"] = infoDict[(__bridge id)kCFBundleVersionKey];
    info[@"built"] = @( __DATE__ " " __TIME__ );

    NSArray *deviceScreens = [UIScreen screens];
    NSMutableArray *screens = [NSMutableArray array];

    for (UIScreen *screen in deviceScreens) {
        CGRect bounds = screen.bounds;
        NSString *sizeString =
            [NSString stringWithFormat: @"%d,%d",
                      (int)bounds.size.width, (int)bounds.size.height];
        [screens addObject: sizeString];
    }

    NSString *screenString = [screens componentsJoinedByString:@","];
    info[@"screens"] = screenString;

    return info;

} // allSystemInfo


- (NSDictionary *) someSystemInfo {

    NSProcessInfo *processInfo = [NSProcessInfo processInfo];

    NSArray *keys = @[ @"operatingSystemVersionString" ];

    NSMutableDictionary *info = [[processInfo dictionaryWithValuesForKeys: keys] mutableCopy];

    struct utsname unamen;
    int success = uname (&unamen);
    if (success == 0) {
        info[@"os-version"] = @( unamen.version );
        info[@"hardware"] = @( unamen.machine );
    }

    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    
    info[@"name"] = infoDict[(__bridge id)kCFBundleNameKey];
    // info[@"short-app-version"] = infoDict[@"CFBundleShortVersionString"];
    info[@"app-version"] = infoDict[(__bridge id)kCFBundleVersionKey];
    info[@"built"] = @( __DATE__ " " __TIME__ );

    NSArray *deviceScreens = [UIScreen screens];
    NSMutableArray *screens = [NSMutableArray array];

    for (UIScreen *screen in deviceScreens) {
        CGRect bounds = screen.bounds;
        NSString *sizeString = // NSStringFromCGSize(bounds.size);
            [NSString stringWithFormat: @"%d,%d",
                      (int)bounds.size.width, (int)bounds.size.height];
        [screens addObject: sizeString];
    }

    info[@"screens"] = screens;

    return info;

} // someSystemInfo


- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *info = [self allSystemInfo];
    NSLog (@"%@", info);

    NSDictionary *lessInfo = [self someSystemInfo];
    NSLog (@"%@", lessInfo);
}

@end



#if 0

Mac in simulator
2013-08-30 17:20:40.048 SystemInfo[81546:11303] {
    activeProcessorCount = 4;
    arguments =     (
        "/Users/markd/Library/Application Support/iPhone Simulator/6.1/Applications/33FBEC52-BB14-4511-A79C-F73B30C37059/SystemInfo.app/SystemInfo"
        );
    hostName = "pheasantbook.local";
    operatingSystem = 5;
    operatingSystemName = NSMACHOperatingSystem;
    operatingSystemVersionString = "Version 10.7.5 (Build 11G63)";
    physicalMemory = 8589934592;
    processIdentifier = 81546;
    processName = SystemInfo;
    processorCount = 4;
    systemUptime = "214197.68491298";
    "uname-machine" = "x86_64";
    "uname-nodename" = "pheasantbook.local";
    "uname-release" = "11.4.2";
    "uname-sysname" = Darwin;
    "uname-version" = "Darwin Kernel Version 11.4.2: Thu Aug 23 16:25:48 PDT 2012; root:xnu-1699.32.7~1/RELEASE_X86_64";
}

iOS5 on an iphone 4:
2013-08-30 17:19:52.305 SystemInfo[6760:707] {
    activeProcessorCount = 1;
    arguments =     (
        "/var/mobile/Applications/F07DEDFE-5321-4D0B-A748-DBA1FD843FC8/SystemInfo.app/SystemInfo"
        );
    hostName = pheasantphone;
    operatingSystem = 5;
    operatingSystemName = NSMACHOperatingSystem;
    operatingSystemVersionString = "Version 5.1.1 (Build 9B206)";
    physicalMemory = 529481728;
    processIdentifier = 6760;
    processName = SystemInfo;
    processorCount = 1;
    systemUptime = "702380.76052475";
    "uname-machine" = "iPhone3,3";
    "uname-nodename" = Pheasantphone;
    "uname-release" = "11.0.0";
    "uname-sysname" = Darwin;
    "uname-version" = "Darwin Kernel Version 11.0.0: Sun Apr  8 21:51:26 PDT 2012; root:xnu-1878.11.10~1/RELEASE_ARM_S5L8930X";
}


iOS7 on an ipad mini
2013-08-30 17:21:21.258 SystemInfo[600:60b] {
    activeProcessorCount = 2;
    arguments =     (
    "/var/mobile/Applications/59958C02-0996-436B-A41F-86781A3E5E80/SystemInfo.app/SystemInfo"
            );
    hostName = cocoaheads;
    operatingSystem = 5;
    operatingSystemName = NSMACHOperatingSystem;
    operatingSystemVersionString = "Version 7.0 (Build 11A4449d)";
    physicalMemory = 527417344;
    processIdentifier = 600;
    processName = SystemInfo;
    processorCount = 2;
    systemUptime = "8783.964261541667";
    "uname-machine" = "iPad2,7";
    "uname-nodename" = cocoaheads;
    "uname-release" = "14.0.0";
    "uname-sysname" = Darwin;
    "uname-version" = "Darwin Kernel Version 14.0.0: Sun Aug  4 22:33:00 PDT 2013; root:xnu-2423.1.70~6/RELEASE_ARM_S5L8942X";
}

#endif
