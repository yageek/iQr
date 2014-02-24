//
//  OBJCQRCode.h
//  iQr
//
//  Created by HEINRICH Yannick on 18/02/13.
//  Copyright (c) 2013 HEINRICH Yannick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGBasicData.h"

@interface YGQRcode : NSObject

@property (readwrite) UInt32 dotSize;

- (id) initWithString:(NSString *) value;
- (CGImageRef) image;
@end
