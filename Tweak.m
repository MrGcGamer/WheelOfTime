#import <objc/runtime.h>
#import "substrate.h"

@import Foundation;
@class UIDatePicker;

static void (*orig_UIDatePickerSetStyle) (UIDatePicker *, SEL, NSInteger);
static void hooked_UIDatePickerSetStyle (UIDatePicker *self, SEL cmd, NSInteger arg1) {
	orig_UIDatePickerSetStyle(self, cmd, 1);
}

static __attribute__((constructor)) void init (int argc, char **argv, char **envp) {
	MSHookMessageEx(objc_getClass("UIDatePicker"), @selector(setPreferredDatePickerStyle:), (IMP) &hooked_UIDatePickerSetStyle, (IMP *) &orig_UIDatePickerSetStyle);
}