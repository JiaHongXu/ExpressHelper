//
//  KDDetailLabelCell.m
//  KDork
//
//  Created by Jiahong Xu on 2017/3/27.
//  Copyright © 2017年 徐嘉宏. All rights reserved.
//

#import "KDDetailLabelCell.h"

@interface KDDetailLabelCell ()
@property (assign, nonatomic) KDDetailLabelCellStyle style;
@end

@implementation KDDetailLabelCell
@synthesize preferrenceTitleWidth = _preferrenceTitleWidth;

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithDetailLabelStyle:(KDDetailLabelCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        self.style = style;
        [self setupConstraints];
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    return [self initWithDetailLabelStyle:KDDetailLabelCellStyleDefault reuseIdentifier:reuseIdentifier];
}

#pragma mark - Setup Methods
- (void)setupConstraints {
    switch (_style) {
        case KDDetailLabelCellStyleDefault:
            [self setupAsDefault];
            break;
        case KDDetailLabelCellStyleIconDetail:
            [self setupAsIconDetail];
            break;
        case KDDetailLabelCellStylePureDetail:
            [self setupAsPureDetail];
            break;
            
        default:
            break;
    }

}

- (void)setupAsDefault {
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(kKDDimensSpacingDefault);
        make.top.equalTo(self.contentView.mas_top).with.offset(kKDDimensSpacingDefault);
        make.width.mas_equalTo(self.preferrenceTitleWidth);
        make.bottom.lessThanOrEqualTo(self.contentView.mas_bottom).with.offset(-kKDDimensSpacingDefault).priorityHigh();
    }];
    [self.titleLbl setPreferredMaxLayoutWidth:self.preferrenceTitleWidth];
    
    [self.detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLbl.mas_top);
        make.left.equalTo(self.contentView.mas_left).with.offset(2*kKDDimensSpacingDefault+self.preferrenceTitleWidth);
        make.right.equalTo(self.contentView.mas_right).with.offset(-kKDDimensSpacingDefault);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-kKDDimensSpacingDefault).priorityLow();
    }];
    [self.detailLbl setPreferredMaxLayoutWidth:(SCREEN_WIDTH-self.preferrenceTitleWidth-3*kKDDimensSpacingDefault)];
}

- (void)setupAsIconDetail {
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.detailLbl.mas_left).multipliedBy(0.5);
        make.top.equalTo(self.contentView.mas_top).with.offset(kKDDimensSpacingDefault);
        make.height.and.width.mas_equalTo(kKDDimensSizeBottomView);
        make.bottom.lessThanOrEqualTo(self.contentView.mas_bottom).with.offset(-kKDDimensSpacingDefault).priorityHigh();
    }];
    
    [self.detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImgView);
        make.left.equalTo(self.contentView.mas_left).with.offset(2*kKDDimensSpacingDefault+self.preferrenceTitleWidth);
        make.right.equalTo(self.contentView.mas_right).with.offset(-kKDDimensSpacingDefault);
        make.bottom.lessThanOrEqualTo(self.contentView.mas_bottom).with.offset(-kKDDimensSpacingDefault).priorityLow();
    }];
    [self.detailLbl setPreferredMaxLayoutWidth:(SCREEN_WIDTH-self.preferrenceTitleWidth-3*kKDDimensSpacingDefault)];
}

- (void)setupAsPureDetail {
    
    [self.detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(kKDDimensSpacingCell);
        make.left.equalTo(self.contentView.mas_left).with.offset(2*kKDDimensSpacingDefault+self.preferrenceTitleWidth);
        make.right.equalTo(self.contentView.mas_right).with.offset(-kKDDimensSpacingDefault);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-kKDDimensSpacingCell).priorityLow();
    }];
    [self.detailLbl setPreferredMaxLayoutWidth:(SCREEN_WIDTH-self.preferrenceTitleWidth-3*kKDDimensSpacingDefault)];
}

#pragma mark - Override Methods
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the View for the selected state
}

#pragma mark - Getter
- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
        
        [_iconImgView setContentMode:UIViewContentModeScaleAspectFill];
        [_iconImgView.layer setMasksToBounds:YES];
        [self.contentView addSubview:_iconImgView];
    }
    
    return _iconImgView;
}

- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        [_titleLbl setNumberOfLines:0];
        
        [self.contentView addSubview:_titleLbl];
    }
    
    return _titleLbl;
}

- (UILabel *)detailLbl {
    if (!_detailLbl) {
        _detailLbl = [[UILabel alloc] init];
        [_detailLbl setNumberOfLines:0];
        
        [self.contentView addSubview:_detailLbl];
    }
    
    return _detailLbl;
}

- (CGFloat)preferrenceTitleWidth {
    if (!_preferrenceTitleWidth||_preferrenceTitleWidth==0) {
        _preferrenceTitleWidth = 90.;
    }
    
    return _preferrenceTitleWidth;
}

#pragma mark - Setter 
- (void)setpreferrenceTitleWidth:(CGFloat)preferrenceTitleWidth {
    _preferrenceTitleWidth = preferrenceTitleWidth;
    
    [self setupConstraints];
}
@end
