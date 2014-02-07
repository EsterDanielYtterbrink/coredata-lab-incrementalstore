//
//  CWEditPropertyCell.m
//  ContactPlus
//
//  Created by Ester Ytterbrink on 05/02/2014.
//  Copyright (c) 2014 Jayway. All rights reserved.
//

#import "CWEditPropertyCell.h"
@interface CWEditPropertyCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *labelTextField;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;

@end
@implementation CWEditPropertyCell
-(void)setProperty:(CWPersonProperty *)property;
{
    if (_property == property) {
        return;
    }
    _property = property;
    
    self.labelTextField.text = _property.label;
    self.valueTextField.text = _property.value;
    self.labelTextField.delegate = self;
    self.valueTextField.delegate = self;
}

-(void)textFieldDidEndEditing:(UITextField *)textField;
{
    if (textField == self.labelTextField) {
        self.property.label = textField.text;
    }
    if (textField == self.valueTextField) {
        self.property.value = textField.text;
    }
}

@end
