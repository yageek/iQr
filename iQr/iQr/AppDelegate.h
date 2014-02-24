//
//  AppDelegate.h
//  iQr
//
//  Created by HEINRICH Yannick on 18/02/13.
//  Copyright (c) 2013 HEINRICH Yannick. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSImageView *imageView;
@property (assign) IBOutlet NSTextField *textField;
@property (assign) IBOutlet NSButton *generateButton;
- (IBAction)generateClicked:(id)sender;

@end
