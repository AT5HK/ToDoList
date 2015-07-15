//
//  ToDo.h
//  ToDoList
//
//  Created by Auston Salvana on 7/15/15.
//  Copyright (c) 2015 ASolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDo : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *cellDescription;
@property (nonatomic) NSInteger priorityNumber;
@property (nonatomic) BOOL isCompletedIndicator;

- (instancetype)initWithTitle:(NSString*)itemTitle descriptionOfTask:(NSString*)description priorityNumber:(NSInteger)priority;

@end
