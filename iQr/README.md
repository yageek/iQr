# Description

A simple class generated a QRCode CGImageRef from NSString and based on qrencode and Quartz2D.

# Usage

```objc
	YGQRcode * obj = [[YGQRcode alloc] initWithString:value];
    
	NSImage * image = [[NSImage alloc] initWithCGImage:[obj image] size:NSZeroSize];
```



