//
//  CellModel.h
//  IntelligenceCommunity
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "UIView+CGRect.h"

@implementation UIView (CGRect)

-(CGFloat)minX {
    return CGRectGetMinX(self.frame);
}

-(CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

-(CGFloat)minY {
    return CGRectGetMinY(self.frame);
}

-(CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}

-(CGFloat)width {
    return CGRectGetWidth(self.frame);
}

-(CGFloat)height {
    return CGRectGetHeight(self.frame);
}

-(CGFloat)midX {
    return CGRectGetMidX(self.frame);
}

-(CGFloat)midY {
    return CGRectGetMidY(self.frame);
}

@end
