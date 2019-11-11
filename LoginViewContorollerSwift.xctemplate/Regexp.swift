//
//  Regexp.swift
//  demo
//
//  Created by eiji kushida on 2019/11/08.
//  Copyright © 2019 Smart Tech Ventures Inc. All rights reserved.
//

import UIKit

infix operator =~
infix operator !~

// 正規表現用のラッパー
func =~(lhs: String, rhs: String) -> Bool {
    guard let regex = try? NSRegularExpression(pattern: rhs,
                                               options: NSRegularExpression.Options()) else {
                                                return false
    }
    
    return regex.numberOfMatches(in: lhs,
                                 options: NSRegularExpression.MatchingOptions(),
                                 range: NSRange(location: 0, length: lhs.count)) > 0
}

func !~(lhs: String, rhs: String) -> Bool {
    return !(lhs=~rhs)
}
