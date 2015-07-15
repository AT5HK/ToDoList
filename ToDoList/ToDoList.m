//
//  ToDoList.m
//  ToDoList
//
//  Created by Auston Salvana on 7/15/15.
//  Copyright (c) 2015 ASolo. All rights reserved.
//

#import "ToDoList.h"
#import "ToDo.h"

@interface ToDoList ()

@property (nonatomic) ToDo *toDo;
@end

@implementation ToDoList

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.toDoListArray = @[
                               self.toDo = [[ToDo alloc]initWithTitle:@"wash car"
                                                    descriptionOfTask:@"the car is dirty wash it"
                                                       priorityNumber:0],
                               
                               self.toDo = [[ToDo alloc]initWithTitle:@"Wake up"
                                                    descriptionOfTask:@"Get up in the morning"
                                                       priorityNumber:1],
                               
                               self.toDo = [[ToDo alloc]initWithTitle:@"make breakfast"
                                                    descriptionOfTask:@"eat in the morning"
                                                       priorityNumber:2],
                               
                               self.toDo = [[ToDo alloc]initWithTitle:@"watch tv"
                                                    descriptionOfTask:@"family guy"
                                                       priorityNumber:3],
                               
                               self.toDo = [[ToDo alloc]initWithTitle:@"drive to terminal"
                                                    descriptionOfTask:@"get to the terminal on time"
                                                       priorityNumber:4],
                               
                               self.toDo = [[ToDo alloc]initWithTitle:@"go to school"
                                                    descriptionOfTask:@"get to school on time"
                                                       priorityNumber:5],
                               
                               ];
    }
    return self;
}

@end
