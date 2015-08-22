#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

#define MENU_HEIGHT 23

void printScreenInfo() {
    NSRect screenRect, screenVisibleRect;
    NSArray *screenArray = [NSScreen screens];
    NSUInteger screenCount = [screenArray count];

    printf("%lu\n", (unsigned long)[screenArray count]);
    
    NSRect mainFrame = [[NSScreen mainScreen] frame];
    
    CGFloat diffHeight;
    CGFloat diffWidth;
    
    NSInteger dockScreenIndex = -1;
    for (NSUInteger index = 0; index < screenCount; index++)
    {
        NSScreen *screen = screenArray[index];
        
        // visibleFrame does not include menubar or dock
        screenVisibleRect = [screen visibleFrame];
        screenRect = [screen frame];
        
        diffHeight = screenRect.size.height - screenVisibleRect.size.height;
        diffWidth = screenRect.size.width - screenVisibleRect.size.width;
        
        // account for the menu bar on the primary screen
        diffHeight -= index == 0 ? MENU_HEIGHT : 0;
        
        // use FLT_EPSILON to avoid exact comparisons of floats
        if (diffHeight > FLT_EPSILON || diffWidth > FLT_EPSILON) {
            dockScreenIndex = index;
            break;
        }
    }
    
    printf("%.0f %.0f %lu\n", diffHeight, diffWidth, dockScreenIndex + 1);

    for (NSUInteger index = 0; index < screenCount; index++)
    {
        NSScreen *screen = [screenArray objectAtIndex: index];
        screenRect = [screen frame];
        CGFloat upperLeftY = -screenRect.origin.y - screenRect.size.height + mainFrame.size.height + MENU_HEIGHT;
        CGFloat height = screenRect.size.height - MENU_HEIGHT;
        printf("%.0f %.0f %.0f %.0f\n", screenRect.origin.x, upperLeftY, screenRect.size.width, height);
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        printScreenInfo();
    }
    return 0;
}
