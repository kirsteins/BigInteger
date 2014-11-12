//
//  File.swift
//  BigInteger
//
//  Created by Jānis Kiršteins on 16/09/14.
//  Copyright (c) 2014 Jānis Kiršteins. All rights reserved.
//

import LibTomMath

extension mp_int {
    init() {
        self = mp_int(used: 0, alloc: 0, sign: 0, dp: nil)
    }
}

public class BigInteger : NSObject, IntegerLiteralConvertible {
    var value = mp_int()
    
    // MARK: - Init / Deinit
    
    init(var value: mp_int) {
        mp_init_copy(&self.value, &value)
    }
    
    public override init() {
        mp_init_set(&self.value, 0)
    }
    
    public init?(var valueAsString: String, radix: Int) {
        assert(radix >= 2 && radix <= 36, "Only radix from 2 to 36 are supported")
        super.init()
        
        valueAsString = valueAsString.uppercaseString
        
        if !(Utils.canParseBigIntegerFromString(valueAsString, withRadix: radix)) || valueAsString.isEmpty {
            return nil
        }
        
        let cString = valueAsString.cStringUsingEncoding(NSUTF8StringEncoding)!
        mp_read_radix(&self.value, cString, Int32(radix))
    }
    
    public convenience init?(_ valueAsString: String) {
        self.init(valueAsString: valueAsString, radix: 10)
    }
    
    public convenience init(_ int: Int) {
        let bigInteger = BigInteger("\(int)")!
        self.init(bigInteger)
    }
    
    public required convenience init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }
    
    public convenience init(_ bigInteger: BigInteger) {
        self.init(value: bigInteger.value)
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init()
        
        let alloc = aDecoder.decodeInt32ForKey(Keys.alloc)
        mp_init_size(&self.value, alloc)
        self.value.alloc = alloc
        self.value.used = aDecoder.decodeInt32ForKey(Keys.used)
        self.value.sign = aDecoder.decodeInt32ForKey(Keys.sign)
        let data = aDecoder.decodeObjectForKey(Keys.dp) as NSData
        
        var buffer = [mp_digit](count: Int(self.value.alloc), repeatedValue: 0)
        data.getBytes(&buffer)
        
        for var i = 0; i < Int(self.value.alloc); ++i {
            self.value.dp[i] = buffer[i]
        }
    }
    
    public func duplicate() -> BigInteger {
        return BigInteger(value: self.value)
    }
    
    deinit {
        mp_clear(&self.value);
    }
    
    // MARK: - Operations
    
    public func add(bigInteger: BigInteger) -> BigInteger {
        var sum = BigInteger()
        mp_add(&self.value, &bigInteger.value, &sum.value);

        return sum
    }
    
    public func add(primitiveInt: Int) -> BigInteger {
        return add(BigInteger(primitiveInt))
    }
    
    public func subtract(bigInteger: BigInteger) -> BigInteger {
        var difference = BigInteger()
        mp_sub(&self.value, &bigInteger.value, &difference.value);
        
        return difference
    }
    
    public func subtract(primitiveInt: Int) -> BigInteger {
        return subtract(BigInteger(primitiveInt))
    }
    
    public func multiplyBy(bigInteger: BigInteger) -> BigInteger {
        var product = BigInteger()
        mp_mul(&self.value, &bigInteger.value, &product.value);
        
        return product
    }
    
    public func multiplyBy(primitiveInt: Int) -> BigInteger {
        return multiplyBy(BigInteger(primitiveInt))
    }
    
    public typealias QuotientAndReminder = (quotient: BigInteger, reminder: BigInteger)
    
    public func divideAndRemainder(bigInteger: BigInteger) -> QuotientAndReminder? {
        var quotient = BigInteger()
        var remainder = BigInteger()
        
        let result = mp_div(&self.value, &bigInteger.value, &quotient.value, &remainder.value)
        
        if result == MP_VAL {
            return nil
        }

        return (quotient, remainder)
    }
    
    public func divideAndRemainder(primitiveInt: Int) -> QuotientAndReminder? {
        return divideAndRemainder(BigInteger(primitiveInt))
    }
    
    public func divideBy(bigInteger: BigInteger) -> BigInteger? {
        return divideAndRemainder(bigInteger)?.quotient
    }

    public func divideBy(primitiveInt: Int) -> BigInteger? {
        return divideBy(BigInteger(primitiveInt))
    }
    
    public func reminder(bigInteger: BigInteger) -> BigInteger? {
        return divideAndRemainder(bigInteger)?.reminder
    }
    
    public func reminder(primitiveInt: Int) -> BigInteger? {
        return reminder(BigInteger(primitiveInt))
    }
    
    public func pow(exponent: mp_digit) -> BigInteger {
        var power = BigInteger()
        mp_expt_d(&self.value, exponent, &power.value);
        
        return power
    }
    
    public func negate() -> BigInteger {
        var negated = BigInteger()
        mp_neg(&self.value, &negated.value)
        
        return negated
    }
    
    public func abs() -> BigInteger {
        var absolute = BigInteger()
        mp_abs(&self.value, &absolute.value)
        
        return absolute
    }
    
    public func bitwiseXor(bigInteger: BigInteger) -> BigInteger {
        var xor = BigInteger()
        mp_xor(&self.value, &bigInteger.value, &xor.value);
        
        return xor
    }
    
    public func bitwiseXor(primitiveInt: Int) -> BigInteger {
        return bitwiseXor(BigInteger(primitiveInt))
    }
    
    public func bitwiseOr(bigInteger: BigInteger) -> BigInteger {
        var or = BigInteger()
        mp_or(&self.value, &bigInteger.value, &or.value);
        
        return or
    }
    
    public func bitwiseOr(primitiveInt: Int) -> BigInteger {
        return bitwiseOr(BigInteger(primitiveInt))
    }
    
    public func bitwiseAnd(bigInteger: BigInteger) -> BigInteger {
        var and = BigInteger()
        mp_and(&self.value, &bigInteger.value, &and.value);
        
        return and
    }
    
    public func bitwiseAnd(primitiveInt: Int) -> BigInteger {
        return bitwiseAnd(BigInteger(primitiveInt))
    }
    
    public func shiftLeft(placesToShift: Int32) -> BigInteger {
        var leftShifted = BigInteger()
        mp_mul_2d(&self.value, placesToShift, &leftShifted.value)
        
        return leftShifted
    }
    
    public func shiftRight(placesToShift: Int32) -> BigInteger {
        var rightShifted = BigInteger()
        mp_div_2d(&self.value, placesToShift, &rightShifted.value, nil)
        
        return rightShifted
    }
    
    public func gcd(bigInteger: BigInteger) -> BigInteger? {
        var gcd = BigInteger()
        let result = mp_gcd(&self.value, &bigInteger.value, &gcd.value)
        
        if result == MP_VAL {
            return nil
        }
        
        return gcd
    }
    
    public func gcd(primitiveInt: Int) -> BigInteger? {
        return gcd(BigInteger(primitiveInt))
    }
    
    public func compare(bigInteger: BigInteger) -> NSComparisonResult {
        let comparisonResult = mp_cmp(&self.value, &bigInteger.value)
        
        switch comparisonResult {
        case MP_GT:
            return .OrderedAscending
        case MP_LT:
            return .OrderedDescending
        default:
            return .OrderedSame
        }
    }
    
    // MARK: - Output
    
    public var asInt: Int? {
        return (self <= Int.max && self >= Int.min) ? Int(mp_get_int(&self.value)) : nil
    }
    
    public var asString: String {
        return asString(radix: 10)
    }
    
    public func asString(#radix: Int) -> String {
        assert(radix >= 2 && radix <= 36, "Only radix from 2 to 36 are supported")
        
        var stringLength = Int32()
        mp_radix_size(&self.value, Int32(radix), &stringLength)
        
        var cString = [Int8](count: Int(stringLength), repeatedValue: 0)
        mp_toradix(&self.value, &cString, Int32(radix))
        
        return NSString(UTF8String: cString)!
    }
    
    public var bytesCount: Int {
        return Int(mp_unsigned_bin_size(&self.value))
    }
    
    public var byteArray: [Byte] {
        var buffer = [Byte](count: bytesCount, repeatedValue: 0)
        mp_to_signed_bin(&self.value, &buffer)
            
        return buffer
    }
}

