//
//  ViewController.m
//  TCCategories
//
//  Created by 陈 胜 on 16/6/12.
//  Copyright © 2016年 陈胜. All rights reserved.
//

#import "ViewController.h"
#import "TCCategories.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.imageView tc_setCorner];
}

@end
