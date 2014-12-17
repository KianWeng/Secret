//
//  AlgorithmChooseViewController.m
//  Secret
//
//  Created by Polly on 14-12-16.
//  Copyright (c) 2014年 翁高剑. All rights reserved.
//

#import "AlgorithmChooseViewController.h"
#define sectionCount 1

@interface AlgorithmChooseViewController ()

@property (strong, nonatomic) NSArray *algorithmArray;

- (IBAction)backToRootView:(id)sender;

@end

@implementation AlgorithmChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.algorithmArray = @[@"CaesarShiftsForEnglish",@"CaesarShiftsForChinese", @"TheRailFenceCipher", @"MorseCode"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return sectionCount;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.algorithmArray count];
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return  @"Algorithm";
}

- (IBAction)backToRootView:(id)sender {
    [self performSegueWithIdentifier:@"ViewController" sender: self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: TableSampleIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: TableSampleIdentifier];
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.algorithmArray objectAtIndex:row];
    return  cell;
}

@end
