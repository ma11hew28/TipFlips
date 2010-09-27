#import "PageViewController.h"

#define BAR_BUTTON(TITLE, SELECTOR) [[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]
#define RESET_TIP_VIEW_SIZE \
	CGSize tipSize = [tipView.text sizeWithFont:tipView.font \
							  constrainedToSize:CGSizeMake(tipView.frame.size.width, self.view.frame.size.height/1.3f) \
								  lineBreakMode:tipView.lineBreakMode]; \
	tipView.frame = CGRectMake(tipView.frame.origin.x, tipView.frame.origin.y, tipView.frame.size.width, tipSize.height)

@implementation PageViewController

@synthesize tips;
@synthesize tipIndex;
@synthesize numView;
@synthesize tipView;

- (void)loadView {
	CGRect navFrame = [[UIScreen mainScreen] applicationFrame];
	navFrame.size.height -= self.navigationController.navigationBar.frame.size.height;
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:navFrame];
	imageView.image = [UIImage imageNamed:@"background.jpg"];
	imageView.backgroundColor = [UIColor blackColor];
	imageView.clearsContextBeforeDrawing = NO;
	imageView.opaque = YES;

	UILabel *localNumView = [[UILabel alloc] initWithFrame:CGRectMake(100.0f, 39.0f, 120.0f, 40.0f)];
	self.numView = localNumView;
	[localNumView release];
	numView.clearsContextBeforeDrawing = NO;
	numView.backgroundColor = [UIColor orangeColor];
	[imageView addSubview:numView];
	[numView release];

	UILabel *localTipView = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 100.0f, 280.0f, 320.0f)];
	self.tipView = localTipView;
	[localTipView release];
	tipView.clearsContextBeforeDrawing = NO;
	tipView.backgroundColor = [UIColor lightGrayColor];
	[imageView addSubview:tipView];
	[tipView release];

	self.view = imageView;
	[imageView release];
}

- (void)viewDidLoad {
	tips = [[NSArray alloc] initWithObjects:
			@"Anything is possible. You will achieve your wildest dreams if you start practicing the \"Six Steps to Success\" described in the book \"Think and Grow Rich\" by Napoleon Hill. Bruce Lee did. He scripted his life pretty much verbatim. You can do the same. Google: Bruce Lee Think and Grow Rich. If you've seen the movie \"The Secret,\" this is the book that the producer got it from. If you haven't seen \"The Secret,\" go see it now!",
			@"Landmark Education caused a dramatic, positive shift in my life in just one weekend for less than $500. It was worth 100-times more. That's how most businesses should work. They should sell you their product for 100-times less than its actual value. I heard this idea from Eben Pagan (A.K.A David DeAngelo, marketing guru and author of the popular ebook \"Double Your Dating\").",
			@"I read \"Double Your Dating\" (DYD) when I was 19, and it was like taking the \"Red Pill\" (If you haven't seen \"The Matrix\", stop what you're doing right now, and go see it!). Reading DYD caused me to truly get that anything is possible and sent me on an amazing new path to self-actualization. Wow...",
			@"Tony Robbins' Unleash the Power Within weekend conference was an INCREDIBLE weekend. After it, I read \"The China Study,\" and it saved my life.",
			@"Did you know that heart disease is the leading cause of death in America and kills over 1 million Americans per year, and yet it's completely preventible and even reversible with a whole, plant-based diet, full of nutrient-dense, green, leafy vegetables and sweet potatoes (according to Dr. McDougal). No meat, fish, dairy, oil (not even pressed olive oil), and for some people, no nuts & avocado. Look up the book \"Prevent and Reverse Heart Disease\" by Caldwell B. Esselstyn. Also, check out Joel Fuhrman's book \"Eat to Live.\" A plant-based diet also prevents and cures cancer, diabetes, MS, osteoperosis, and many other prominent diseases.",
			@"Learn by doing. It's the best way to learn. Reading books and going to conferences are great ways to learn as well but only if you apply what you learn! Focused action creates incredible results. I'm a plant-based eater.",
			@"If you're scared to do or say something, consider that might be a good reason to do or say it anyway. Check out Susan Jeffers' book \"Feel the Fear and Do It Anyway.\" I said do, not try. Speak only with empowering words. Your words create your world.",
			@"\"Whether you think you can or you can't, you're right.\" - Henry Ford, a stupid genius",
			@"three20 is a cool, open-source (on github.com) library for iPhone development that was headed by Joe Hewitt (also the creator of FireBug) and derived from Facebook's iPhone app.",
			@"There's 10 types of computer scientists in the world: those who understand binary and those who don't.",
			@"There's three kinds of mathematicians in the world: those who can count and those who can't.",
			@"Listen to Joseph Campbell: \"Follow your bliss.\" At the very least, listen to Rich Dad's advice on how to get out of the rat race of working a mediocre job just to pay the bills: \"Do your homework,\" which means work on developing yourself, your skills, your resume, your companies, when you come home from your day job until you can free yourself from it.",
			@"Where can I find out more about memory management for Objective-C and iPhone apps? I read the Xcode docs, and that raised a bunch of questions. If you really know it well, please contact me so we can get together and discuss. Thanks!",
			@"Work in teams. It's much more effective than working on your own. On that note, please feel free to contribute to this open source project. You may even add more tips if you like. I'll add your name to the Contributors list. One thing I'd like to add is the ability to swipe left & right, instead of clicking the \"Back\" & \"Next\" buttons to turn pages. Also, feel free to get in touch with me to collaborate on other projects or opportunities. I'm currently focusing mainly on acani on github.com. An iPhone app to connect you with people nearby with similar interests. Come join us there!", nil];
	tipIndex = 0;

	self.navigationController.navigationBar.tintColor = [UIColor clearColor];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	self.title = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];

