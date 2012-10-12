#import <Cocoa/Cocoa.h>

#import <sys/time.h>


struct timeval gStartTime;

void Start1(void)
{
    gettimeofday(&gStartTime, NULL);
}

void End1(void)
{
    struct timeval endtv;
    gettimeofday(&endtv, NULL);
    
    double start = gStartTime.tv_sec * 1000000 + gStartTime.tv_usec;
    double end = endtv.tv_sec * 1000000 + endtv.tv_usec;
    
    NSLog(@"Operation took %f seconds to complete", (end - start) / 1000000.0);
}

NSBitmapImageRep *Thumbnail1(NSImage *image, int thumbMaxDim)
{
    NSSize imgSize = [image size];
    NSSize thumbSize;
    if(imgSize.width > imgSize.height)
    {
        thumbSize.width = thumbMaxDim;
        thumbSize.height = ceilf(thumbMaxDim * imgSize.height / imgSize.width);
    }
    else
    {
        thumbSize.height = thumbMaxDim;
        thumbSize.width = ceilf(thumbMaxDim * imgSize.width / imgSize.height);
    }
    
    NSBitmapImageRep *rep = [[NSBitmapImageRep alloc]
                              initWithBitmapDataPlanes: NULL
                              pixelsWide: thumbSize.width
                              pixelsHigh: thumbSize.height
                              bitsPerSample: 8
                              samplesPerPixel: 4
                              hasAlpha: YES
                              isPlanar: NO
                              colorSpaceName: NSCalibratedRGBColorSpace
                              bitmapFormat: 0
                              bytesPerRow: 0
                              bitsPerPixel: 0];
    NSRect srcRect = { NSZeroPoint, imgSize };
    NSRect dstRect = { NSZeroPoint, thumbSize };
    
    NSGraphicsContext *ctx = [NSGraphicsContext graphicsContextWithBitmapImageRep: rep];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext: ctx];
    
    [image drawInRect: dstRect fromRect: srcRect operation: NSCompositeCopy fraction: 1.0];
    
    [NSGraphicsContext restoreGraphicsState];
    
    return [rep autorelease];
}

NSData *ThumbnailDataForData1(NSData *data)
{
    NSImage *image = [[NSImage alloc] initWithData: data];
    if(!image)
        return nil;
    
    NSBitmapImageRep *thumbnailRep = Thumbnail1(image, 320);
    NSData *thumbnailData = [thumbnailRep representationUsingType: NSJPEGFileType properties: nil];
    [image release];
    return thumbnailData;
}

int main1(int argc, char **argv)
{
    NSAutoreleasePool *outerPool = [NSAutoreleasePool new];
    
    NSApplicationLoad();
    
    NSString *destination = @"/tmp/imagegcd";
    [[NSFileManager defaultManager] removeItemAtPath: destination error: NULL];
    [[NSFileManager defaultManager] createDirectoryAtPath: destination withIntermediateDirectories: YES attributes: nil error: NULL];
    
    
    Start1();
    
    NSString *dir = [@"~/Pictures" stringByExpandingTildeInPath];
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath: dir];
    int count = 0;
    for(NSString *path in enumerator)
    {
        NSAutoreleasePool *innerPool = [NSAutoreleasePool new];
        
        if([[[path pathExtension] lowercaseString] isEqual: @"jpg"])
        {
            path = [dir stringByAppendingPathComponent: path];
            
            NSData *data = [NSData dataWithContentsOfFile: path];
            if(data)
            {
                NSData *thumbnailData = ThumbnailDataForData1(data);
                if(thumbnailData)
                {
                    NSString *thumbnailName = [NSString stringWithFormat: @"%d.jpg", count++];
                    NSString *thumbnailPath = [destination stringByAppendingPathComponent: thumbnailName];
                    [thumbnailData writeToFile: thumbnailPath atomically: NO];
                }
            }
        }
        
        [innerPool release];
    }
    
    End1();
    
    [outerPool release];
}

