//
//  String+RegExp.swift
//  demo
//
//  Created by eiji kushida on 2019/11/08.
//  Copyright © 2019 Smart Tech Ventures Inc. All rights reserved.
//

import Foundation

extension String {
    
    func isNumeric() -> Bool{
        return (self =~ "(^$)|(^\\d*$)")
    }
    
    func isNumeric(length: Int) -> Bool {
        return (self =~ "(^$)|(^\\d{\(length)}$)")
    }
    
    func isUrl() -> Bool {
        return (self =~ "^(https?|ftp)(:\\/\\/[-_.!~*\\'()a-zA-Z0-9;\\/?:\\@&=+\\$,%#]+)$")
    }
    
    func isEmail() -> Bool {
        return (self =~ "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$")
    }
    
    func isTelephone() -> Bool {
        return (self =~ "^\\d{2,4}-\\d{1,4}-\\d{4}$")
    }
    
    func isdate(format: String) -> Bool {
        return (self =~ "^\\d{4}\(format)\\d{1,2}\(format)\\d{1,2}$")
    }
    
    func isTime() -> Bool {
        return (self =~ "^\\d{1,2}:\\d{1,2}:\\d{1,2}$")
    }
}
