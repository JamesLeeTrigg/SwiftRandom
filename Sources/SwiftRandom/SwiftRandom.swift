//
//  SwiftRandom.swift
//
//  Created by Furkan Yilmaz on 7/10/15.
//  Copyright (c) 2015 Furkan Yilmaz. All rights reserved.
//  Updated by James Trigg on 12/21/2024 under the MIT License
//  Original repository: https://github.com/thellimist/SwiftRandom/

#if canImport(UIKit)
import UIKit
public typealias PlatformColor = UIColor
public typealias PlatformImage = UIImage
#elseif canImport(AppKit)
import AppKit
public typealias PlatformColor = NSColor
public typealias PlatformImage = NSImage
#endif
// each type has its own random

public extension Bool {
    /// SwiftRandom extension
    static func random() -> Bool {
        return Int.random() % 2 == 0
    }
}

public extension Int {
    /// SwiftRandom extension
    static func random(_ lower: Int = 0, _ upper: Int = 100) -> Int {
        return Int.random(in: lower...upper)
    }
}

public extension Int32 {
    /// SwiftRandom extension
    ///
    /// - note: Using `Int` as parameter type as we usually just want to write `Int32.random(13, 37)` and not `Int32.random(Int32(13), Int32(37))`
    static func random(_ lower: Int = 0, _ upper: Int = 100) -> Int32 {
        return Int32.random(in: Int32(lower)...Int32(upper))
    }
}

public extension String {
    /// SwiftRandom extension
    static func random(ofLength length: Int) -> String {
        return random(minimumLength: length, maximumLength: length)
    }
    
    /// SwiftRandom extension
    static func random(minimumLength min: Int, maximumLength max: Int) -> String {
        return random(
            withCharactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789",
            minimumLength: min,
            maximumLength: max
        )
    }
    
    /// SwiftRandom extension
    static func random(withCharactersInString string: String, ofLength length: Int) -> String {
        return random(
            withCharactersInString: string,
            minimumLength: length,
            maximumLength: length
        )
    }
    
    /// SwiftRandom extension
    static func random(withCharactersInString string: String, minimumLength min: Int, maximumLength max: Int) -> String {
        guard min > 0 && max >= min else {
            return ""
        }
        
        let length: Int = (min < max) ? .random(in: min...max) : max
        var randomString = ""
        
        (1...length).forEach { _ in
            let randomIndex: Int = .random(in: 0..<string.count)
            let c = string.index(string.startIndex, offsetBy: randomIndex)
            randomString += String(string[c])
        }
        
        return randomString
    }
}

public extension Double {
    /// SwiftRandom extension
    static func random(_ lower: Double = 0, _ upper: Double = 100) -> Double {
        return Double.random(in: lower...upper)
    }
}

public extension Float {
    /// SwiftRandom extension
    static func random(_ lower: Float = 0, _ upper: Float = 100) -> Float {
        return Float.random(in: lower...upper)
    }
}

public extension CGFloat {
    /// SwiftRandom extension
    static func random(_ lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat.random(in: lower...upper)
    }
}

public extension Date {
    /// SwiftRandom extension
    static func randomWithinDaysBeforeToday(_ days: Int) -> Date {
        let today = Date()
        let earliest = today.addingTimeInterval(TimeInterval(-days*24*60*60))
        
        return Date.random(between: earliest, and: today)
    }

    /// SwiftRandom extension
    static func random() -> Date {
        let randomTime = TimeInterval(arc4random_uniform(UInt32.max))
        return Date(timeIntervalSince1970: randomTime)
    }
    
    static func random(between initial: Date, and final:Date) -> Date {
        let interval = final.timeIntervalSince(initial)
        let randomInterval = TimeInterval(arc4random_uniform(UInt32(interval)))
        return initial.addingTimeInterval(randomInterval)
    }

}

public extension PlatformColor {
    /// Generate a random color
    /// - Parameter randomAlpha: Whether to include random alpha value
    /// - Returns: A random color
    static func random(_ randomAlpha: Bool = false) -> PlatformColor {
        let randomRed = CGFloat.random()
        let randomGreen = CGFloat.random()
        let randomBlue = CGFloat.random()
        let alpha = randomAlpha ? CGFloat.random() : 1.0
        
        #if canImport(UIKit)
        return PlatformColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: alpha)
        #elseif canImport(AppKit)
        let srgb = NSColorSpace.genericRGB
        return PlatformColor(colorSpace: srgb, components: [randomRed, randomGreen, randomBlue, alpha], count: 4)
        #endif
    }
}

public extension URL {
    /// SwiftRandom extension
    static func random() -> URL {
        let urlList = ["http://www.google.com", "http://leagueoflegends.com/", "https://github.com/", "http://stackoverflow.com/", "https://medium.com/", "http://9gag.com/gag/6715049", "http://imgur.com/gallery/s9zoqs9", "https://www.youtube.com/watch?v=uelHwf8o7_U"]
        return URL(string: urlList.randomElement()!)!
    }
}

