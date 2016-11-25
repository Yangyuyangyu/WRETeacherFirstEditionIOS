//
//  AppDelegate.m
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/4/27.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import "AppDelegate.h"
#import "BPush.h"
//#import "SkipViewController.h"
#import "TableBarViewController.h"
#import "ViewController.h"
#import "AFNetworking.h"
static BOOL isBackGroundActivateApplication;
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface AppDelegate ()<BMKGeneralDelegate>
//@property (nonatomic,strong) ViewController *viewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@",ShareS.uid);
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    NSUserDefaults *defailts = [NSUserDefaults standardUserDefaults];
    ShareS.uid = [defailts objectForKey:@"uId"];
    if (![defailts objectForKey:@"uId"]){
        UIStoryboard * mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController * main = [mainSB instantiateViewControllerWithIdentifier:@"ViewController"];
        UINavigationController *av=[[UINavigationController alloc]initWithRootViewController:main];
        self.window.rootViewController=av;
    }
    else
    {
        TableBarViewController *rootVC = [[TableBarViewController alloc]init];
        self.window.rootViewController = rootVC;
        
    }
    //制定window的根视图控制器
    
    
    
    
    
    // Override point for customization after application launch.
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"f8eBC4Dsu9ErDD884xrcC49D6Bu7Igrw"  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager star failed!");
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
        //由于IOS8中定位的授权机制改变 需要进行手动授权
        CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
        //获取授权认证
//        [locationManager requestAlwaysAuthorization];
        [locationManager requestWhenInUseAuthorization];
    }
    
    
    
    // iOS8 下需要使用新的 API
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    
#warning 测试 开发环境 时需要修改BPushMode为BPushModeDevelopment 需要修改Apikey为自己的Apikey
    
    // 在 App 启动时注册百度云推送服务，需要提供 Apikey
    
    [BPush registerChannel:launchOptions apiKey:@"krIbFjlMjhTzO5hSmRKbxsuR" pushMode:BPushModeDevelopment withFirstAction:@"打开" withSecondAction:@"回复" withCategory:@"test" useBehaviorTextInput:YES isDebug:YES];
    
    // 禁用地理位置推送 需要再绑定接口前调用。
    
    [BPush disableLbs];
    
    // App 是用户点击推送消息启动
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        [BPush handleNotification:userInfo];
    }
#if TARGET_IPHONE_SIMULATOR
    Byte dt[32] = {0xc6, 0x1e, 0x5a, 0x13, 0x2d, 0x04, 0x83, 0x82, 0x12, 0x4c, 0x26, 0xcd, 0x0c, 0x16, 0xf6, 0x7c, 0x74, 0x78, 0xb3, 0x5f, 0x6b, 0x37, 0x0a, 0x42, 0x4f, 0xe7, 0x97, 0xdc, 0x9f, 0x3a, 0x54, 0x10};
    [self application:application didRegisterForRemoteNotificationsWithDeviceToken:[NSData dataWithBytes:dt length:32]];
#endif
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    /*
     // 测试本地通知
     [self performSelector:@selector(testLocalNotifi) withObject:nil afterDelay:1.0];
     */
    
    
    return YES;
}
//- (void)testLocalNotifi
//{
//    NSLog(@"测试本地通知啦！！！");
//    NSDate *fireDate = [[NSDate new] dateByAddingTimeInterval:5];
//    [BPush localNotification:fireDate alertBody:@"这是本地通知" badge:3 withFirstAction:@"打开" withSecondAction:@"关闭" userInfo:nil soundName:nil region:nil regionTriggersOnce:YES category:nil useBehaviorTextInput:YES];
//}




