@interface PageViewController : UIViewController {
    NSArray *tips;
	NSUInteger tipIndex;
	UILabel *numView;
	UILabel *tipView;
}

@property (nonatomic, retain) NSArray *tips;
@property (nonatomic, assign) NSUInteger tipIndex;
@property (nonatomic, retain) UILabel *numView;
@property (nonatomic, retain) UILabel *tipView;

- (void)flipToTipAtIndex:(NSUInteger)index;
- (void)flipBack:(id)sender;
- (void)flipNext:(id)sender;

@end
