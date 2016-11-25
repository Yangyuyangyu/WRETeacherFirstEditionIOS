//
//  AppDelegate.h
//  WeiRaoJiaoYu
//
//  Created by waycubeOXA on 16/4/27.
//  Copyright © 2016年 waycubeOXA. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKMapViewDelegate>
{
    
        BMKMapManager * _mapManager;
    

}

@property (strong, nonatomic) UIWindow *window;

//@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//- (void)saveContext;
//- (NSURL *)applicationDocumentsDirectory;


@end

