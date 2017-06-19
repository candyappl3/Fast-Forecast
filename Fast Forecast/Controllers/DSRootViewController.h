//
//  DSRootViewController.h
//  Fast Forecast
//
//  Created by Dmitry Shadrin on 15.06.17.
//  Copyright © 2017 Dmitry Shadrin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSRootViewController : UIViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *weatherBackground;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIToolbar *bottomToolbar;

@end
