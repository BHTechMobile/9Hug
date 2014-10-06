//
//  SListViewCell.h
//  SPhoto
//
//  Created by SunJiangting on 12-8-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
/// 参照 UITableViewCell
@interface SListViewCell : UITableViewCell

@property (nonatomic, copy) NSString * reuseIdentifier;
@property (nonatomic, readonly) UIView * separatorView;
@property (nonatomic, readonly) UIImageView * imgBackground;

- (id)initWithReuseIdentifier:(NSString *) reuseIdentifier;

-(void)setImageUrl:(NSString*)imageURL;

@end
