//
//  GameSummaryCell.h
//  FootyTips
//
//  Created by Michael Koukoullis on 29/04/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameSummaryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *homeTeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamLabel;

@end
