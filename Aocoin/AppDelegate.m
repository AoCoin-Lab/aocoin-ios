//
//  AppDelegate.m
//  Aocoin
//  Created by 邢现庆 on 2020/10/10.
//

#import "AppDelegate.h"
#import "ABTarbarController.h"
#import "ABRealmUtils.h"
#import "ABAocoinVC.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self.window makeKeyAndVisible];
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.schemaVersion = REALM_VERISON;
    config.migrationBlock = ^(RLMMigration * _Nonnull migration, uint64_t oldSchemaVersion) {

    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    //已经有钱包
    NSString* currentUserAddress = [ABUserDefault objectForKey:Current_user_adress];
    if (currentUserAddress) {
        [[ABRealmUtils shareUtils]walletsRealm:[ABUserDefault objectForKey:Current_Chain]];
        ABUserModel *userModel = [ABUserModel objectForPrimaryKey:currentUserAddress];
        if (!userModel) {
            userModel = [[ABUserModel allObjects]firstObject];
        }
        [[ABUserModel defaultUser] updateUserModelWithModel:userModel];
        ABTarbarController* tabbar = [[ABTarbarController alloc]init];
        self.window.rootViewController = tabbar;
    }else{
        ABAocoinVC* tronVC  = [[ABAocoinVC alloc]initWithNibName:@"ABAocoinVC" bundle:nil];
        RTRootNavigationController *tronNav = [[RTRootNavigationController alloc] initWithRootViewController:tronVC];
        self.window.rootViewController = tronNav;
    }
    return YES;
}


#pragma mark - UISceneSession lifecycle

//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
