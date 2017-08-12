//
//  RCTMethod.m
//  RNApp
//
//  Created by iqiyi on 17/8/5.
//  Copyright © 2017年 iqiyi. All rights reserved.
//

#import "TSMethod.h"
#import "XMLDocument.h"

@interface TSMethod ()

@property (nonatomic ,copy) NSMutableDictionary *successCallBack;

@property (nonatomic ,copy) NSMutableDictionary *failureCallBack;

@end

@implementation TSMethod

- (instancetype) init
{
    self = [super init]; 
    
    XMLNode *node = [[XMLNode alloc] initWithName:@"hello"];
    
    XMLDocument *doc = [[XMLDocument alloc] initWithRoot:node];
    
    NSLog(@"%@",doc.XMLDocumentString);
    
    return self;
}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(addEvent:(NSString *)name)
{
    NSLog(@"hello %@",name);
}

RCT_EXPORT_METHOD(schemaParams:(NSData *) schema success:(RCTResponseSenderBlock)success failure:(RCTResponseSenderBlock) failure)
{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:schema options:NSJSONReadingAllowFragments error:nil];
    NSString *action = [dict objectForKey:@"action"];
    NSDictionary *params = [dict objectForKey:@"params"];
    
    if (action && success) {
        self.successCallBack[action] = success;
    }
    
    if (action && failure) {
        self.failureCallBack[action] = success;
    }
    
    [self callBack:^{
        RCTResponseSenderBlock success = self.successCallBack[action];
        if (success) {
            NSString *jsonString = @"";
            
            NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"hello",@"react", nil];
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:&error];
            if (! jsonData) {
                NSLog(@"Got an error: %@", error);
            } else {
                jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            }
            success(@[jsonString]);
        }
    }];
    
}

- (void) callBack:(void (^)())call
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        sleep(5);
        if (call) {
            call();
        }
    });
}

- (NSMutableDictionary *) successCallBack
{
    if (!_successCallBack) {
        _successCallBack = [NSMutableDictionary dictionary];
    }
    
    return _successCallBack;
}

- (NSMutableDictionary *) failureCallBack
{
    if (!_failureCallBack) {
        _failureCallBack = [NSMutableDictionary dictionary];
    }
    
    return _failureCallBack;
}

@end
