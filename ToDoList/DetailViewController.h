//
//  DetailViewController.h
//  ToDoList
//
//  Created by Auston Salvana on 7/15/15.
//  Copyright (c) 2015 ASolo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDo.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) ToDo* detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


@end

