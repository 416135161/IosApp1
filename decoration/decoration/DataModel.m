//
//  DataModel.m
//  decoration
//
//  Created by 林 建军 on 08/12/2016.
//  Copyright © 2016 yl. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

-(instancetype)init{
    self = [super init];
    
    if (self) {
         _manager = [AFHTTPRequestOperationManager manager];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;

}


-(void)add:(NSDictionary *) data success:(void (^)(id operation))success failure:(void (^)(NSError *error))failure{
    
    [self postUrl:@"app/comment/add.do" data:data success:^(id responseObject) {
        BLOCK_SAFE(success)(responseObject);
    } failure:^(NSError *error) {
        BLOCK_SAFE(failure)(error);
    }];


}

-(void)postUrl:(NSString *) url data:(NSDictionary *) data success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    
   NSString *newurl =  [NSString stringWithFormat:@"%@/%@",SERVER,url];
    
    
    AFHTTPSessionManager  *_sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    _sessionManager.requestSerializer.timeoutInterval = 10;
    
    _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [_sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
   
   
  [_sessionManager POST: newurl parameters:data success:^(NSURLSessionDataTask *task, id responseObject) {
       BLOCK_SAFE(success)(responseObject);
      
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
       BLOCK_SAFE(failure)(error);
  }];
    
//    [_manager POST: newurl parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        BLOCK_SAFE(success)(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        
//        BLOCK_SAFE(failure)(error);
//    }];
}

@end