// MARK: - Printable

extension BigInteger: Printable {
    public override var description: String {
        return asString
    }
}

// MARK: - Hashable

extension BigInteger: Hashable {
    public override var hashValue: Int {
        return asString.hashValue
    }
}

// MARK: - NSCoding

extension BigInteger: NSCoding {
    struct Keys {
        static let dp = "dp"
        static let alloc = "alloc"
        static let used = "used"
        static let sign = "sign"
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        mp_clamp(&self.value)
        
        let data = NSData(
            bytes: self.value.dp,
            length: Int(self.value.alloc) * sizeof(mp_digit)
        )
        
        aCoder.encodeObject(data, forKey: Keys.dp)
        aCoder.encodeInt32(self.value.alloc, forKey: Keys.alloc)
        aCoder.encodeInt32(self.value.used, forKey: Keys.used)
        aCoder.encodeInt32(self.value.sign, forKey: Keys.sign)
    }
}

// MARK: - NSCopying

extension BigInteger: NSCopying {
    public func copyWithZone(zone: NSZone) -> AnyObject {
        return self.duplicate()
    }
}

// MARK: - Comparable, Equatable

extension BigInteger: Comparable, Equatable {}

public func == (lhs: BigInteger, rhs: BigInteger) -> Bool {
    return (lhs.compare(rhs) == .OrderedSame)
}

public func <= (lhs: BigInteger, rhs: BigInteger) -> Bool {
    return (lhs.compare(rhs) != .OrderedAscending)
}

public func >= (lhs: BigInteger, rhs: BigInteger) -> Bool {
    return (lhs.compare(rhs) != .OrderedDescending)
}

public func > (lhs: BigInteger, rhs: BigInteger) -> Bool {
    return (lhs.compare(rhs) == .OrderedAscending)
}

public func < (lhs: BigInteger, rhs: BigInteger) -> Bool {
    return (lhs.compare(rhs) == .OrderedDescending)
}
