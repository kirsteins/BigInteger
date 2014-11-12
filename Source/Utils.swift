//
//  Utils.swift
//  BigInteger
//
//  Created by Jānis Kiršteins on 07/11/14.
//  Copyright (c) 2014 Jānis Kiršteins. All rights reserved.
//

import Foundation

struct Utils {
    static let base36Digits: String = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    static func canParseBigIntegerFromString(var string: String, withRadix radix: Int) -> Bool {
        if string.hasPrefix("-") {
            string.removeAtIndex(string.startIndex)
        }
        
        let stringOfDigits = base36Digits.substringToIndex(advance(base36Digits.startIndex, radix))
        let characterSet = NSCharacterSet(charactersInString: stringOfDigits).invertedSet
        
        return (string.rangeOfCharacterFromSet(characterSet) == nil)
    }
}