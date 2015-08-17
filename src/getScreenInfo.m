#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

#define MENU_HEIGHT 23

void printScreenInfo() {
    NSRect screenRect, screenVisibleRect;
    NSArray *screenArray = [NSScreen screens];
    NSUInteger screenCount = [screenArray count];

    printf("%lu\n", (unsigned long)[screenArray count]);

    NSRect mainFrame = [[screenArray objectAtIndex:0] frame];

    CGFloat offsetBottom = 0;
    NSInteger dockScreenIndex = -1;
    for (NSUInteger index = 0; index < screenCount; index++)
    {
        NSScreen *screen = [screenArray objectAtIndex: index];
        screenVisibleRect = [screen visibleFrame];
        screenRect = [screen frame];
        CGFloat diffHeight = screenRect.size.height - screenVisibleRect.size.height;

        if (diffHeight != 0) {
            diffHeight -= index == 0 ? MENU_HEIGHT : 0;
            dockScreenIndex = index;
            offsetBottom = diffHeight;
            break;
        }
    }

    printf("%.0f %lu\n", offsetBottom, dockScreenIndex + 1);

    for (NSUInteger index = 0; index < screenCount; index++)
    {
        NSScreen *screen = [screenArray objectAtIndex: index];
        screenVisibleRect = [screen visibleFrame];
        screenRect = [screen frame];
        CGFloat upperLeftY = -screenRect.origin.y - screenRect.size.height + mainFrame.size.height + MENU_HEIGHT;
        CGFloat height = screenRect.size.height - MENU_HEIGHT;
        printf("%.0f %.0f %.0f %.0f\n",screenRect.origin.x, upperLeftY, screenRect.size.width, height);
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        printScreenInfo();
    }
    return 0;
}
