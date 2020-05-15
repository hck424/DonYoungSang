//
//  DataBaseManager.m
//  DonYoungSang
//
//  Created by 김학철 on 2020/05/13.
//  Copyright © 2020 김학철. All rights reserved.
//

#import "DataBaseManager.h"
#import <FirebaseStorage.h>
#import <FIRStorage.h>


@interface DataBaseManager ()
@property (nonatomic, strong) FIRStorage *storage;
@property (nonatomic, strong) NSMutableArray *arrData;

@end

@implementation DataBaseManager
+ (DataBaseManager *)instance {
    static DataBaseManager *instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instace = [[DataBaseManager alloc] init];
        instace.storage = [FIRStorage storageWithURL:@"gs://study10-3587c.appspot.com"];
    });
    return instace;
}

- (void)requestAllListCompletion:(void (^)(NSArray *result, NSError *error))completion {
    
    FIRStorageReference *ref = [_storage referenceWithPath:@"video"];
    [ref listAllWithCompletion:^(FIRStorageListResult * _Nonnull result, NSError * _Nullable error) {
        NSMutableArray *arr = [NSMutableArray array];
        NSInteger count = result.prefixes.count;
        for (NSInteger i = 0; i < count; i++) {
            FIRStorageReference *rf = [result.prefixes objectAtIndex:i];
            
            [self getAllItems:rf completion:^(NSMutableDictionary *item) {
                [arr addObject:item];
                if (arr.count == count) {
                    if (completion) {
                        completion(arr, nil);
                    }
                }
            }];
        }
    }];
}

- (void)getAllItems:(FIRStorageReference *)ref completion:(void (^)(NSMutableDictionary *item))completion {
    __block NSMutableDictionary *itemDic = [NSMutableDictionary dictionary];
    [itemDic setObject:ref.name forKey:@"fileName"]; //filename 
    [ref listAllWithCompletion:^(FIRStorageListResult * _Nonnull result, NSError * _Nullable error) {
        for (NSInteger i = 0; i < result.items.count; i++) {
            FIRStorageReference *subRf = [result.items objectAtIndex:i];
            [subRf downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
                [itemDic setObject:URL forKey:subRf.name];
                
                if (itemDic.count == 4) {
                    if (completion) {
                        completion(itemDic);
                    }
                }
            }];
        }
    }];

}
@end
