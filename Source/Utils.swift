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
    static func canParseBigIntegerFromString(_ string: String, withRadix radix: Int) -> Bool {
        var string = string
        if string.hasPrefix("-") {
            string.remove(at: string.startIndex)
        }

        let index = base36Digits.index(base36Digits.startIndex, offsetBy: radix)
        let stringOfDigits = base36Digits.substring(to: index)

        let characterSet = NSCharacterSet(charactersIn: stringOfDigits).inverted

        return (string.rangeOfCharacter(from: characterSet) == nil)
    }
}
