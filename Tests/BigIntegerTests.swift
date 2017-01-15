//
//  BigIntegerTests.swift
//  BigIntegerTests
//
//  Created by Jānis Kiršteins on 12/11/14.
//  Copyright (c) 2014 Jānis Kiršteins. All rights reserved.
//

//import Foundaution
import XCTest
import BigInteger

class BigIntegerTests: XCTestCase {
    func testParse() {
        print(BigInteger("123456789")!)
        print(BigInteger(123456789))
        
        XCTAssert(BigInteger("123456789")! == BigInteger(123456789))
        
        var int1 = BigInteger("FFFFFFFFFFFFFFFFFFFF", radix: 16)
        var int2 = BigInteger("11111111111111111111111111111111111111111111111111111111111111111111111111111111", radix: 2)
        XCTAssert(int1 == int2)
        
        XCTAssertNil(BigInteger("--143524"))
        XCTAssertNil(BigInteger("13241234asdfa"))
        XCTAssertNil(BigInteger(" 123"))
        XCTAssertNil(BigInteger("123 "))
        
        XCTAssert(BigInteger("-012313212")! == -012313212)
    }
    
    func testCompare() {
        XCTAssert(BigInteger("1234567891999999999999999999999999")! > BigInteger("1234567890999999999999999999999999")!)
        XCTAssert(BigInteger("1234567891999999999999999999999999")! >= BigInteger("1234567890999999999999999999999999")!)
    }
    
    func testAdd() {
        var int1 = BigInteger(123_456_78)
        var int2 = BigInteger(987_654_321)
        var int3 = BigInteger(999_999_999)
        
        XCTAssert(int1 + int2 == int3)
    }
    
    func testSubtract() {
        var int1 = BigInteger("33333333333333333333333333333333333333333333333")!
        var int2 = BigInteger("22222222222222222222222222222222222222222222222")!
        var int3 = BigInteger("11111111111111111111111111111111111111111111111")!
        
        XCTAssert(int1 - int2 == int3)
        
        int1 = BigInteger("19b880f625283f859509e0e0f8fb3ac655", radix: 16)!
        int2 = BigInteger("10832cc998a0cefaea5d2971aa3456b685c3dbf036ed6105a3a2763a06a02ed8195dedac77cfab0f77", radix: 16)!
        int3 = BigInteger("-10832cc998a0cefaea5d2971aa3456b685c3dbf036ed610589e9f543e177ef5284540ccb7ed4704922", radix: 16)!
        
        XCTAssert(int1 - int2 == int3)
    }
    
    func testMultiply() {
        var int1 = BigInteger("163277057711765636560747447031217015017170155667415437655316770777137", radix: 8)!
        var int2 = BigInteger("7237215676720565020372546341703475553736747716372011567267761457600467467522634067670020467677527433525", radix: 8)!
        var int3 = BigInteger("1513401757356351454234764232211641316736616642643211617703006736112752224764721721321731200254174752010533741212752401377330537217165256452340012502354275047547302416757213", radix: 8)!
        
        XCTAssert(int1 * int2 == int3)
    }
    
    func testDivide() {
        var int1 = BigInteger("1169097538532642372543607603514791403717291975000833721275916403624187265104706488559072")!
        var int2 = BigInteger("4032096298070895587819281883039293999262897622184228626772182")!
        var int3 = BigInteger("289947821705543589000580152")!
        
        XCTAssert((int1 / int2)! == int3)
    }
    
    func testReminder() {
        var int1 = BigInteger("11ff84a0f3ef22b03e755bf7c119a69cb03aa09d13257bbb803ec8bb97ab1b09918fd21caccc226f4", radix: 16)!
        var int2 = BigInteger("121774a4a1", radix: 16)!
        var int3 = BigInteger("468b8fdbd", radix: 16)!
        
        XCTAssert((int1 % int2)! == int3)
    }
    
    func testPower() {
        var int1 = BigInteger("352064660", radix: 8)!
        var int2 = BigInteger("11445440503765037264345614414201317562305075366370315205160001743510253761621003506311727224756206163364574662673072724535122730763362312735042210663525222433233235631510321502655772565647576737044053522616402745400000000000000000000000000000000000000", radix: 8)!
        
        XCTAssert(int1.pow(29) == int2)
    }
    
    func testNegate() {
        var int1 = BigInteger("1234112389471982374123470172341324013217238471238947189375182937518923", radix: 10)!
        var int2 = BigInteger("-1234112389471982374123470172341324013217238471238947189375182937518923", radix: 10)!
        
        XCTAssert(-int1 == int2)
    }
    
    func testXor() {
        var int1 = BigInteger("88fd2e", radix: 16)!
        var int2 = BigInteger("7f761ae982e3b55fe8", radix: 16)!
        var int3 = BigInteger("7f761ae982e33da2c6", radix: 16)!
        
        XCTAssert((int1 ^ int2) == int3)
    }
    
    func testOr() {
        var int1 = BigInteger("65634cc946ef5841549c020fa92f64", radix: 16)!
        var int2 = BigInteger("5dfa79fc90760ce1c50970b2ac6d23bd004df92040f72c8bebec", radix: 16)!
        var int3 = BigInteger("5dfa79fc90760ce1c50970f7ef6debffef5df974dcf72fabefec", radix: 16)!
        
        XCTAssert((int1 | int2) == int3)
    }
    
    func testAnd() {
        var int1 = BigInteger("13cb8fad8b3623ce10ee5b27ec7d77c03963109c872846", radix: 16)!
        var int2 = BigInteger("11d40ad4a69abd11e229e0e8b4fa71eb33db3", radix: 16)!
        var int3 = BigInteger("114008c00680b010c2016000943001c832802", radix: 16)!
        
        XCTAssert((int1 & int2) == int3)
    }
    
    func testShiftLeft() {
        var int1 = BigInteger("8de59c88e581df0860ab", radix: 16)!
        var int2 = BigInteger("8de59c88e581df0860ab000000000000000000000", radix: 16)!
        
        XCTAssert((int1 << 84) == int2)
    }
    
    func testShiftRight() {
        var int1 = BigInteger("3e0af7b136ad56a06a10f45bf", radix: 16)!
        var int2 = BigInteger("7c15ef626d5aad40d421", radix: 16)!

        XCTAssert((int1 >> 19) == int2)
    }
    
    func testGCD() {
        var int1 = BigInteger("18f253d71e5309209bbaa2e9012ce7d", radix: 16)!
        var int2 = BigInteger("1bbdc63eb4dbb8cdea4eead7316f4e62ab8b85be4ae4832119a8f", radix: 16)!
        var int3 = BigInteger("11", radix: 16)!
        
        XCTAssert(int1.gcd(int2) == int3)
    }
    
    func testAbs() {
        var int1 = BigInteger("-1bbdc63eb4dbb8cdea4eead7316f4e62ab8b85be4ae4832119a8ffdfdfdf", radix: 16)!
        var int2 = BigInteger("1bbdc63eb4dbb8cdea4eead7316f4e62ab8b85be4ae4832119a8ffdfdfdf", radix: 16)!
        
        XCTAssert(int1.abs() == int2)
        XCTAssert(int2.abs() == int2)
    }

    func testExptmod() {
        let int1 = BigInteger("-3")!
        let power = BigInteger("3")!
        let modulus = BigInteger("2")!
        let int2 = BigInteger("1")!

        print("bytes: \(int1.byteArray)")
        XCTAssert(int1.exptmod(power: power, modulus: modulus) == int2)
    }
}
