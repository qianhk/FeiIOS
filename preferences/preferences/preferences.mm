#line 1 "/OnGit/FeiIOS/preferences/preferences/preferences.xm"





#include <substrate.h>
@class ClassName; 
static id (*_logos_meta_orig$_ungrouped$ClassName$sharedInstance)(Class, SEL); static id _logos_meta_method$_ungrouped$ClassName$sharedInstance(Class, SEL); static void (*_logos_orig$_ungrouped$ClassName$messageWithNoReturnAndOneArgument$)(ClassName*, SEL, id); static void _logos_method$_ungrouped$ClassName$messageWithNoReturnAndOneArgument$(ClassName*, SEL, id); static id (*_logos_orig$_ungrouped$ClassName$messageWithReturnAndNoArguments)(ClassName*, SEL); static id _logos_method$_ungrouped$ClassName$messageWithReturnAndNoArguments(ClassName*, SEL); 

#line 6 "/OnGit/FeiIOS/preferences/preferences/preferences.xm"



static id _logos_meta_method$_ungrouped$ClassName$sharedInstance(Class self, SEL _cmd) {
	NSLog(@"+[<ClassName: %p> sharedInstance]", self);

	return _logos_meta_orig$_ungrouped$ClassName$sharedInstance(self, _cmd);
}


static void _logos_method$_ungrouped$ClassName$messageWithNoReturnAndOneArgument$(ClassName* self, SEL _cmd, id originalArgument) {
	NSLog(@"-[<ClassName: %p> messageWithNoReturnAndOneArgument:%@]", self, originalArgument);

	_logos_orig$_ungrouped$ClassName$messageWithNoReturnAndOneArgument$(self, _cmd, originalArgument);
	
	
}


static id _logos_method$_ungrouped$ClassName$messageWithReturnAndNoArguments(ClassName* self, SEL _cmd) {
	NSLog(@"-[<ClassName: %p> messageWithReturnAndNoArguments]", self);

	id originalReturnOfMessage = _logos_orig$_ungrouped$ClassName$messageWithReturnAndNoArguments(self, _cmd);
	
	

	return originalReturnOfMessage;
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
{Class _logos_class$_ungrouped$ClassName = objc_getClass("ClassName"); Class _logos_metaclass$_ungrouped$ClassName = object_getClass(_logos_class$_ungrouped$ClassName); MSHookMessageEx(_logos_metaclass$_ungrouped$ClassName, @selector(sharedInstance), (IMP)&_logos_meta_method$_ungrouped$ClassName$sharedInstance, (IMP*)&_logos_meta_orig$_ungrouped$ClassName$sharedInstance);MSHookMessageEx(_logos_class$_ungrouped$ClassName, @selector(messageWithNoReturnAndOneArgument:), (IMP)&_logos_method$_ungrouped$ClassName$messageWithNoReturnAndOneArgument$, (IMP*)&_logos_orig$_ungrouped$ClassName$messageWithNoReturnAndOneArgument$);MSHookMessageEx(_logos_class$_ungrouped$ClassName, @selector(messageWithReturnAndNoArguments), (IMP)&_logos_method$_ungrouped$ClassName$messageWithReturnAndNoArguments, (IMP*)&_logos_orig$_ungrouped$ClassName$messageWithReturnAndNoArguments);}  
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
#line 36 "/OnGit/FeiIOS/preferences/preferences/preferences.xm"
