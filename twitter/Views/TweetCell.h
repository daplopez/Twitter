//
//  TweetCell.h
//  twitter
//
//  Created by Daphne Lopez on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property Tweet *tweet;
@property (weak, nonatomic) IBOutlet UILabel *tweetUsername;
@property (weak, nonatomic) IBOutlet UILabel *tweetDate;
@property (weak, nonatomic) IBOutlet UILabel *tweetAuthor;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UIButton *didTapReply;
@property (weak, nonatomic) IBOutlet UIButton *didTapRetweet;
@property (weak, nonatomic) IBOutlet UIButton *didTapLike;
@property (weak, nonatomic) IBOutlet UIButton *didTapMessage;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;

@end

NS_ASSUME_NONNULL_END
