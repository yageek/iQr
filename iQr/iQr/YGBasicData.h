//
//  BasicData.h
//  iQr
//
//  Created by HEINRICH Yannick on 21/02/13.
//  Copyright (c) 2013 HEINRICH Yannick. All rights reserved.
//

#ifndef iQr_BasicData_h
#define iQr_BasicData_h
#import <QuartzCore/QuartzCore.h>
#include "qrencode.h"

enum DotColor{
    
    WHITE = 0,
    BLACK = 1
};

struct YGQRcodeGraphicBuffer {
    CGImageRef imageRef;
    void *bitmapData;
};

typedef enum DotColor DotColor;

typedef struct YGQRcodeGraphicBuffer YGQRcodeGraphicBuffer;

YGQRcodeGraphicBuffer * YGCreateGraphicBuffer();

void YGReleaseGraphicBuffer(YGQRcodeGraphicBuffer * buff);

CGContextRef CreateBitmapContextWithBuffer (int side, YGQRcodeGraphicBuffer *graphicBuffer);

#endif
