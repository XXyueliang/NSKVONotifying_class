//
//  ViewController.m
//  KVO
//
//  Created by macvivi on 2020/7/15.
//  Copyright © 2020 macvivi. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>





@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *label;

@property(strong,nonatomic)Person *person;

@end

@implementation ViewController

- (IBAction)btnClick:(id)sender {
    self.person.name = @"newName";
    NSLog(@"realClass:%@",object_getClass(self.person));
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.person = [Person new];
    NSLog(@"realClass:%@",object_getClass(self.person));
    [self.person xy_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew |
     NSKeyValueObservingOptionOld context:nil];
    NSLog(@"后来-----");
     NSLog(@"realClass:%@",object_getClass(self.person));
    self.person.name = @"name";
    self.label.text = self.person.name;
    
    [self methodForSelector:@selector(setFill)];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"%@",keyPath);
    NSLog(@"%@",object);
    NSLog(@"%@",change);
    NSLog(@"%@",context);
    NSLog(@"-------------");
}






@end
