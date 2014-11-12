//
//  Operators.swift
//  BigInteger
//
//  Created by Jānis Kiršteins on 17/09/14.
//  Copyright (c) 2014 Jānis Kiršteins. All rights reserved.
//

// MARK: - comparison

public func == (lhs: Int, rhs: BigInteger) -> Bool {
    return BigInteger(lhs) == rhs
}

public func == (lhs: BigInteger, rhs: Int) -> Bool {
    return lhs == BigInteger(rhs)
}

public func >= (lhs: Int, rhs: BigInteger) -> Bool {
    return BigInteger(lhs) >= rhs
}

public func >= (lhs: BigInteger, rhs: Int) -> Bool {
    return lhs >= BigInteger(rhs)
}

public func <= (lhs: Int, rhs: BigInteger) -> Bool {
    return BigInteger(lhs) <= rhs
}

public func <= (lhs: BigInteger, rhs: Int) -> Bool {
    return lhs <= BigInteger(rhs)
}

public func > (lhs: Int, rhs: BigInteger) -> Bool {
    return BigInteger(lhs) > rhs
}

public func > (lhs: BigInteger, rhs: Int) -> Bool {
    return lhs > BigInteger(rhs)
}

public func < (lhs: Int, rhs: BigInteger) -> Bool {
    return BigInteger(lhs) < rhs
}

public func < (lhs: BigInteger, rhs: Int) -> Bool {
    return lhs < BigInteger(rhs)
}

// MARK: - add

public func + (lhs: BigInteger, rhs: BigInteger) -> BigInteger {
    return lhs.add(rhs)
}

public func + (lhs: BigInteger, rhs: Int) -> BigInteger {
    return lhs.add(rhs)
}

public func + (lhs: Int, rhs: BigInteger) -> BigInteger {
    return rhs.add(lhs)
}

public func += (inout lhs: BigInteger, rhs: BigInteger) {
    lhs = lhs.add(rhs)
}

public func += (inout lhs: BigInteger, rhs: Int) {
    lhs = lhs.add(rhs)
}

// MARK: - subtract

public func - (lhs: BigInteger, rhs: BigInteger) -> BigInteger {
    return lhs.subtract(rhs)
}

public func - (lhs: BigInteger, rhs: Int) -> BigInteger {
    return lhs.subtract(rhs)
}

public func - (lhs: Int, rhs: BigInteger) -> BigInteger {
    return rhs.negate().add(lhs)
}

public func -= (inout lhs: BigInteger, rhs: BigInteger) {
    lhs = lhs.subtract(rhs)
}

public func -= (inout lhs: BigInteger, rhs: Int) {
    lhs = lhs.subtract(rhs)
}

// MARK: - multiply

public func * (lhs: BigInteger, rhs: BigInteger) -> BigInteger {
    return lhs.multiplyBy(rhs)
}

public func * (lhs: BigInteger, rhs: Int) -> BigInteger {
    return lhs.multiplyBy(rhs)
}

public func * (lhs: Int, rhs: BigInteger) -> BigInteger {
    return rhs.multiplyBy(lhs)
}

public func *= (inout lhs: BigInteger, rhs: BigInteger) {
    lhs = lhs.multiplyBy(rhs)
}

public func *= (inout lhs: BigInteger, rhs: Int) {
    lhs = lhs.multiplyBy(rhs)
}

// MARK: - divide

public func / (lhs: BigInteger, rhs: BigInteger) -> BigInteger? {
    return lhs.divideBy(rhs)
}

public func / (lhs: BigInteger, rhs: Int) -> BigInteger? {
    return lhs.divideBy(rhs)
}

// MARK: - reminder

public func % (lhs: BigInteger, rhs: BigInteger) -> BigInteger? {
    return lhs.reminder(rhs)
}

public func % (lhs: BigInteger, rhs: Int) -> BigInteger? {
    return lhs.reminder(rhs)
}

// MARK: - negate

public prefix func - (operand: BigInteger) -> BigInteger {
    return  operand.negate()
}

// MARK: - xor

public func ^ (lhs: BigInteger, rhs: BigInteger) -> BigInteger {
    return lhs.bitwiseXor(rhs)
}

public func ^ (lhs: BigInteger, rhs: Int) -> BigInteger {
    return lhs.bitwiseXor(rhs)
}

public func ^ (lhs: Int, rhs: BigInteger) -> BigInteger {
    return rhs.bitwiseXor(lhs)
}

public func ^= (inout lhs: BigInteger, rhs: BigInteger) {
    lhs = lhs.bitwiseXor(rhs)
}

public func ^= (inout lhs: BigInteger, rhs: Int) {
    lhs = lhs.bitwiseXor(rhs)
}

// MARK: - or

public func | (lhs: BigInteger, rhs: BigInteger) -> BigInteger {
    return lhs.bitwiseOr(rhs)
}

public func | (lhs: BigInteger, rhs: Int) -> BigInteger {
    return lhs.bitwiseOr(rhs)
}

public func | (lhs: Int, rhs: BigInteger) -> BigInteger {
    return rhs.bitwiseOr(lhs)
}

public func |= (inout lhs: BigInteger, rhs: BigInteger) {
    lhs = lhs.bitwiseOr(rhs)
}

public func |= (inout lhs: BigInteger, rhs: Int) {
    lhs = lhs.bitwiseOr(rhs)
}

// MARK: - and

public func & (lhs: BigInteger, rhs: BigInteger) -> BigInteger {
    return lhs.bitwiseAnd(rhs)
}

public func & (lhs: BigInteger, rhs: Int) -> BigInteger {
    return lhs.bitwiseAnd(rhs)
}

public func & (lhs: Int, rhs: BigInteger) -> BigInteger {
    return rhs.bitwiseAnd(lhs)
}

public func &= (inout lhs: BigInteger, rhs: BigInteger) {
    lhs = lhs.bitwiseAnd(rhs)
}

public func &= (inout lhs: BigInteger, rhs: Int) {
    lhs = lhs.bitwiseAnd(rhs)
}

// MARK: - shiftLeft

public func << (lhs: BigInteger, rhs: Int32) -> BigInteger {
    return lhs.shiftLeft(rhs)
}

public func <<= (inout lhs: BigInteger, rhs: Int32) {
    lhs = lhs.shiftLeft(rhs)
}

// MARK: - shiftRight

public func >> (lhs: BigInteger, rhs: Int32) -> BigInteger {
    return lhs.shiftRight(rhs)
}

public func >>= (inout lhs: BigInteger, rhs: Int32) {
    lhs = lhs.shiftRight(rhs)
}
