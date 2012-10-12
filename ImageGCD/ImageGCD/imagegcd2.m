#import <Cocoa/Cocoa.h>

#import <dispatch/dispatch.h>
#import <libkern/OSAtomic.h>
#import <sys/time.h>


struct timeval gStartTime;

void Start2(void)
{
    gettimeofday(&gStartTime, NULL);
}

void End2(void)
{
    struct timeval endtv;
    gettimeofday(&endtv, NULL);
    
    double start = gStartTime.tv_sec * 1000000 + gStartTime.tv_usec;
    double end = endtv.tv_sec * 1000000 + endtv.tv_usec;
    
    NSLog(@"Operation took %f seconds to complete", (end - start) / 1000000.0);
}

void WithAutoreleasePool2(dispatch_block_t block)
{
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    block();
    [pool release];
}

dispatch_block_t BlockWithAutoreleasePool2(dispatch_block_t block)
{
    return [[^{
        WithAutoreleasePool2(block);
    } copy] autorelease];
}

NSBitmapImageRep *Thumbnail2(NSImage *image, int thumbMaxDim)
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

NSData *ThumbnailDataForData2(NSData *data)
{
    NSImage *image = [[NSImage alloc] initWithData: data];
    if(!image)
        return nil;
    
    NSBitmapImageRep *thumbnailRep = Thumbnail2(image, 320);
    NSData *thumbnailData = [thumbnailRep representationUsingType: NSJPEGFileType properties: nil];
    [image release];
    return thumbnailData;
}

int main2(int argc, char **argv)
{
    NSAutoreleasePool *outerPool = [NSAutoreleasePool new];
    
    NSApplicationLoad();
    
    NSString *destination = @"/tmp/imagegcd";
    [[NSFileManager defaultManager] removeItemAtPath: destination error: NULL];
    [[NSFileManager defaultManager] createDirectoryAtPath: destination withIntermediateDirectories: YES attributes: nil error: NULL];
    
    
    Start2();
    
    NSString *dir = [@"~/Pictures" stringByExpandingTildeInPath];
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath: dir];
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_group_t group = dispatch_group_create();
    __block uint32_t count = -1;
    for(NSString *path in enumerator)
    {
        dispatch_group_async(group, globalQueue, BlockWithAutoreleasePool2(^{
            if([[[path pathExtension] lowercaseString] isEqual: @"jpg"])
            {
                NSString *fullPath = [dir stringByAppendingPathComponent: path];
                
                NSData *data = [NSData dataWithContentsOfFile: fullPath];
                if(data)
                {
                    NSData *thumbnailData = ThumbnailDataForData2(data);
                    if(thumbnailData)
                    {
                        NSString *thumbnailName = [NSString stringWithFormat: @"%d.jpg", OSAtomicIncrement32(&count)];
                        NSString *thumbnailPath = [destination stringByAppendingPathComponent: thumbnailName];
                        [thumbnailData writeToFile: thumbnailPath atomically: NO];
                    }
                }
            }
        }));
    }
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    End2();
    
    [outerPool release];
}

