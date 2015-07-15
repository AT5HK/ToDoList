//
//  ToDo.m
//  ToDoList
//
//  Created by Auston Salvana on 7/15/15.
//  Copyright (c) 2015 ASolo. All rights reserved.
//

#import "ToDo.h"

@implementation ToDo

- (instancetype)initWithTitle:(NSString*)itemTitle descriptionOfTask:(NSString*)description priorityNumber:(NSInteger)priority
{
    self = [super init];
    if (self) {
        self.isCompletedIndicator = NO;
        self.title = itemTitle;
        self.cellDescription = description;
        self.priorityNumber = priority;
        self.deadLine = [NSDate date];
    }
    return self;
}

@end
