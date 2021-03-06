//
//  City.h
//  wesnail
//
//  Created by 林 建军 on 4/29/16.
//  Copyright © 2016 林建军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject
//城市ID
@property (nonatomic, retain) NSString * cityID;
//城市名称
@property (nonatomic, retain) NSString * cityName;

@property (nonatomic, retain) NSString * groupName;
//查询关键字short_name
@property (nonatomic, retain) NSString * name;         

@property (nonatomic, retain) NSString * shortName;
@end
