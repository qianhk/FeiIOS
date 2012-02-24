#line 1 "/OnGit/FeiIOS/BlurredNotificationCenter/BlurredNotificationCenter/BlurredNotificationCenter.xm"

#import <QuartzCore/QuartzCore.h>
#import <SpringBoard/SpringBoard.h>
#import <IOSurface/IOSurface.h>

@interface UIImage (IOSurface)
- (id)_initWithIOSurface:(IOSurfaceRef)surface scale:(CGFloat)scale orientation:(UIImageOrientation)orientation;
@end










#include <objc/message.h>
@class SBBulletinListView; 
static Class _logos_superclass$_ungrouped$SBBulletinListView; static Class _logos_supermetaclass$_ungrouped$SBBulletinListView; static UIImage * (*_logos_meta_orig$_ungrouped$SBBulletinListView$linen)(Class, SEL);static id (*_logos_orig$_ungrouped$SBBulletinListView$initWithFrame$delegate$)(SBBulletinListView*, SEL, CGRect, id);static void (*_logos_orig$_ungrouped$SBBulletinListView$dealloc)(SBBulletinListView*, SEL);static void (*_logos_orig$_ungrouped$SBBulletinListView$positionSlidingViewAtY$)(SBBulletinListView*, SEL, CGFloat);

#line 19 "/OnGit/FeiIOS/BlurredNotificationCenter/BlurredNotificationCenter/BlurredNotificationCenter.xm"


static UIView *activeView;


static UIImage * _logos_meta_super$_ungrouped$SBBulletinListView$linen(Class self, SEL _cmd) {return ((UIImage * (*)(Class, SEL))class_getMethodImplementation(_logos_supermetaclass$_ungrouped$SBBulletinListView, @selector(linen)))(self, _cmd);}static UIImage * _logos_meta_method$_ungrouped$SBBulletinListView$linen(Class self, SEL _cmd) {
	return nil;
}


static id _logos_super$_ungrouped$SBBulletinListView$initWithFrame$delegate$(SBBulletinListView* self, SEL _cmd, CGRect frame, id delegate) {return ((id (*)(SBBulletinListView*, SEL, CGRect, id))class_getMethodImplementation(_logos_superclass$_ungrouped$SBBulletinListView, @selector(initWithFrame:delegate:)))(self, _cmd, frame, delegate);}static id _logos_method$_ungrouped$SBBulletinListView$initWithFrame$delegate$(SBBulletinListView* self, SEL _cmd, CGRect frame, id delegate) {
	if ((self = _logos_orig$_ungrouped$SBBulletinListView$initWithFrame$delegate$(self, _cmd, frame, delegate))) {
		IOSurfaceRef surface = [UIWindow createScreenIOSurface];
		UIImageOrientation imageOrientation;
		switch ([(SpringBoard *)UIApp activeInterfaceOrientation]) {
			case UIInterfaceOrientationPortrait:
			default:
				imageOrientation = UIImageOrientationUp;
				break;
			case UIInterfaceOrientationPortraitUpsideDown:
				imageOrientation = UIImageOrientationDown;
				break;
			case UIInterfaceOrientationLandscapeLeft:
				imageOrientation = UIImageOrientationRight;
				break;
			case UIInterfaceOrientationLandscapeRight:
				imageOrientation = UIImageOrientationLeft;
				break;
		}
		UIImage *image = [[UIImage alloc] _initWithIOSurface:surface scale:[UIScreen mainScreen].scale orientation:imageOrientation];
		CFRelease(surface);
		if (!activeView)
			activeView = [[UIImageView alloc] initWithImage:image];
		static NSArray *filters;
		if (!filters) {
			CAFilter *filter = [CAFilter filterWithType:@"gaussianBlur"];
			[filter setValue:[NSNumber numberWithFloat:5.0f] forKey:@"inputRadius"];
			filters = [[NSArray alloc] initWithObjects:filter, nil];
		}
		CALayer *layer = activeView.layer;
		layer.filters = filters;
		layer.shouldRasterize = YES;
		activeView.alpha = 0.0f;
		[self insertSubview:activeView atIndex:0];
		[self linenView].backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
	}
	return self;
}



static void _logos_super$_ungrouped$SBBulletinListView$dealloc(SBBulletinListView* self, SEL _cmd) {return ((void (*)(SBBulletinListView*, SEL))class_getMethodImplementation(_logos_superclass$_ungrouped$SBBulletinListView, @selector(dealloc)))(self, _cmd);}static void _logos_method$_ungrouped$SBBulletinListView$dealloc(SBBulletinListView* self, SEL _cmd) {
	[activeView release];
	activeView = nil;
	_logos_orig$_ungrouped$SBBulletinListView$dealloc(self, _cmd);
}


