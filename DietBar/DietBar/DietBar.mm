#line 1 "/OnGit/FeiIOS/DietBar/DietBar/DietBar.xm"


;

#include <objc/message.h>
@class UIToolbar; @class ABSubTabBar; @class PTHCustomTabBar; @class UINavigationBar; @class NavFooterView; 
static Class _logos_superclass$_ungrouped$UINavigationBar; static CGSize (*_logos_orig$_ungrouped$UINavigationBar$defaultSizeForOrientation$)(UINavigationBar*, SEL, UIInterfaceOrientation);static Class _logos_superclass$_ungrouped$UIToolbar; static CGSize (*_logos_orig$_ungrouped$UIToolbar$defaultSizeForOrientation$)(UIToolbar*, SEL, UIInterfaceOrientation);

#line 5 "/OnGit/FeiIOS/DietBar/DietBar/DietBar.xm"



static CGSize _logos_super$_ungrouped$UINavigationBar$defaultSizeForOrientation$(UINavigationBar* self, SEL _cmd, UIInterfaceOrientation orientation) {return ((CGSize (*)(UINavigationBar*, SEL, UIInterfaceOrientation))class_getMethodImplementation(_logos_superclass$_ungrouped$UINavigationBar, @selector(defaultSizeForOrientation:)))(self, _cmd, orientation);}static CGSize _logos_method$_ungrouped$UINavigationBar$defaultSizeForOrientation$(UINavigationBar* self, SEL _cmd, UIInterfaceOrientation orientation) {
	BOOL respondPromptView = [self respondsToSelector:@selector(promptView)];

	if ([self promptView])
		return _logos_orig$_ungrouped$UINavigationBar$defaultSizeForOrientation$(self, _cmd, orientation);
	CGSize size;
	size.width = _logos_orig$_ungrouped$UINavigationBar$defaultSizeForOrientation$(self, _cmd, orientation).width;
	size.height = 32.0f;
	return size;
}






static CGSize _logos_super$_ungrouped$UIToolbar$defaultSizeForOrientation$(UIToolbar* self, SEL _cmd, UIInterfaceOrientation orientation) {return ((CGSize (*)(UIToolbar*, SEL, UIInterfaceOrientation))class_getMethodImplementation(_logos_superclass$_ungrouped$UIToolbar, @selector(defaultSizeForOrientation:)))(self, _cmd, orientation);}static CGSize _logos_method$_ungrouped$UIToolbar$defaultSizeForOrientation$(UIToolbar* self, SEL _cmd, UIInterfaceOrientation orientation) {
	CGSize size;
	size.width = _logos_orig$_ungrouped$UIToolbar$defaultSizeForOrientation$(self, _cmd, orientation).width;
	size.height = 32.0f;
	return size;
}





static Class _logos_superclass$Twitter$ABSubTabBar; static void (*_logos_orig$Twitter$ABSubTabBar$reallySetFrame$)(ABSubTabBar*, SEL, CGRect);




static void _logos_super$Twitter$ABSubTabBar$reallySetFrame$(ABSubTabBar* self, SEL _cmd, CGRect frame) {return ((void (*)(ABSubTabBar*, SEL, CGRect))class_getMethodImplementation(_logos_superclass$Twitter$ABSubTabBar, @selector(reallySetFrame:)))(self, _cmd, frame);}static void _logos_method$Twitter$ABSubTabBar$reallySetFrame$(ABSubTabBar* self, SEL _cmd, CGRect frame) {
	frame.size.height = 32.0f;
	_logos_orig$Twitter$ABSubTabBar$reallySetFrame$(self, _cmd, frame);
}







static Class _logos_superclass$Tweetbot$PTHCustomTabBar; static void (*_logos_orig$Tweetbot$PTHCustomTabBar$setFrame$)(PTHCustomTabBar*, SEL, CGRect);




