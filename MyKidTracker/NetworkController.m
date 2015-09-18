//
//  NetworkController.m
//  FamilyCheckIn
//
//  Created by James Carlson on 9/8/15.
//  Copyright (c) 2015 JC2DEV, LLC. All rights reserved.
//

#import "NetworkController.h"
#import <FBSDKAccessToken.h>


@implementation NetworkController


+ (AFHTTPSessionManager *)api {
    
    static AFHTTPSessionManager *api = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        api = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:URLStringKey]];
        api.responseSerializer = [AFJSONResponseSerializer serializer];
        api.requestSerializer = [AFJSONRequestSerializer serializer];
        
    });
    return api;
}

+ (AFHTTPRequestOperationManager *)manager {
    
    Token *token;
    static AFHTTPRequestOperationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager =[[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:URLStringKey]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:token.token forHTTPHeaderField:@"Authorization"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    });
    return manager;
}

- (NSString *)encodeImageToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodedData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodedData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

// put this into the code to add the token to the session [self.apiSession.requestSerializer setValue:account.currentAuthToken forHTTPHeaderField:@"X-Auth-Token”];`
@end
