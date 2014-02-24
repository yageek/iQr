//
//  OBJCQRCode.m
//  iQr
//
//  Created by HEINRICH Yannick on 18/02/13.
//  Copyright (c) 2013 HEINRICH Yannick. All rights reserved.
//

#import "YGQRcode.h"

#define MODULE_COLOR(x) (x & 0x01) == 0x01 ? BLACK : WHITE
#define defaultDotSizeInPts 5

#pragma mark - YGQRcode implementation

@interface YGQRcode (){

    @private
    YGQRcodeGraphicBuffer * _buffer;
    QRcode * _baseCode;
}

- (void) drawImageInBuffer;
- (void) flushGraphicsBuffer;

- (id) initWithQRcode:(const QRcode *) code;
@end


@implementation YGQRcode

@synthesize dotSize = _dotSize;


#pragma mark - Deallocation

- (void) dealloc{
    
   
    free(_baseCode);
    YGReleaseGraphicBuffer(_buffer);
    
    _baseCode = NULL;
    _buffer = NULL;
    [super dealloc];
}

#pragma mark - Designated Initializers
- (id) initWithQRcode:(const QRcode *) code
{
    
    
    if(self = [super init]){
        
        if(!code){
            [self release];
        }
        else {
            _baseCode = malloc(sizeof(QRcode));
            memcpy(_baseCode, code, sizeof(QRcode));
            _dotSize = defaultDotSizeInPts;
            _buffer = YGCreateGraphicBuffer();
        }
    }
    return self;
}

#pragma mark - Others init methods
- (id) initWithString:(NSString *) value
{
    
    NSString * string = [value copy];

    QRcode * code = QRcode_encodeString8bit([string UTF8String], 0, QR_ECLEVEL_L);
    id obj = [self initWithQRcode:code];
    
    free(code);
    return obj;
    
}
#pragma mark - Drawing methods
- (void) drawImageInBuffer
{
    int width = _baseCode->width;
    CGContextRef drawContext = CreateBitmapContextWithBuffer(width*defaultDotSizeInPts,self->_buffer);
    CGAffineTransform flipVertical = CGAffineTransformMake(
                                                           1, 0, 0, -1, 0, width*defaultDotSizeInPts
                                                           );
    CGContextConcatCTM(drawContext, flipVertical);
    
    unsigned char * dotsMatrix =_baseCode->data;
    
    for(unsigned int count = 0 ; count < width*width;++count){
        
        unsigned char * dot = dotsMatrix + count;
        
        DotColor color = MODULE_COLOR(*dot);
        
        switch(color){
            case WHITE: CGContextSetGrayFillColor(drawContext, 1.0,1.0); break;
            case BLACK: CGContextSetGrayFillColor(drawContext, 0.0,1.0); break;
        }
        //Compute Coordinates
        unsigned int x,y;
        x = count%(width);
        y = count/(width);
        
        CGRect dotToDraw = CGRectMake(x*defaultDotSizeInPts, y*defaultDotSizeInPts, defaultDotSizeInPts, defaultDotSizeInPts);
        CGContextFillRect(drawContext,dotToDraw);
    }
    self->_buffer->imageRef = CGBitmapContextCreateImage(drawContext);
}


- (void) flushGraphicsBuffer{
    
    
    CGImageRelease(self->_buffer->imageRef);
    if(self->_buffer->bitmapData) free(self->_buffer->bitmapData);
}


- (CGImageRef) image
{
    
    if(self->_buffer->imageRef) return self->_buffer->imageRef;
    else {

        [self flushGraphicsBuffer];
       
        [self drawImageInBuffer];
    }
    return self->_buffer->imageRef;
   }

@end


#pragma mark - C Quartz2D


