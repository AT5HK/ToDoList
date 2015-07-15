//
//  AddItemViewController.h
//  ToDoList
//
//  Created by Auston Salvana on 7/15/15.
//  Copyright (c) 2015 ASolo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDo.h"

@interface AddItemViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *itemTitle;
@property (weak, nonatomic) IBOutlet UITextField *itemDescription;
@property (weak, nonatomic) IBOutlet UITextField *itemPriority;
@property (nonatomic) ToDo *makeToDoItem;



@end
