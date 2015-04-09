//
//  ViewController.m
//  AzovNews
//
//  Created by Alexey Voitenko on 08.04.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//

#import "ANAccountsViewController.h"
#import "ANFacebookManager.h"


@interface ANAccountsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *fbButton;
@end


@implementation ANAccountsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateView];
}

- (void)updateView
{
    self.fbButton.enabled = ![ANFacebookManager sharedManager].isAuthorized;
}

#pragma mark - Actions

- (IBAction)fbButtonPressed
{
    [[ANFacebookManager sharedManager] authorizeWithCompletionHandler:^(BOOL isSuccess) {
        if (isSuccess) {
            [self updateView];
        }
    }];
}

- (IBAction)closeButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