static void _logos_super$_ungrouped$SBBulletinListView$positionSlidingViewAtY$(SBBulletinListView* self, SEL _cmd, CGFloat y) {return ((void (*)(SBBulletinListView*, SEL, CGFloat))class_getMethodImplementation(_logos_superclass$_ungrouped$SBBulletinListView, @selector(positionSlidingViewAtY:)))(self, _cmd, y);}static void _logos_method$_ungrouped$SBBulletinListView$positionSlidingViewAtY$(SBBulletinListView* self, SEL _cmd, CGFloat y) {
	CGFloat height = self.bounds.size.height;
	activeView.alpha = height ? (y / height) : 1.0f;
	_logos_orig$_ungrouped$SBBulletinListView$positionSlidingViewAtY$(self, _cmd, y);
}


static __attribute__((constructor)) void _logosLocalInit() {
#ifdef __clang__
#if __has_feature(objc_arc)
@autoreleasepool {
#else
NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
#endif
#else
NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
#endif
{Class _logos_class$_ungrouped$SBBulletinListView = objc_getClass("SBBulletinListView"); Class _logos_metaclass$_ungrouped$SBBulletinListView = object_getClass(_logos_class$_ungrouped$SBBulletinListView); _logos_superclass$_ungrouped$SBBulletinListView = class_getSuperclass(_logos_class$_ungrouped$SBBulletinListView); _logos_supermetaclass$_ungrouped$SBBulletinListView = class_getSuperclass(_logos_metaclass$_ungrouped$SBBulletinListView); { Class _class = _logos_metaclass$_ungrouped$SBBulletinListView;Method _method = class_getInstanceMethod(_class, @selector(linen));if (_method) {_logos_meta_orig$_ungrouped$SBBulletinListView$linen = _logos_meta_super$_ungrouped$SBBulletinListView$linen;if (!class_addMethod(_class, @selector(linen), (IMP)&_logos_meta_method$_ungrouped$SBBulletinListView$linen, method_getTypeEncoding(_method))) {_logos_meta_orig$_ungrouped$SBBulletinListView$linen = (UIImage * (*)(Class, SEL))method_getImplementation(_method);_logos_meta_orig$_ungrouped$SBBulletinListView$linen = (UIImage * (*)(Class, SEL))method_setImplementation(_method, (IMP)&_logos_meta_method$_ungrouped$SBBulletinListView$linen);}}}{ Class _class = _logos_class$_ungrouped$SBBulletinListView;Method _method = class_getInstanceMethod(_class, @selector(initWithFrame:delegate:));if (_method) {_logos_orig$_ungrouped$SBBulletinListView$initWithFrame$delegate$ = _logos_super$_ungrouped$SBBulletinListView$initWithFrame$delegate$;if (!class_addMethod(_class, @selector(initWithFrame:delegate:), (IMP)&_logos_method$_ungrouped$SBBulletinListView$initWithFrame$delegate$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$SBBulletinListView$initWithFrame$delegate$ = (id (*)(SBBulletinListView*, SEL, CGRect, id))method_getImplementation(_method);_logos_orig$_ungrouped$SBBulletinListView$initWithFrame$delegate$ = (id (*)(SBBulletinListView*, SEL, CGRect, id))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$SBBulletinListView$initWithFrame$delegate$);}}}{ Class _class = _logos_class$_ungrouped$SBBulletinListView;Method _method = class_getInstanceMethod(_class, @selector(dealloc));if (_method) {_logos_orig$_ungrouped$SBBulletinListView$dealloc = _logos_super$_ungrouped$SBBulletinListView$dealloc;if (!class_addMethod(_class, @selector(dealloc), (IMP)&_logos_method$_ungrouped$SBBulletinListView$dealloc, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$SBBulletinListView$dealloc = (void (*)(SBBulletinListView*, SEL))method_getImplementation(_method);_logos_orig$_ungrouped$SBBulletinListView$dealloc = (void (*)(SBBulletinListView*, SEL))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$SBBulletinListView$dealloc);}}}{ Class _class = _logos_class$_ungrouped$SBBulletinListView;Method _method = class_getInstanceMethod(_class, @selector(positionSlidingViewAtY:));if (_method) {_logos_orig$_ungrouped$SBBulletinListView$positionSlidingViewAtY$ = _logos_super$_ungrouped$SBBulletinListView$positionSlidingViewAtY$;if (!class_addMethod(_class, @selector(positionSlidingViewAtY:), (IMP)&_logos_method$_ungrouped$SBBulletinListView$positionSlidingViewAtY$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$SBBulletinListView$positionSlidingViewAtY$ = (void (*)(SBBulletinListView*, SEL, CGFloat))method_getImplementation(_method);_logos_orig$_ungrouped$SBBulletinListView$positionSlidingViewAtY$ = (void (*)(SBBulletinListView*, SEL, CGFloat))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$SBBulletinListView$positionSlidingViewAtY$);}}}}  
#ifdef __clang__
#if __has_feature(objc_arc)
}
#else
[pool drain];
#endif
#else
[pool drain];
#endif
}
#line 84 "/OnGit/FeiIOS/BlurredNotificationCenter/BlurredNotificationCenter/BlurredNotificationCenter.xm"
