//
//  UserDefaults.h
//  WordZappPro 2.0
//
//  Created by Adam Schor on 8/12/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject


+(void)saveData: (NSObject *) data forKey: (NSString *)key;
+(id)getDataForKey: (NSString *) key;


@end
