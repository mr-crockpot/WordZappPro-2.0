//
//  UserDefaults.m
//  WordZappPro 2.0
//
//  Created by Adam Schor on 8/12/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults

+(void)saveData:(NSObject *)data forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+(id)getDataForKey:(NSString *)key {
    
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}

@end
