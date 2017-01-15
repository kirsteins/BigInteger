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

public class BigInteger : ExpressibleByIntegerLiteral {
    var value = mp_int()
    
    // MARK: - Init / Deinit
    
    init(_ value: mp_int) {
        var value = value
        mp_init_copy(&self.value, &value)
    }
    
    public init() {
        mp_init_set(&self.value, 0)
    }
    
    public init?(_ valueAsString: String, radix: Int = 10) {
        var valueAsString = valueAsString
        assert(radix >= 2 && radix <= 36, "Only radix from 2 to 36 are supported")
        
        valueAsString = valueAsString.uppercased()
        
        if !(Utils.canParseBigIntegerFromString(valueAsString, withRadix: radix)) || valueAsString.isEmpty {
            return nil
        }

        let cString = valueAsString.cString(using: String.Encoding.utf8)!
        mp_read_radix(&self.value, cString, Int32(radix))
    }

    public convenience init(_ int: Int) {
        let bigInteger = BigInteger("\(int)")!
        self.init(bigInteger)
    }
    
    public required convenience init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }
    
    public convenience init(_ bigInteger: BigInteger) {
        self.init(bigInteger.value)
    }

    public required init(coder aDecoder: NSCoder) {

        let alloc = aDecoder.decodeInt32(forKey: Keys.alloc)
        mp_init_size(&self.value, alloc)
        self.value.alloc = alloc
        self.value.used = aDecoder.decodeInt32(forKey: Keys.used)
        self.value.sign = aDecoder.decodeInt32(forKey: Keys.sign)
        let data = aDecoder.decodeObject(forKey: Keys.dp) as! NSData
        
        var buffer = [mp_digit](repeating: 0, count: Int(self.value.alloc))
        data.getBytes(&buffer)

        for i in 0 ..< Int(self.value.alloc) {
            self.value.dp[i] = buffer[i]
        }
    }
    
    public func duplicate() -> BigInteger {
        return BigInteger(self.value)
    }

    deinit {
        mp_clear(&self.value);
    }
    
    // MARK: - Operations
    
    public func add(_ bigInteger: BigInteger) -> BigInteger {
        var sum = BigInteger()
        mp_add(&self.value, &bigInteger.value, &sum.value);

        return sum
    }
    
    public func add(_ primitiveInt: Int) -> BigInteger {
        return add(BigInteger(primitiveInt))
    }
    
    public func subtract(_ bigInteger: BigInteger) -> BigInteger {
        var difference = BigInteger()
        mp_sub(&self.value, &bigInteger.value, &difference.value);
        
        return difference
    }
    
    public func subtract(_ primitiveInt: Int) -> BigInteger {
        return subtract(BigInteger(primitiveInt))
    }
    
    public func multiplyBy(_ bigInteger: BigInteger) -> BigInteger {
        var product = BigInteger()
        mp_mul(&self.value, &bigInteger.value, &product.value);
        
        return product
    }
    
    public func multiplyBy(_ primitiveInt: Int) -> BigInteger {
        return multiplyBy(BigInteger(primitiveInt))
    }
    
    public typealias QuotientAndReminder = (quotient: BigInteger, reminder: BigInteger)
    
    public func divideAndRemainder(_ bigInteger: BigInteger) -> QuotientAndReminder? {
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
    
    public func divideBy(_ bigInteger: BigInteger) -> BigInteger? {
        return divideAndRemainder(bigInteger)?.quotient
    }

    public func divideBy(_ primitiveInt: Int) -> BigInteger? {
        return divideBy(BigInteger(primitiveInt))
    }
    
    public func reminder(_ bigInteger: BigInteger) -> BigInteger? {
        return divideAndRemainder(bigInteger)?.reminder
    }
    
    public func reminder(_ primitiveInt: Int) -> BigInteger? {
        return reminder(BigInteger(primitiveInt))
    }
    
    public func pow(_ exponent: mp_digit) -> BigInteger {
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

    public func exptmod(power: BigInteger, modulus: BigInteger) -> BigInteger {
        var result = BigInteger()
        mp_exptmod(&self.value, &power.value, &modulus.value, &result.value)

        return result
    }
    
    public func bitwiseXor(_ bigInteger: BigInteger) -> BigInteger {
        var xor = BigInteger()
        mp_xor(&self.value, &bigInteger.value, &xor.value);
        
        return xor
    }
    
    public func bitwiseXor(_ primitiveInt: Int) -> BigInteger {
        return bitwiseXor(BigInteger(primitiveInt))
    }
    
    public func bitwiseOr(_ bigInteger: BigInteger) -> BigInteger {
        var or = BigInteger()
        mp_or(&self.value, &bigInteger.value, &or.value);
        
        return or
    }
    
    public func bitwiseOr(_ primitiveInt: Int) -> BigInteger {
        return bitwiseOr(BigInteger(primitiveInt))
    }
    
    public func bitwiseAnd(_ bigInteger: BigInteger) -> BigInteger {
        var and = BigInteger()
        mp_and(&self.value, &bigInteger.value, &and.value);
        
        return and
    }
    
    public func bitwiseAnd(_ primitiveInt: Int) -> BigInteger {
        return bitwiseAnd(BigInteger(primitiveInt))
    }
    
    public func shiftLeft(_ placesToShift: Int32) -> BigInteger {
        var leftShifted = BigInteger()
        mp_mul_2d(&self.value, placesToShift, &leftShifted.value)
        
        return leftShifted
    }
    
    public func shiftRight(_ placesToShift: Int32) -> BigInteger {
        var rightShifted = BigInteger()
        mp_div_2d(&self.value, placesToShift, &rightShifted.value, nil)
        
        return rightShifted
    }
    
    public func gcd(_ bigInteger: BigInteger) -> BigInteger? {
        var gcd = BigInteger()
        let result = mp_gcd(&self.value, &bigInteger.value, &gcd.value)
        
        if result == MP_VAL {
            return nil
        }
        
        return gcd
    }
    
    public func gcd(_ primitiveInt: Int) -> BigInteger? {
        return gcd(BigInteger(primitiveInt))
    }
    
    public func compare(_ bigInteger: BigInteger) -> ComparisonResult {
        let comparisonResult = mp_cmp(&self.value, &bigInteger.value)

        switch comparisonResult {
        case MP_GT:
            return .orderedAscending
        case MP_LT:
            return .orderedDescending
        default:
            return .orderedSame
        }
    }
    
    // MARK: - Output
    
    public var asInt: Int? {
        return (self <= Int.max && self >= Int.min) ? Int(mp_get_int(&self.value)) : nil
    }
    
    public var asString: String {
        return asString(radix: 10)
    }
    
    public func asString(radix: Int) -> String {
        assert(radix >= 2 && radix <= 36, "Only radix from 2 to 36 are supported")
        
        var stringLength = Int32()
        mp_radix_size(&self.value, Int32(radix), &stringLength)
        
        var cString = [Int8](repeating: 0, count: Int(stringLength))
        mp_toradix(&self.value, &cString, Int32(radix))

        return NSString(utf8String: cString) as! String
    }

    public var bytesCount: Int {
        return Int(mp_unsigned_bin_size(&self.value))
    }
    
    public var byteArray: [UInt8] {
        var buffer = [UInt8](repeating: 0, count: bytesCount)
        mp_to_signed_bin(&self.value, &buffer)

        return buffer
    }
}

// MARK: - Printable

extension BigInteger: CustomStringConvertible {
    public var description: String {
        return asString
    }
}

// MARK: - Hashable

extension BigInteger: Hashable {
    public var hashValue: Int {
        return asString.hashValue
    }
}

// MARK: - NSCoding

extension BigInteger: NSCoding {
    public func encode(with aCoder: NSCoder) {
        mp_clamp(&self.value)

        let data = NSData(
            bytes: self.value.dp,
            length: Int(self.value.alloc) * MemoryLayout<mp_digit>.size
        )

        aCoder.encode(data, forKey: Keys.dp)
        aCoder.encode(self.value.alloc, forKey: Keys.alloc)
        aCoder.encode(self.value.used, forKey: Keys.used)
        aCoder.encode(self.value.sign, forKey: Keys.sign)
    }

    struct Keys {
        static let dp = "dp"
        static let alloc = "alloc"
        static let used = "used"
        static let sign = "sign"
    }
}

// MARK: - NSCopying

extension BigInteger: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        return self.duplicate()
    }
}

// MARK: - Comparable, Equatable

extension BigInteger: Comparable, Equatable {}

public func == (lhs: BigInteger, rhs: BigInteger) -> Bool {
    return (lhs.compare(rhs) == .orderedSame)
}

public func <= (lhs: BigInteger, rhs: BigInteger) -> Bool {
    return (lhs.compare(rhs) != .orderedAscending)
}

public func >= (lhs: BigInteger, rhs: BigInteger) -> Bool {
    return (lhs.compare(rhs) != .orderedDescending)
}

public func > (lhs: BigInteger, rhs: BigInteger) -> Bool {
    return (lhs.compare(rhs) == .orderedAscending)
}

public func < (lhs: BigInteger, rhs: BigInteger) -> Bool {
    return (lhs.compare(rhs) == .orderedDescending)
}
