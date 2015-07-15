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
@property (nonatomic) NSInteger savedIndex;
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
        self.savedIndex = indexPath.row;
        [[segue destinationViewController] setDetailItem:object];
    }
    else if ([[segue identifier] isEqualToString:@"AddItemViewController"]) {
        [[segue destinationViewController] setMakeToDoItem:sender];
    }
}

- (IBAction)unwindToMaster:(UIStoryboardSegue *)unwindSegue
{
    AddItemViewController *addItemVC = unwindSegue.sourceViewController;
    DetailViewController *detailVC = unwindSegue.sourceViewController;
    
    if ([addItemVC isKindOfClass:[AddItemViewController class]]) {
        self.madeToDoItem = addItemVC.makeToDoItem;
//        NSLog(@"sourceView: %@",sourceViewController.makeToDoItem );
            if (!self.objects) {
                self.objects = [[NSMutableArray alloc] init];
            }
            [self.objects insertObject:self.madeToDoItem atIndex:0];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
       
    }
    else if ([detailVC isKindOfClass:[DetailViewController class]]) {
        if (!self.objects) {
            self.objects = [[NSMutableArray alloc] init];
        }
        [self.objects replaceObjectAtIndex:self.savedIndex withObject:detailVC.detailItem];
        [self.tableView reloadData];
    }
}

#pragma mark - Table View data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    ToDo *object = self.objects[indexPath.row];
    cell.cellTitle.text = object.title;
    cell.cellDescription.text = object.cellDescription;
    cell.cellPriority.text = [NSString stringWithFormat:@"Priority number: %ld",(long)object.priorityNumber];
    cell.deadLine.text = [NSString stringWithFormat:@"Deadline due date: %@",object.deadLine];
    
    if (object.isCompletedIndicator) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.cellTitle.attributedText = [self crossOutText:cell.cellTitle.text];
        cell.cellDescription.attributedText = [self crossOutText:cell.cellDescription.text];
        cell.cellPriority.attributedText = [self crossOutText:cell.cellPriority.text];
        
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - tableView delegate

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < [self.objects count]) {
        return YES;
    }
    return NO;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self.objects exchangeObjectAtIndex:sourceIndexPath.row
                      withObjectAtIndex:destinationIndexPath.row];
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

#pragma mark - Swipe Gesture

- (IBAction)swipeGest:(id)sender {
    UISwipeGestureRecognizer *swipe = sender;
    CGPoint point = [swipe locationInView:self.tableView];
    NSIndexPath *cellIndex = [self.tableView indexPathForRowAtPoint:point];
    CustomTableViewCell *cell = (CustomTableViewCell*)[self.tableView cellForRowAtIndexPath:cellIndex];
    
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cell.cellTitle.attributedText = [self crossOutText:cell.cellTitle.text];
    cell.cellDescription.attributedText = [self crossOutText:cell.cellDescription.text];
    cell.cellPriority.attributedText = [self crossOutText:cell.cellPriority.text];
    ToDo *object = self.objects[cellIndex.row];
    object.isCompletedIndicator = YES;
    NSLog(@"swipe");
}

#pragma mark - Helper methods

-(NSAttributedString*)crossOutText:(NSString*)textToCross {
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:textToCross];
    [attributeString addAttribute:NSStrikethroughStyleAttributeName
                            value:@2
                            range:NSMakeRange(0, [attributeString length])];
    return attributeString;
}

@end
