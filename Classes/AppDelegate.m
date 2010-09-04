#import "AppDelegate.h"
#import "PageViewController.h"

@implementation AppDelegate

@synthesize window, nav;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    	
	window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
	nav = [[UINavigationController alloc] initWithRootViewController:[[PageViewController alloc] init]];
	[window addSubview:nav.view];
	[window makeKeyAndVisible];
	return YES;
}

- (void)dealloc {
    [nav release];
    [window release];
    [super dealloc];
}

@end
