//
//  DetailsViewController.m
//  twitter
//
//  Created by Daphne Lopez on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "APIManager.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name.text = self.tweet.user.name;
    self.tweetText.text = self.tweet.text;
    self.username.text = self.tweet.user.screenName;
    self.retweetLabel.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.favorLabel.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    if (self.tweet.favorited) {
        [self.favorButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    } else if (!self.tweet.favorited) {
        [self.favorButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
    if (self.tweet.retweeted) {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    } else if (!self.tweet.retweeted) {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }

    // Getting profile image
    NSString *URLString = [self.tweet.user.profilePicture stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    NSURL *url = [NSURL URLWithString:URLString];
//    NSData *urlData = [NSData dataWithContentsOfURL:url];
//    cell.profileImage.image = [UIImage imageWithData:urlData];
//    [cell.profileImage setData:urlData];
    self.date.text = self.tweet.createdAtString;
    [self.profileImage setImageWithURL:url];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)didTapRetweet:(id)sender {
    // Update the local tweet model
    if (self.tweet.retweeted) {
        self.tweet.retweeted = NO;
        self.tweet.retweeted -= 1;
    } else {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
    }
    // Update cell UI
    [self refreshData];
    // Send a POST request to the POST favorites/create endpoint
     [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
         if(error){
              NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
         }
         else{
             NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
         }
     }];
}

- (IBAction)didTapFavor:(id)sender {
    // TODO: Update the local tweet model
    if (self.tweet.favorited) {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
    } else {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
    }
    // Update cell UI
    [self refreshData];
    // Send a POST request to the POST favorites/create endpoint
    if (self.tweet.favorited) {
     [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
         if(error){
              NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
         }
         else{
             NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
         }
     }];
    } else if (!self.tweet.favorited) {
        [[APIManager shared] unFavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
}


// Update cell's values to reflect any changes
- (void)refreshData {
    self.favorLabel.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    self.retweetLabel.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    
    if(self.tweet.favorited) {
        [self.favorButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
   } else if (!self.tweet.favorited) {
       [self.favorButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
   }
    
    if(self.tweet.retweeted) {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    } else if (!self.tweet.retweeted) {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
    
}

@end
