//
//  UPDao+City.h
//  wesnail
//
//  Created by 林 建军 on 4/29/16.
//  Copyright © 2016 林建军. All rights reserved.
//

#import "UPDao.h"
#import "City.h"
@interface UPDao (City)
//创建城市
- (void)createCity:(City *)city;

//删除城市
- (void)deleteAllCity;

//获取
- (NSMutableArray *)getCitys:(NSString *)cityName;
@end
