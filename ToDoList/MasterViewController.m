//
//  MasterViewController.m
//  ToDoList
//
//  Created by Auston Salvana on 7/15/15.
//  Copyright (c) 2015 ASolo. All rights reserved.
//;
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ToDoList.h"
#import "CustomTableViewCell.h"
#import "AddItemViewController.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@property (nonatomic) ToDoList *toDoList;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.toDoList = [[ToDoList alloc]init];
    self.objects = [self.toDoList.toDoListArray mutableCopy];
//    NSLog(@"%@", [[list.toDoListArray objectAtIndex:1] cellDescription]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    ToDo *addToDoItem = [[ToDo alloc]init];
    [self performSegueWithIdentifier:@"AddItemViewController" sender:addToDoItem];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"DetailViewController"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ToDo *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
    else if ([[segue identifier] isEqualToString:@"AddItemViewController"]) {
        [[segue destinationViewController] setMakeToDoItem:sender];
    }
}

- (IBAction)unwindToMaster:(UIStoryboardSegue *)unwindSegue
{
    
    AddItemViewController *sourceViewController = unwindSegue.sourceViewController;
    if ([sourceViewController isKindOfClass:[AddItemViewController class]]) {
        self.madeToDoItem = sourceViewController.makeToDoItem;
        NSLog(@"sourceView: %@",sourceViewController.makeToDoItem );
            if (!self.objects) {
                self.objects = [[NSMutableArray alloc] init];
            }
            [self.objects insertObject:self.madeToDoItem atIndex:0];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
        NSLog(@"waf");
    }
   
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

//    NSDate *object = self.objects[indexPath.row];
//    cell.textLabel.text = [object description];
    cell.cellTitle.text = [self.objects[indexPath.row] title];
    cell.cellDescription.text = [self.objects[indexPath.row] cellDescription];
    cell.cellPriority.text = [NSString stringWithFormat:@"Priority number: %ld",(long)[self.objects[indexPath.row] priorityNumber]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
