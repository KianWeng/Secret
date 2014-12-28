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
@property (weak, nonatomic) NSString *algorithm;
//@property (weak, nonatomic) UITableView *tableView;


- (IBAction)backToRootView:(id)sender;

@end

@implementation AlgorithmChooseViewController
{
    long int currentIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.algorithmArray = @[@"凯撒密码（英文版）",@"凯撒密码（中文版）", @"栅栏密码", @"维吉尼亚密码",@"波利比奥斯密码",@"乘法密码",@"摩斯电码"];
    currentIndex = 0;
    //NSLog(@"the currentIndexString is %@",_currentIndexString);
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
    return  @"请选择加密算法";
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
    /*if(currentIndex == indexPath.row)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }*/
    return  cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSIndexPath *index=[tableView indexPathForSelectedRow];
    currentIndex = [_currentIndexString intValue];
    if (currentIndex == indexPath.row )
        //[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        //[cell setAccessoryType:UITableViewCellAccessoryNone];
        cell.accessoryType = UITableViewCellAccessoryNone;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];//选中的cell数
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];//将选中的cell打勾
    //currentIndex = indexPath.row;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"************%ld",(long)indexPath.row);
    currentIndex = indexPath.row;
    _currentIndexString = [NSString stringWithFormat:@"%ld",currentIndex];
    //NSLog(@"the currentIndexString00 is %@",_currentIndexString);
    switch (indexPath.row) {
        case 0:
            self.algorithm = @"algorithm0";
            break;
        case 1:
            self.algorithm = @"algorithm1";
            break;
        case 2:
            self.algorithm = @"algorithm2";
            break;
        case 3:
            self.algorithm = @"algorithm3";
            break;
        case 4:
            self.algorithm = @"algorithm4";
            break;
        case 5:
            self.algorithm = @"algorithm5";
            break;
        case 6:
            self.algorithm = @"algorithm6";
            break;
        default:
            break;
    }
    [tableView reloadData];
    [self performSegueWithIdentifier:@"ViewController" sender: self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *send2 = segue.destinationViewController;
    [send2 setValue: _currentIndexString forKey:@"currentIndex"];
    [send2 setValue: _algorithm forKey: @"algorithmText"];
}
@end
