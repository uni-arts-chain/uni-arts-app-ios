//
//  JLReceiveAddressTableViewCell.h
//  CloudArtChain
//
//  Created by 朱彬 on 2021/1/20.
//  Copyright © 2021 朱彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JLReceiveAddressTableViewCell : UITableViewCell
@property (nonatomic, copy) void(^editAddressBlock)(void);
@end

NS_ASSUME_NONNULL_END
