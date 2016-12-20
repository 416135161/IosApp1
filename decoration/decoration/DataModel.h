//
//  DataModel.h
//  decoration
//
//  Created by 林 建军 on 08/12/2016.
//  Copyright © 2016 yl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Precompile.h"
#import "DaoDefines.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"
@interface DataModel : NSObject{


}

@property(nonatomic,strong) AFHTTPRequestOperationManager *manager;
-(void)add:(NSDictionary *) data success:(void (^)(id operation))success failure:(void (^)(NSError *error))failure;
@end
