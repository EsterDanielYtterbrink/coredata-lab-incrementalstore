//
//  CWPredefinedTitleCell.m
//  ContactPlus
//
//  Created by Ester Ytterbrink on 05/02/2014.
//  Copyright (c) 2014 Jayway. All rights reserved.
//

#import "CWPredefinedTitleCell.h"
@interface CWPredefinedTitleCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;

@end
@implementation CWPredefinedTitleCell
-(void)setPerson:(CWPerson *)person;
{
    if (person == _person) {
        return;
    }
    _person = person;
    if (self.key) {
        self.valueTextField.text = [_person valueForKey:self.key];
    }
    self.valueTextField.delegate = self;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField;
{
    if (self.person && self.key) {
        [self.person setValue:textField.text forKey:self.key];
    }
}

-(void)primitiveInit;
{
    self.valueTextField.delegate = self;
}
-(id)initWithCoder:(NSCoder *)aDecoder;
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self primitiveInit];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self primitiveInit];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
