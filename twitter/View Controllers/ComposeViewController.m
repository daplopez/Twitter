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
@property (weak, nonatomic) NSString *curUserName;
@property (weak, nonatomic) NSString *imageUrl;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Getting user profile
    [[APIManager shared] getUserProfile:^(NSString *screenName, NSError *error) {
        if (screenName) {
            NSLog(@"Successfully got profile");
            self.curUserName = screenName;
            // Getting user's profile image
            [[APIManager shared] getUserPicture:screenName completion:^(NSString *picUrl, NSError *error) {
                if (picUrl) {
                    NSLog(@"Successfully got image");
                    self.imageUrl = picUrl;
                    NSURL *pictureURL = [NSURL URLWithString:self.imageUrl];
                    //NSString *url = [self.pictureURL stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
                    [self.profileImage setImageWithURL:pictureURL];
                } else {
                    NSLog(@"Error getting profile: %@", error.localizedDescription);
                }
            }];
            
        } else {
            NSLog(@"Error getting profile: %@", error.localizedDescription);
        }
    }];
    
    
    
//    NSString *url = [self.profilePicture stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    
    // Adding a border to compose text view
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
    // close compose view if button is pressed
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
