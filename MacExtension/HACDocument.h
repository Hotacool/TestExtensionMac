//
//  HACDocument.h
//  TestExtensionMac
//
//  Created by macbook on 16/10/24.
//  Copyright © 2016年 Hotacool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HACParam : NSObject
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
- (instancetype)initWithType:(NSString*)type name:(NSString*)name ;
@end
@interface HACDocument : NSObject

+ (NSString*)createDocumentsWithFuncName:(NSString*)funcName_ returnParam:(NSString*)returnParam_ params:(NSMutableArray<HACParam*>*)params_ ;
@end