// 此方法是 用户点击了通知，应用在前台 或者开启后台并且应用在后台 时调起
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    completionHandler(UIBackgroundFetchResultNewData);
    // 打印到日志 textView 中
    NSLog(@"********** iOS7.0之后 background **********");
    // 应用在前台，不跳转页面，让用户选择。
    if (application.applicationState == UIApplicationStateActive) {
        NSLog(@"acitve ");
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    //杀死状态下，直接跳转到跳转页面。
    if (application.applicationState == UIApplicationStateInactive && !isBackGroundActivateApplication)
    {
        NSLog(@"applacation is unactive ===== %@",userInfo);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didReceiveRemoteNotification" object:nil];
    }
    // 应用在后台。当后台设置aps字段里的 content-available 值为 1 并开启远程通知激活应用的选项
    if (application.applicationState == UIApplicationStateBackground) {
        NSLog(@"background is Activated Application ");
        // 此处可以选择激活应用提前下载邮件图片等内容。
        isBackGroundActivateApplication = YES;
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    //[self.viewController addLogString:[NSString stringWithFormat:@"Received Remote Notification :\n%@",userInfo]];
    
    NSLog(@"%@",userInfo);
}

// 在 iOS8 系统中，还需要添加这个方法。通过新的 API 注册推送服务
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    
    [application registerForRemoteNotifications];
    
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSString *deviceToken1 = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    存储手机唯一标识
    NSUserDefaults *defailts = [NSUserDefaults standardUserDefaults];
    [defailts setObject:deviceToken1 forKey:@"unique_code"];
    
    //    NSLog(@"test:%@",deviceToken);
    //    NSString *deviceToken1 = [BPush getChannelId];
    //    NSLog(@"%@",deviceToken1);
    //
    //    NSUserDefaults *defailts = [NSUserDefaults standardUserDefaults];
    //
    //    [defailts setObject:deviceToken forKey:@"deviceToken"];
    //    if (deviceToken1.length == 0) {
    //        [defailts setObject:@"" forKey:@"deviceToken1"];
    //    }else{
    //        [defailts setObject:deviceToken1 forKey:@"deviceToken1"];
    //    }
    //
    //
    //    if ([defailts objectForKey:@"uId"]) {
    //        [BPush registerDeviceToken:deviceToken];
    //        NSString *urlstr=@"http://www.weiraoedu.com/Api/TeacherApi/createTag";
    ////        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:ShareS.uid,@"id",deviceToken1,@"channelId", nil];
    //        NSLog(@"%@",ShareS.uid);
    //        NSDictionary *dic = @{@"id":[defailts objectForKey:@"uId"],@"channelId":deviceToken1};
    //        NSLog(@"%@",dic);
    //        AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
    //        [manger POST:urlstr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //
    //            [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
    //                // 需要在绑定成功后进行 settag listtag deletetag unbind 操作否则会失败
    //
    //                // 网络错误
    //                if (error) {
    //                    return ;
    //                }
    //                if (result) {
    //                    // 确认绑定成功
    //                    if ([result[@"error_code"]intValue]!=0)
    //                    {
    //                        return;
    //                    }
    //                    // 获取channel_id
    //                    NSString *myChannel_id = [BPush getChannelId];
    //                    NSLog(@"==%@",myChannel_id);
    //                    //获取当前设备应用的tag列表
    //                    [BPush listTagsWithCompleteHandler:^(id result, NSError *error) {
    //                        if (result) {
    //                            NSLog(@"result ============== %@",result);
    //                        }
    //                    }];
    //                    [BPush setTag:deviceToken1 withCompleteHandler:^(id result, NSError *error) {
    //                        if (result) {
    //                            NSLog(@"设置tag成功");
    //                        }
    //                    }];
    //                }
    //            }];
    //
    //
    //
    //        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //
    //        }];
    //    }
    
    // 打印到日志 textView 中
    //[self.viewController addLogString:[NSString stringWithFormat:@"Register use deviceToken : %@",deviceToken]];
    
    
}

// 当 DeviceToken 获取失败时，系统会回调此方法
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"DeviceToken 获取失败，原因：%@",error);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // App 收到推送的通知
    [BPush handleNotification:userInfo];
    NSLog(@"********** ios7.0之前 **********");
    // 应用在前台 或者后台开启状态下，不跳转页面，让用户选择。
    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
        NSLog(@"acitve or background");
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    else//杀死状态下，直接跳转到跳转页面。
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didReceiveRemoteNotification" object:nil];    }
    
    // [self.viewController addLogString:[NSString stringWithFormat:@"Received Remote Notification :\n%@",userInfo]];
    
    NSLog(@"%@",userInfo);
}

//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
//{
//    NSLog(@"接收本地通知啦！！！");
//    [BPush showLocalNotificationAtFront:notification identifierKey:nil];
//}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didReceiveRemoteNotification" object:nil];
    }
}

- (void)onGetNetworkState:(int)iError
{
    if (iError == 0) {
        NSLog(@"网络连接成功");
    }else
    {
        NSLog(@"联网失败");
    }
}

/**
 *返回授权验证错误
 *@param iError 错误号 : 为0时验证通过，具体参加BMKPermissionCheckResultCode
 */
- (void)onGetPermissionState:(int)iError
{
    if (iError == 0) {
        NSLog(@"百度地图授权成功");
    }else
    {
        NSLog(@"百度地图授权失败");
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    //    [self saveContext];
}

//#pragma mark - Core Data stack
//
//@synthesize managedObjectContext = _managedObjectContext;
//@synthesize managedObjectModel = _managedObjectModel;
//@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
//
//- (NSURL *)applicationDocumentsDirectory {
//    // The directory the application uses to store the Core Data store file. This code uses a directory named "waycube.WeiRaoJiaoYu" in the application's documents directory.
//    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
//}
//
//- (NSManagedObjectModel *)managedObjectModel {
//    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
//    if (_managedObjectModel != nil) {
//        return _managedObjectModel;
//    }
//    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"WeiRaoJiaoYu" withExtension:@"momd"];
//    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
//    return _managedObjectModel;
//}
//
//- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
//    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
//    if (_persistentStoreCoordinator != nil) {
//        return _persistentStoreCoordinator;
//    }
//
//    // Create the coordinator and store
//
//    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
//    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"WeiRaoJiaoYu.sqlite"];
//    NSError *error = nil;
//    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
//    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
//        // Report any error we got.
//        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
//        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
//        dict[NSUnderlyingErrorKey] = error;
//        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
//        // Replace this with code to handle the error appropriately.
//        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
//    }
//
//    return _persistentStoreCoordinator;
//}
//
//
//- (NSManagedObjectContext *)managedObjectContext {
//    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
//    if (_managedObjectContext != nil) {
//        return _managedObjectContext;
//    }
//
//    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
//    if (!coordinator) {
//        return nil;
//    }
//    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
//    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
//    return _managedObjectContext;
//}
//
//#pragma mark - Core Data Saving support
//
//- (void)saveContext {
//    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
//    if (managedObjectContext != nil) {
//        NSError *error = nil;
//        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
//            // Replace this implementation with code to handle the error appropriately.
//            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//            abort();
//        }
//    }
//}

@end
