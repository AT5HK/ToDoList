//
//  AddItemViewController.m
//  ToDoList
//
//  Created by Auston Salvana on 7/15/15.
//  Copyright (c) 2015 ASolo. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)backToMaster:(id)sender {
    self.makeToDoItem.title = self.itemTitle.text;
    self.makeToDoItem.cellDescription = self.itemDescription.text;
    self.makeToDoItem.priorityNumber = [self.itemPriority.text integerValue];
}
- (IBAction)cancelToMaster:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
