//
//  AppDelegate.h
//  HPPSixGoodLuck
//
//  Created by 黄晓展 on 2019/4/21.
//  Copyright © 2019 HPP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

