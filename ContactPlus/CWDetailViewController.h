//
//  CWDetailViewController.h
//  ContactPlus
//
//  Created by Ester Ytterbrink on 05/02/2014.
//  Copyright (c) 2014 Jayway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
