//
//  DataBaseManager.h
//  DonYoungSang
//
//  Created by 김학철 on 2020/05/13.
//  Copyright © 2020 김학철. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataBaseManager : NSObject

+ (DataBaseManager *)instance;
- (void)requestAllListCompletion:(void (^)(NSArray *result, NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