static void _logos_super$Tweetbot$PTHCustomTabBar$setFrame$(PTHCustomTabBar* self, SEL _cmd, CGRect frame) {return ((void (*)(PTHCustomTabBar*, SEL, CGRect))class_getMethodImplementation(_logos_superclass$Tweetbot$PTHCustomTabBar, @selector(setFrame:)))(self, _cmd, frame);}static void _logos_method$Tweetbot$PTHCustomTabBar$setFrame$(PTHCustomTabBar* self, SEL _cmd, CGRect frame) {
	frame.size.height = 33.0f;
	_logos_orig$Tweetbot$PTHCustomTabBar$setFrame$(self, _cmd, frame);
}







static Class _logos_superclass$LinkedIn$NavFooterView; static void (*_logos_orig$LinkedIn$NavFooterView$setFrame$)(NavFooterView*, SEL, CGRect);




static void _logos_super$LinkedIn$NavFooterView$setFrame$(NavFooterView* self, SEL _cmd, CGRect frame) {return ((void (*)(NavFooterView*, SEL, CGRect))class_getMethodImplementation(_logos_superclass$LinkedIn$NavFooterView, @selector(setFrame:)))(self, _cmd, frame);}static void _logos_method$LinkedIn$NavFooterView$setFrame$(NavFooterView* self, SEL _cmd, CGRect frame) {
	if (frame.origin.y == 44.0f)
		frame.origin.y = 32.0f;
		_logos_orig$LinkedIn$NavFooterView$setFrame$(self, _cmd, frame);
}





