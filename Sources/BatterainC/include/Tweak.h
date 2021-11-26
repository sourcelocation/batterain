#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface _UIBatteryView : UIView
-(void)_updateBodyColors;
-(void)_updateBatteryFillColor;
-(void)_updateFillLayer;
-(double)chargePercent;
@end

NS_ASSUME_NONNULL_END