/// Available styles for Gravatar image generation
public enum GravatarStyle: String {
    case Standard
    case MM
    case Identicon
    case MonsterID
    case Wavatar
    case Retro
    
    public static let allValues = [Standard, MM, Identicon, MonsterID, Wavatar, Retro]
}

/// A collection of methods for generating random values of various types.
public struct Randoms {

    //==========================================================================================================
    // MARK: - Object randoms
    //==========================================================================================================

    /// Generates a random boolean value.
    /// - Returns: A random `Bool` value.
    public static func randomBool() -> Bool {
        return Bool.random()
    }

    /// Generates a random integer within the specified range.
    /// - Parameters:
    ///   - range: The range within which to generate the random number.
    /// - Returns: A random integer within the given range.
    public static func randomInt(_ range: Range<Int>) -> Int {
        return Int.random(in: range)
    }

    /// Generates a random integer between lower and upper bounds (inclusive).
    /// - Parameters:
    ///   - lower: The lower bound of the range (default: 0).
    ///   - upper: The upper bound of the range (default: 100).
    /// - Returns: A random integer between the lower and upper bounds.
    public static func randomInt(_ lower: Int = 0, _ upper: Int = 100) -> Int {
        return Int.random(lower, upper)
    }

    public static func randomInt32(_ range: Range<Int32>) -> Int32 {
        return Int32.random(in: range)
    }

    public static func randomInt32(_ lower: Int = 0, _ upper: Int = 100) -> Int32 {
        return Int32.random(lower, upper)
    }

    /// Generates a random string with the specified length.
    /// - Parameter length: The desired length of the string.
    /// - Returns: A random string containing alphanumeric characters.
    public static func randomString(ofLength length: Int) -> String {
        return String.random(ofLength: length)
    }
    
    /// Generates a random string with a length between the specified minimum and maximum.
    /// - Parameters:
    ///   - min: The minimum length of the string.
    ///   - max: The maximum length of the string.
    /// - Returns: A random string with a length between min and max.
    public static func randomString(minimumLength min: Int, maximumLength max: Int) -> String {
        return String.random(minimumLength: min, maximumLength: max)
    }
    
    public static func randomString(withCharactersInString string: String, ofLength length: Int) -> String {
        return String.random(withCharactersInString: string, ofLength: length)
    }
    
    public static func randomString(withCharactersInString string: String, minimumLength min: Int, maximumLength max: Int) -> String {
        return String.random(withCharactersInString: string, minimumLength: min, maximumLength: max)
    }
    
    /// Checks if a random percentage is over the specified threshold.
    /// - Parameter percentage: The percentage threshold to check against (0-100).
    /// - Returns: `true` if the random value is greater than or equal to the percentage.
    public static func randomPercentageisOver(_ percentage: Int) -> Bool {
        return Int.random() >= percentage
    }

    public static func randomDouble(_ lower: Double = 0, _ upper: Double = 100) -> Double {
        return Double.random(lower, upper)
    }

    public static func randomFloat(_ lower: Float = 0, _ upper: Float = 100) -> Float {
        return Float.random(lower, upper)
    }

    public static func randomCGFloat(_ lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat.random(lower, upper)
    }

    public static func randomDateWithinDaysBeforeToday(_ days: Int) -> Date {
        return Date.randomWithinDaysBeforeToday(days)
    }

    public static func randomDate() -> Date {
        return Date.random()
    }

    public static func randomColor(_ randomAlpha: Bool = false) -> PlatformColor {
        return PlatformColor.random(randomAlpha)
    }

    public static func randomNSURL() -> URL {
        return URL.random()
    }

    //==========================================================================================================
    // MARK: - Fake random data generators
    //==========================================================================================================

    /// Generates a random fake full name.
    /// - Returns: A string containing a randomly generated first and last name.
    public static func randomFakeName() -> String {
        return randomFakeFirstName() + " " + randomFakeLastName()
    }
    
    /// Generates a random fake first name.
    /// - Returns: A string containing a randomly selected first name.
    public static func randomFakeFirstName() -> String {
        let firstNameList = ["Henry", "William", "Geoffrey", "Jim", "Yvonne", "Jamie", "Leticia", "Priscilla", "Sidney", "Nancy", "Edmund", "Bill", "Megan"]
        return firstNameList.randomElement()!
    }
    
    /// Generates a random fake last name.
    /// - Returns: A string containing a randomly selected last name.
    public static func randomFakeLastName() -> String {
        let lastNameList = ["Pearson", "Adams", "Cole", "Francis", "Andrews", "Casey", "Gross", "Lane", "Thomas", "Patrick", "Strickland", "Nicolas", "Freeman"]
        return lastNameList.randomElement()!
    }

    /// Generates a random fake gender.
    /// - Returns: A string containing a randomly selected gender.
    public static func randomFakeGender() -> String {
        return Bool.random() ? "Male" : "Female"
    }

