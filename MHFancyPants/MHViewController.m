//
//  MHViewController.m
//  MHFancyPants
//
//  Created by Martin Hartl on 28/09/13.
//  Copyright (c) 2013 Martin Hartl. All rights reserved.
//

#import "MHViewController.h"
#import "MHFancyPants.h"

@interface MHViewController ()
@property (weak, nonatomic) IBOutlet UIView *ibView1;
@property (weak, nonatomic) IBOutlet UIView *ibView2;
@property (weak, nonatomic) IBOutlet UILabel *ibLabel;

@end

@implementation MHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.ibView1.backgroundColor = [MHFancyPants colorForKey:@"view1BackgroundColor"];
    self.ibView2.backgroundColor = [MHFancyPants colorForKey:@"view2BackGroundColor"];
    
    self.ibLabel.text = [MHFancyPants stringForKey:@"text"];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:[MHFancyPants timeIntervalForKey:@"view1AnimationDuration"] animations:^{
        self.ibView1.frame = [MHFancyPants rectForKey:@"view1Frame"];
        self.ibView2.center = [MHFancyPants pointForKey:@"view2Center"];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
