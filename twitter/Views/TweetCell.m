//
//  TweetCell.m
//  twitter
//
//  Created by Daphne Lopez on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// Updating tweet count
- (IBAction)didTapLike:(id)sender {
    // TODO: Update the local tweet model
    if (self.tweet.favorited) {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
    } else {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
    }
    // TODO: Update cell UI
    [self refreshData];
    // TODO: Send a POST request to the POST favorites/create endpoint
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

- (void)refreshData {
    self.likesLabel.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    self.retweetLabel.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    
    if(self.tweet.favorited) {
        [self.didTapLike setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
   } else if (!self.tweet.favorited) {
       [self.didTapLike setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
   }
    
    if(self.tweet.retweeted) {
        [self.didTapRetweet setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    } else if (!self.tweet.retweeted) {
        [self.didTapRetweet setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)didTapRetweet:(id)sender {
    // TODO: Update the local tweet model
    if (self.tweet.retweeted) {
        self.tweet.retweeted = NO;
        self.tweet.retweeted -= 1;
    } else {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
    }
    // TODO: Update cell UI
    [self refreshData];
    // TODO: Send a POST request to the POST favorites/create endpoint
     [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
         if(error){
              NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
         }
         else{
             NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
         }
     }];
    
}


@end