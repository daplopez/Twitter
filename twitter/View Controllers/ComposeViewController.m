//
//  ComposeViewController.m
//  twitter
//
//  Created by Daphne Lopez on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "TimelineViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ComposeViewController () 
@property (weak, nonatomic) IBOutlet UITextView *composeTweetView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *url = [self.profilePicture stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    NSURL *pictureURL = [NSURL URLWithString:url];
    [self.profileImage setImageWithURL:pictureURL];
    self.textView.layer.borderWidth = 2.0;
    self.textView.layer.borderColor = UIColor.grayColor.CGColor;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didTapCLose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)didTapTweet:(id)sender {
    NSString *text = self.composeTweetView.text;
    [[APIManager shared] postStatusWithText:text completion:^(Tweet *tweet, NSError *error) {
        if (tweet) {
            NSLog(@"😎😎😎 Successfully posted new tweet");
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
            [self dismissViewControllerAnimated:true completion:nil];
        } else {
            NSLog(@"😫😫😫 Error posting new tweet: %@", error.localizedDescription);
        }
    }];
   
    
    
    
}


@end