static __attribute__((constructor)) void _logosLocalCtor_43ec517d()
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	{{Class _logos_class$_ungrouped$UINavigationBar = objc_getClass("UINavigationBar"); _logos_superclass$_ungrouped$UINavigationBar = class_getSuperclass(_logos_class$_ungrouped$UINavigationBar); { Class _class = _logos_class$_ungrouped$UINavigationBar;Method _method = class_getInstanceMethod(_class, @selector(defaultSizeForOrientation:));if (_method) {_logos_orig$_ungrouped$UINavigationBar$defaultSizeForOrientation$ = _logos_super$_ungrouped$UINavigationBar$defaultSizeForOrientation$;if (!class_addMethod(_class, @selector(defaultSizeForOrientation:), (IMP)&_logos_method$_ungrouped$UINavigationBar$defaultSizeForOrientation$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$UINavigationBar$defaultSizeForOrientation$ = (CGSize (*)(UINavigationBar*, SEL, UIInterfaceOrientation))method_getImplementation(_method);_logos_orig$_ungrouped$UINavigationBar$defaultSizeForOrientation$ = (CGSize (*)(UINavigationBar*, SEL, UIInterfaceOrientation))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$UINavigationBar$defaultSizeForOrientation$);}}}Class _logos_class$_ungrouped$UIToolbar = objc_getClass("UIToolbar"); _logos_superclass$_ungrouped$UIToolbar = class_getSuperclass(_logos_class$_ungrouped$UIToolbar); { Class _class = _logos_class$_ungrouped$UIToolbar;Method _method = class_getInstanceMethod(_class, @selector(defaultSizeForOrientation:));if (_method) {_logos_orig$_ungrouped$UIToolbar$defaultSizeForOrientation$ = _logos_super$_ungrouped$UIToolbar$defaultSizeForOrientation$;if (!class_addMethod(_class, @selector(defaultSizeForOrientation:), (IMP)&_logos_method$_ungrouped$UIToolbar$defaultSizeForOrientation$, method_getTypeEncoding(_method))) {_logos_orig$_ungrouped$UIToolbar$defaultSizeForOrientation$ = (CGSize (*)(UIToolbar*, SEL, UIInterfaceOrientation))method_getImplementation(_method);_logos_orig$_ungrouped$UIToolbar$defaultSizeForOrientation$ = (CGSize (*)(UIToolbar*, SEL, UIInterfaceOrientation))method_setImplementation(_method, (IMP)&_logos_method$_ungrouped$UIToolbar$defaultSizeForOrientation$);}}}}}
	
	NSString *bundleIdentifier = [NSBundle mainBundle].bundleIdentifier;
	if ([bundleIdentifier isEqualToString:@"com.atebits.Tweetie2"])
		{Class _logos_class$Twitter$ABSubTabBar = objc_getClass("ABSubTabBar"); _logos_superclass$Twitter$ABSubTabBar = class_getSuperclass(_logos_class$Twitter$ABSubTabBar); { Class _class = _logos_class$Twitter$ABSubTabBar;Method _method = class_getInstanceMethod(_class, @selector(reallySetFrame:));if (_method) {_logos_orig$Twitter$ABSubTabBar$reallySetFrame$ = _logos_super$Twitter$ABSubTabBar$reallySetFrame$;if (!class_addMethod(_class, @selector(reallySetFrame:), (IMP)&_logos_method$Twitter$ABSubTabBar$reallySetFrame$, method_getTypeEncoding(_method))) {_logos_orig$Twitter$ABSubTabBar$reallySetFrame$ = (void (*)(ABSubTabBar*, SEL, CGRect))method_getImplementation(_method);_logos_orig$Twitter$ABSubTabBar$reallySetFrame$ = (void (*)(ABSubTabBar*, SEL, CGRect))method_setImplementation(_method, (IMP)&_logos_method$Twitter$ABSubTabBar$reallySetFrame$);}}}}
	else if ([bundleIdentifier isEqualToString:@"com.tapbots.Tweetbot"])
		{Class _logos_class$Tweetbot$PTHCustomTabBar = objc_getClass("PTHCustomTabBar"); _logos_superclass$Tweetbot$PTHCustomTabBar = class_getSuperclass(_logos_class$Tweetbot$PTHCustomTabBar); { Class _class = _logos_class$Tweetbot$PTHCustomTabBar;Method _method = class_getInstanceMethod(_class, @selector(setFrame:));if (_method) {_logos_orig$Tweetbot$PTHCustomTabBar$setFrame$ = _logos_super$Tweetbot$PTHCustomTabBar$setFrame$;if (!class_addMethod(_class, @selector(setFrame:), (IMP)&_logos_method$Tweetbot$PTHCustomTabBar$setFrame$, method_getTypeEncoding(_method))) {_logos_orig$Tweetbot$PTHCustomTabBar$setFrame$ = (void (*)(PTHCustomTabBar*, SEL, CGRect))method_getImplementation(_method);_logos_orig$Tweetbot$PTHCustomTabBar$setFrame$ = (void (*)(PTHCustomTabBar*, SEL, CGRect))method_setImplementation(_method, (IMP)&_logos_method$Tweetbot$PTHCustomTabBar$setFrame$);}}}}
	else if ([bundleIdentifier isEqualToString:@"com.linkedin.LinkedIn"])
		{Class _logos_class$LinkedIn$NavFooterView = objc_getClass("NavFooterView"); _logos_superclass$LinkedIn$NavFooterView = class_getSuperclass(_logos_class$LinkedIn$NavFooterView); { Class _class = _logos_class$LinkedIn$NavFooterView;Method _method = class_getInstanceMethod(_class, @selector(setFrame:));if (_method) {_logos_orig$LinkedIn$NavFooterView$setFrame$ = _logos_super$LinkedIn$NavFooterView$setFrame$;if (!class_addMethod(_class, @selector(setFrame:), (IMP)&_logos_method$LinkedIn$NavFooterView$setFrame$, method_getTypeEncoding(_method))) {_logos_orig$LinkedIn$NavFooterView$setFrame$ = (void (*)(NavFooterView*, SEL, CGRect))method_getImplementation(_method);_logos_orig$LinkedIn$NavFooterView$setFrame$ = (void (*)(NavFooterView*, SEL, CGRect))method_setImplementation(_method, (IMP)&_logos_method$LinkedIn$NavFooterView$setFrame$);}}}}
		
	[pool drain];
}
