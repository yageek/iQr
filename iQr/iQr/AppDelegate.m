//
//  AppDelegate.m
//  iQr
//
//  Created by HEINRICH Yannick on 18/02/13.
//  Copyright (c) 2013 HEINRICH Yannick. All rights reserved.
//

#import "AppDelegate.h"
#import "qrencode.h"
#import "YGQrcode.h"

@implementation AppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)generateClicked:(id)sender {
    
     NSLog(@"Click");
    NSString * value = self.textField.stringValue;
    if(value.length == 0 || [value isEqualToString:@""]) return;
    static YGQRcode * obj;
    if(obj) [obj release];
    obj = [[YGQRcode alloc] initWithString:value];
    
    NSImage * image = [[NSImage alloc] initWithCGImage:[obj image] size:NSZeroSize];
    self.imageView.image = image;
}
@end