//	// create left-pointing button (didn't work)
//	UIButton *nextButton = [UIButton buttonWithType:101]; // left-pointing shape!
//	[nextButton addTarget:self action:@selector(flipNext:) forControlEvents:UIControlEventTouchUpInside];
//	[nextButton setTitle:@"Next" forState:UIControlStateNormal];
//	
//	// create button item -- possible because UIButton subclasses UIView!
//	UIBarButtonItem *nextItem = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
//	self.navigationItem.rightBarButtonItem = nextItem;
//	[nextItem release];
	
	UIBarButtonItem *nextButton = BAR_BUTTON(@"Next", @selector(flipNext:));
	self.navigationItem.rightBarButtonItem = nextButton;
	[nextButton release];

	numView.textAlignment = UITextAlignmentCenter;
	numView.font = [UIFont systemFontOfSize:24.0f];
	numView.text = [NSString stringWithFormat:@"Tip %d:", tipIndex+1];
	numView.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin |
								UIViewAutoresizingFlexibleBottomMargin |
								UIViewAutoresizingFlexibleLeftMargin |
								UIViewAutoresizingFlexibleRightMargin);
	
	tipView.textAlignment = UITextAlignmentCenter;
	tipView.font = [UIFont systemFontOfSize:14.0f];
    tipView.text = [tips objectAtIndex:tipIndex];
	tipView.numberOfLines = 0;
	tipView.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin |
								UIViewAutoresizingFlexibleBottomMargin |
								UIViewAutoresizingFlexibleWidth |
								UIViewAutoresizingFlexibleHeight);
	RESET_TIP_VIEW_SIZE;
}

- (void)flipToTipAtIndex:(NSUInteger)index {
	if (tipIndex == index) {
		return;
	}

	// disable user interaction during the flip
    self.navigationController.navigationBar.userInteractionEnabled = NO;
	
	BOOL isForwardFlip = tipIndex < index;
	[UIView beginAnimations:@"Flip" context:nil];
	[UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(pageTurnDidStop:finished:context:)];
	if (isForwardFlip) {
		[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
	} else {
		[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
	}
	[UIView commitAnimations];

	// Update tip text
	tipIndex = index;
	numView.text = [NSString stringWithFormat:@"Tip %d:", tipIndex+1];
	tipView.text = [tips objectAtIndex:tipIndex];
	RESET_TIP_VIEW_SIZE;

	// Hide/show navigation buttons if necessary
	if (isForwardFlip) {
		if (tipIndex == tips.count-1) {
			self.navigationItem.rightBarButtonItem = nil;
		} else {
			if (self.navigationItem.leftBarButtonItem == nil) {
				UIBarButtonItem *backButton = BAR_BUTTON(@"Back", @selector(flipBack:));
				self.navigationItem.leftBarButtonItem = backButton;
				[backButton release];
			}			
		}		
	} else {
		if (tipIndex == 0) {
			self.navigationItem.leftBarButtonItem = nil;
		} else {
			if (self.navigationItem.rightBarButtonItem == nil) {
				UIBarButtonItem *nextButton = BAR_BUTTON(@"Next", @selector(flipNext:));
				self.navigationItem.rightBarButtonItem = nextButton;
				[nextButton release];
			}			
		}		
	}
}

// These functions cannot be called at the first & last pages, respectively.
- (void)flipBack:(id)sender {
	[self flipToTipAtIndex:tipIndex-1];
}

- (void)flipNext:(id)sender {
	[self flipToTipAtIndex:tipIndex+1];
}

- (void)pageTurnDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    // re-enable user interaction when the flip is completed.
    self.navigationController.navigationBar.userInteractionEnabled = YES;
}

// Reposition numView & tipView for landscape orientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.tips = nil;
	tipView = nil;
	numView = nil;
}

- (void)dealloc {
	[tips release];
    [super dealloc];
}

@end
