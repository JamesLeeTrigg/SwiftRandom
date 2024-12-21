//
//  SwiftRandomTests.swift
//  SwiftRandomTests
//
//  Created by Rafael Ferreira on 10/3/16.
//
//

import XCTest
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif
@testable import SwiftRandom

/// Tests above `SwiftRandom` module.
class SwiftRandomTests: XCTestCase {
    /// Tests if all static methods are working.
    func testStaticMethods() {
        XCTAssertNotNil(Randoms.randomInt(10, 20))
        XCTAssertNotNil(Randoms.randomCGFloat())
        XCTAssertNotNil(Randoms.randomPercentageisOver(70))
        XCTAssertNotNil(Randoms.randomBool())
        XCTAssertNotNil(Randoms.randomDateWithinDaysBeforeToday(5))
        XCTAssertNotNil(Randoms.randomDate())
#if !os(macOS)
        XCTAssertNotNil(Randoms.randomColor())
#endif
        XCTAssertNotNil(Randoms.randomFakeName())
        XCTAssertNotNil(Randoms.randomFakeFirstName())
        XCTAssertNotNil(Randoms.randomFakeLastName())
        XCTAssertNotNil(Randoms.randomFakeGender())
        XCTAssertNotNil(Randoms.randomFakeConversation())
        XCTAssertNotNil(Randoms.randomFakeTitle())
        XCTAssertNotNil(Randoms.randomFakeTag())
        XCTAssertNotNil(Randoms.randomFakeNameAndEnglishHonorific())
        XCTAssertNotNil(Randoms.randomNSURL())
    }

    /// Tests for extensions applied directly above Swift types.
    func testTypeExtensions() {
        XCTAssertNotNil(Int.random())
        XCTAssertNotNil(Date.random())
        XCTAssertNotNil(Date.randomWithinDaysBeforeToday(7))
        XCTAssertNotNil(CGFloat.random())
        XCTAssertNotNil(Float.random())
        XCTAssertNotNil(Double.random())
#if !os(macOS)
        XCTAssertNotNil(UIColor.random())
#endif
        XCTAssertNotNil(URL.random())
    }

    /// Tests for SwiftRandom when applied above a list.
    func testListItemRandom() {
        let entry = ["hello", "world"]

        for _ in 0...10 {
            XCTAssertNotNil(entry[0..<entry.count].randomElement())
            XCTAssertNotNil(entry.randomElement())
        }
    }

    /// Tests using SwiftRandom above a `Range` of Int.
    func testRandomIntRange() {
        for _ in 0...10 {
            let randomUntilTen = Int.random(in: 0...10)

            XCTAssertGreaterThanOrEqual(randomUntilTen, 0)
            XCTAssertLessThanOrEqual(randomUntilTen, 10)

            let randomLessTen = Int.random(in: 0..<10)

            XCTAssertGreaterThanOrEqual(randomLessTen, 0)
            XCTAssertLessThan(randomLessTen, 10)
        }
    }
    
    /// Tests generating random a `String` of a specified length.
    func testRandomStringOfLength() {
        let precision = 100
        let length = 128
        
        var all: [String] = []
        
        (1...precision).forEach { _ in
            let random: String = .random(ofLength: length)
            XCTAssertEqual(random.count, length)
            
            if all.contains(random) {
                // this is very unlikely to happen with precisions of 100 or over and lengths of 128 or over.
                // if this happens, it is likely a bug in the random string generator.
                XCTFail("Random string collision")
            }
            all.append(random)
        }
        
        XCTAssertEqual(String.random(ofLength: -1), "")
        XCTAssertEqual(String.random(ofLength: 0), "")
    }
    
    /// Tests generating a random `String` of variable length.
    func testRandomStringOfVariableLength() {
        let precision = 100
        let minimumLength = 128
        let maximumLength = 256
        
        var all: [String] = []
        
        (1...precision).forEach { _ in
            let random: String = .random(minimumLength: minimumLength, maximumLength: maximumLength)
            XCTAssertLessThanOrEqual(random.count, maximumLength)
            XCTAssertGreaterThanOrEqual(random.count, minimumLength)
            
            if all.contains(random) {
                // this is very unlikely to happen with precisions of 100 or over and lengths of 128 or over.
                // if this happens, it is likely a bug in the random string generator.
                XCTFail("Random string collision")
            }
            all.append(random)
        }
        
        XCTAssertEqual(String.random(minimumLength: -1, maximumLength: -2), "")
        XCTAssertEqual(String.random(minimumLength: 1, maximumLength: -2), "")
        XCTAssertEqual(String.random(minimumLength: -1, maximumLength: 2), "")
        XCTAssertEqual(String.random(minimumLength: 0, maximumLength: 0), "")
        XCTAssertEqual(String.random(minimumLength: -1, maximumLength: 0), "")
        XCTAssertEqual(String.random(minimumLength: 0, maximumLength: -2), "")
        XCTAssertEqual(String.random(minimumLength: 10, maximumLength: 5), "")
        
        XCTAssertEqual(String.random(minimumLength: 5, maximumLength: 5).count, 5)
    }
    
    /// Tests generating a string with a character set specified
    func testRandomStringWithPossibleCharacters() {
        let precision = 100
        let length = 3
        let allowedCharacters = "ab"
        
        (1...precision).forEach { _ in
            let random: String = .random(withCharactersInString: "ab", ofLength: length)
            for c in random {
                XCTAssertTrue(allowedCharacters.contains(c))
            }
        }
    }

