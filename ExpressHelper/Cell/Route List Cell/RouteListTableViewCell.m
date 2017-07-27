//
//  RouteListTableViewCell.m
//  ExpressHelper
//
//  Created by 307A on 2016/10/31.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "RouteListTableViewCell.h"

@interface RouteListTableViewCell()

@property (strong, nonatomic) UILabel *costLbl;
@property (strong, nonatomic) UILabel *companyLbl;

@end

@implementation RouteListTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initConstraints];
    }
    
    return self;
}

- (void)initConstraints {
    [self.companyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(kKDDimensSpacingCell);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.costLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - Getter
- (UILabel *)costLbl {
    if (!_costLbl) {
        _costLbl = [[UILabel alloc] init];
        _costLbl.textColor = [JHTools colorWithHexStr:kKDColorPrimaryGreen];
        _costLbl.font = [UIFont systemFontOfSize:kKDFontSizeMax weight:UIFontWeightLight];
        [self.contentView addSubview:_costLbl];
    }
    return _costLbl;
}

- (UILabel *)companyLbl {
    if (!_companyLbl) {
        _companyLbl = [[UILabel alloc] init];
        _companyLbl.font = [UIFont systemFontOfSize:kKDFontSizeNavTitle weight:UIFontWeightLight];
        [self.contentView addSubview:_companyLbl];
    }
    return _companyLbl;
}

#pragma mark - Setter
- (void)setRouteBean:(RouteBean *)routeBean {
    if (routeBean) {
        _routeBean = routeBean;
        _costLbl.text = [NSString stringWithFormat:@"¥ %@", _routeBean.cost];
        _companyLbl.text = _routeBean.companyName;
    }
}

#pragma mark - Override Methods
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
