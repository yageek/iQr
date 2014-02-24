//
//  YGBasicData.c
//  iQr
//
//  Created by HEINRICH Yannick on 21/02/13.
//  Copyright (c) 2013 HEINRICH Yannick. All rights reserved.
//
#include <stdlib.h>
#include "YGBasicData.h"

YGQRcodeGraphicBuffer * YGCreateGraphicBuffer() {
    
    YGQRcodeGraphicBuffer *buffer = malloc(sizeof(YGQRcodeGraphicBuffer));
    
    buffer->imageRef = NULL;
    buffer->bitmapData = NULL;
    
    return buffer;
}

void YGReleaseGraphicBuffer(YGQRcodeGraphicBuffer * buff){
    CGImageRelease(buff->imageRef);
    free(buff->bitmapData);
    buff->bitmapData = NULL;
    free(buff);
}

CGContextRef CreateBitmapContextWithBuffer (int side, YGQRcodeGraphicBuffer *graphicBuffer){
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    bitmapBytesPerRow   = (side);
    bitmapByteCount     = (bitmapBytesPerRow * side);
    
    colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericGray);
    graphicBuffer->bitmapData = malloc ( bitmapByteCount );
    if (graphicBuffer->bitmapData == NULL)
    {
        fprintf (stderr, "Memory not allocated!");
        return NULL;
    }
    context = CGBitmapContextCreate (graphicBuffer->bitmapData,
                                     side,
                                     side,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaNone);
    
    
    if (context==NULL)
    {
        free(graphicBuffer->bitmapData);
        fprintf (stderr, "Context not created!");
        return NULL;
    }
    CGColorSpaceRelease( colorSpace );
    
    return context;
    
}