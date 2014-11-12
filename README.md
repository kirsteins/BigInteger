# BigInteger.swift
BigInteger.swift is a lightweight library that facilitates an easy way to work with big integers in Swift. Built on top of LibTomMath C library. Inspired by the Java's BigInteger, but a lot of syntatic sugar added.
## Example

``` swift
import BigInteger

var a = BigInteger("111111111111111111111111111111111111111111111110000000001")!
var b = 999_999_999
var c = a + b // 111111111111111111111111111111111111111111111111000000000

c -= BigInteger("11111111111111111111111111111111111111111111111000000000")!
// 100000000000000000000000000000000000000000000000000000000

c = (c / 1000000000000000000)!
// 10000000000000000000000000000000000000000000000000

c = BigInteger(2).pow(120) // 1329227995784915872903807060280344576

c >>= 116 // 16

c = BigInteger(1) << 120 // 1329227995784915872903807060280344576

c = (c % 1000)! // 576

let result = c.divideAndRemainder(50)
result!.quotient // 11
result!.reminder // 26
```

## Features

 - Addition, subraction, multiplication, division and reminder
 - Bitwise and, or, xor, shift left, shift right
 - Negate, abs, gcd
 - Comparisions

## Requirements

 - iOS 7.0+ / Mac OS X 10.9+
 - Xcode 6.1

## Installation

The same you install any popular Swift framework, for example, [Alamofire](https://github.com/Alamofire/Alamofire#installation), [SQLite.swift](https://github.com/stephencelis/SQLite.swift#installation).

## Author

 - [Jānis Kiršteins](mailto:janis.kirsteins@gmail.com)
   ([@janiskirsteins](https://twitter.com/janiskirsteins))