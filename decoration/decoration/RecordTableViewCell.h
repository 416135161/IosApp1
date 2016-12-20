//
//  RecordTableViewCell.h
//  decoration
//
//  Created by 林 建军 on 08/12/2016.
//  Copyright © 2016 yl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupLabel;

@end
