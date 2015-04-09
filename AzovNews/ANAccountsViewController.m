//
//  ViewController.m
//  AzovNews
//
//  Created by Alexey Voitenko on 08.04.15.
//  Copyright (c) 2015 programmersfamily. All rights reserved.
//

#import "ANAccountsViewController.h"
#import "ANFacebookManager.h"
#import "ANVKManager.h"


@interface ANAccountsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *vkButton;
@property (weak, nonatomic) IBOutlet UIButton *fbButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@end


@implementation ANAccountsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateView];
}

- (void)updateView
{
    self.vkButton.enabled = ![ANVKManager sharedManager].isAuthorized;
    self.fbButton.enabled = ![ANFacebookManager sharedManager].isAuthorized;
    self.closeButton.hidden = ![ANVKManager sharedManager].isAuthorized && ![ANFacebookManager sharedManager].isAuthorized;
}

#pragma mark - Actions

- (IBAction)vkButtonPressed
{
    [[ANVKManager sharedManager] authorizeWithCompletionHandler:^(BOOL isSuccess) {
        if (isSuccess) {
            [self updateView];
        }
    }];
}

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