    /// Generates a random fake conversation.
    /// - Returns: A string containing a randomly selected conversation.
    public static func randomFakeConversation() -> String {
        let convoList = ["You embarrassed me this evening.", "You don't think that was just lemonade in your glass, do you?", "Do you ever think we should just stop doing this?", "Why didn't he come and talk to me himself?", "Promise me you'll look after your mother.", "If you get me his phone, I might reconsider.", "I think the room is bugged.", "No! I'm tired of doing what you say.", "For some reason, I'm attracted to you."]
        return convoList.randomElement()!
    }

    /// Generates a random fake title.
    /// - Returns: A string containing a randomly selected title.
    public static func randomFakeTitle() -> String {
        let titleList = ["CEO of Google", "CEO of Facebook", "VP of Marketing @Uber", "Business Developer at IBM", "Jungler @ Fanatic", "B2 Pilot @ USAF", "Student at Stanford", "Student at Harvard", "Mayor of Raccoon City", "CTO @ Umbrella Corporation", "Professor at Pallet Town University"]
        return titleList.randomElement()!
    }

    /// Generates a random fake tag.
    /// - Returns: A string containing a randomly selected tag.
    public static func randomFakeTag() -> String {
        let tagList = ["meta", "forum", "troll", "meme", "question", "important", "like4like", "f4f"]
        return tagList.randomElement()!
    }

    fileprivate static func randomEnglishHonorific() -> String {
        let englishHonorificsList = ["Mr.", "Ms.", "Dr.", "Mrs.", "Mz.", "Mx.", "Prof."]
        return englishHonorificsList.randomElement()!
    }

    /// Generates a random fake name and English honorific.
    /// - Returns: A string containing a randomly generated name and English honorific.
    public static func randomFakeNameAndEnglishHonorific() -> String {
        let englishHonorific = randomEnglishHonorific()
        let name = randomFakeName()
        return englishHonorific + " " + name
    }

    /// Generates a random fake city name.
    /// - Returns: A string containing a randomly generated city name.
    public static func randomFakeCity() -> String {
        let cityPrefixes = ["North", "East", "West", "South", "New", "Lake", "Port"]
        let citySuffixes = ["town", "ton", "land", "ville", "berg", "burgh", "borough", "bury", "view", "port", "mouth", "stad", "furt", "chester", "mouth", "fort", "haven", "side", "shire"]
        return cityPrefixes.randomElement()! + citySuffixes.randomElement()!
    }

    /// Generates a random currency.
    /// - Returns: A string containing a randomly selected currency.
    public static func randomCurrency() -> String {
        let currencyList = ["USD", "EUR", "GBP", "JPY", "AUD", "CAD", "ZAR", "NZD", "INR", "BRP", "CNY", "EGP", "KRW", "MXN", "SAR", "SGD",]

        return currencyList.randomElement()!
    }

    /// Creates a Gravatar with specified style and size
    /// - Parameters:
    ///   - style: The style of Gravatar to create
    ///   - size: The size in pixels
    ///   - completion: Callback with the created image or error
    public static func createGravatar(style: GravatarStyle = .Standard, 
                                    size: Int = 80, 
                                    completion: @escaping ((_ image: PlatformImage?, _ error: Error?) -> Void)) {
        var url = "https://secure.gravatar.com/avatar/thisimagewillnotbefound?s=\(size)"
        if style != .Standard {
            url += "&d=\(style.rawValue.lowercased())"
        }
        
        guard let requestURL = URL(string: url) else {
            completion(nil, NSError(domain: "SwiftRandom", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        let request = URLRequest(url: requestURL, 
                               cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, 
                               timeoutInterval: 5.0)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    #if canImport(UIKit)
                    if let image = PlatformImage(data: data) {
                        // Resize image to requested size
                        let format = UIGraphicsImageRendererFormat()
                        format.scale = 1.0
                        let renderer = UIGraphicsImageRenderer(size: CGSize(width: size, height: size), format: format)
                        let resizedImage = renderer.image { _ in
                            image.draw(in: CGRect(x: 0, y: 0, width: size, height: size))
                        }
                        completion(resizedImage, nil)
                    } else {
                        completion(nil, error)
                    }
                    #elseif canImport(AppKit)
                    if let image = PlatformImage(data: data) {
                        // Resize image to requested size
                        let resizedImage = NSImage(size: NSSize(width: size, height: size))
                        resizedImage.lockFocus()
                        image.draw(in: NSRect(x: 0, y: 0, width: size, height: size))
                        resizedImage.unlockFocus()
                        completion(resizedImage, nil)
                    } else {
                        completion(nil, error)
                    }
                    #endif
                } else {
                    completion(nil, error)
                }
            }
        }.resume()
    }
    
    /// Creates a random Gravatar
    /// - Parameters:
    ///   - size: The size in pixels
    ///   - completion: Callback with the created image or error
    public static func randomGravatar(_ size: Int = 80, 
                                    completion: @escaping ((_ image: PlatformImage?, _ error: Error?) -> Void)) {
        let options = GravatarStyle.allValues
        createGravatar(style: options.randomElement()!, size: size, completion: completion)
    }
}