    /// Tests using async way to get a random gravatar.
    func testRandomGravatar_async() {
        let async = expectation(description: "Randoms.randomGravatar")

        Randoms.randomGravatar { (image, error) in
            XCTAssertNotNil(image)
            XCTAssertNil(error)

            async.fulfill()
        }

        waitForExpectations(timeout: 3.5, handler: nil)
    }

    /// Tests using async way to get an random gravatar with a specific size.
    func testRandomGravatarSize() {
        let async = expectation(description: "Randoms.randomGravatarSize")

        Randoms.randomGravatar(40) { (image, error) in
            XCTAssertNotNil(image)
            XCTAssertEqual(image?.size, CGSize(width: 40, height: 40))
            XCTAssertNil(error)

            async.fulfill()
        }

        waitForExpectations(timeout: 3.5, handler: nil)
    }

    /// Tests using async way to create a gravatar.
    func testRandomCreateGravatar() {
        let async = expectation(description: "Randoms.randomCreateGravatar")

        Randoms.createGravatar { (image, error) in
            XCTAssertNotNil(image)
            XCTAssertNil(error)

            async.fulfill()
        }

        waitForExpectations(timeout: 3.5, handler: nil)
    }

    /// Tests using async way to create a gravatar based at Style and Size.
    func testRandomCreateGravatarStyleSize() {
        let async = expectation(description: "Randoms.randomGravatarStyleSize")

        Randoms.createGravatar(style: .Retro, size: 40) { (image, error) in
            XCTAssertNotNil(image)
            XCTAssertEqual(image?.size, CGSize(width: 40, height: 40))
            XCTAssertNil(error)

            async.fulfill()
        }

        waitForExpectations(timeout: 3.5, handler: nil)
    }

    /// Tests for generating random dates
    func testRandomDates() {
        
        // Ensure that a date in the future will not be generated if the user selects a zero number of days.
        let date = Date.randomWithinDaysBeforeToday(0)
        let now = Date()
        let fiveDaysAgo = now.addingTimeInterval(-5*24*60*60)
        
        XCTAssertTrue(date <= now)
        
        
        // Generate lots of random date between two specified dates and ensure they all will be inside the desired interval
        
        var lastDate = Date()
        for _ in 0...1000 {
            let randomDate = Date.random(between: fiveDaysAgo, and: now)
            XCTAssertLessThanOrEqual(randomDate, now)
            XCTAssertGreaterThanOrEqual(randomDate, fiveDaysAgo)
            
            // Ensure the generated dates are different
            XCTAssertNotEqual(randomDate, lastDate)
            lastDate = randomDate
        }
        
        lastDate = Date()
        for _ in 0...1000 {
            let randomDate = Date.randomWithinDaysBeforeToday(5)
            XCTAssertLessThanOrEqual(randomDate, now)
            XCTAssertGreaterThanOrEqual(randomDate, fiveDaysAgo)
            
            // Ensure the generated dates are different
            XCTAssertNotEqual(randomDate, lastDate)
            lastDate = randomDate
        }
        
        lastDate = Date()
        for _ in 0...1000 {
            let randomDate = Date.random()
            // Ensure the generated dates are different
            XCTAssertNotEqual(randomDate, lastDate)
            lastDate = randomDate
        }
    }

    func testRandomColor() {
        let color = PlatformColor.random()
        XCTAssertNotNil(color)
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        #if canImport(UIKit)
        let success = color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertTrue(success)
        #elseif canImport(AppKit)
        let colorSpace = NSColorSpace.sRGB
        
        guard let rgbColor = color.usingColorSpace(colorSpace) else {
            XCTFail("Could not convert to sRGB color space")
            return
        }
        rgbColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        #endif
        
        XCTAssertGreaterThanOrEqual(red, 0)
        XCTAssertLessThanOrEqual(red, 1)
        XCTAssertGreaterThanOrEqual(green, 0)
        XCTAssertLessThanOrEqual(green, 1)
        XCTAssertGreaterThanOrEqual(blue, 0)
        XCTAssertLessThanOrEqual(blue, 1)
        XCTAssertEqual(alpha, 1.0)
    }
    
    func testRandomColorWithAlpha() {
        let color = PlatformColor.random(true)
        XCTAssertNotNil(color)
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        #if canImport(UIKit)
        let success = color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertTrue(success)
        #elseif canImport(AppKit)
        guard let rgbColor = color.usingColorSpace(.sRGB) else {
            XCTFail("Could not convert to RGB color space")
            return
        }
        rgbColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        #endif
        
        XCTAssertGreaterThanOrEqual(alpha, 0)
        XCTAssertLessThanOrEqual(alpha, 1)
    }
    
    func testGravatarCreation() {
        let expectation = self.expectation(description: "Gravatar creation")
        
        Randoms.createGravatar { (image, error) in
            XCTAssertNotNil(image)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testRandomGravatar() {
        let expectation = self.expectation(description: "Random Gravatar")
        
        Randoms.randomGravatar { (image, error) in
            XCTAssertNotNil(image)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGravatarWithSize() {
        let expectation = self.expectation(description: "Gravatar with size")
        let size = 40
        
        Randoms.createGravatar(size: size) { (image, error) in
            XCTAssertNotNil(image)
            #if canImport(UIKit)
            XCTAssertEqual(image?.size.width, CGFloat(size))
            XCTAssertEqual(image?.size.height, CGFloat(size))
            #elseif canImport(AppKit)
            guard let imageSize = image?.size else {
                XCTFail("Could not get image size")
                return
            }
            XCTAssertEqual(imageSize.width, CGFloat(size), accuracy: 0.1)
            XCTAssertEqual(imageSize.height, CGFloat(size), accuracy: 0.1)
            #endif
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
