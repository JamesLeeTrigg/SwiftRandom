# SwiftRandom

SwiftRandom is a lightweight Swift library that makes generating random data easy and fun! Perfect for testing, mockups, or adding variety to your apps.

This is a fork of [SwiftRandom](https://github.com/thellimist/SwiftRandom/) by Furkan Yilmaz, updated and maintained by James Trigg.

## Changes from original
- Added better platform support (iOS, macOS, tvOS)
- Improved documentation
- Platform-specific conditional compilation
- More modern Swift syntax and conventions

## Features

- Generate random numbers (Int, Double, Float, CGFloat)
- Create random strings with custom lengths and character sets
- Get random dates within specified ranges
- Generate random colors (UIColor)
- Create random URLs
- Generate fake data like names, cities, conversations, and more
- Create random Gravatar images
- Supports iOS 14+, macOS 10.14+, and tvOS 14+


## Usage

```swift
// Numbers
Int.random(2, 77) // Random between 2-77
Int32.random(13, 37) // Random between 13-37
Double.random() // Random double between 0-100
Float.random(3.2, 4.5) // Random between 3.2-4.5
CGFloat.random() // Random between 0-1
// Dates
Date.random() // Random date
Date.randomWithinDaysBeforeToday(7) // Random date within last week
Date.random(between: Date().addingTimeInterval(-432000), and: Date()) // Random date between now and 5 days ago
// Colors
PlatformColor.random() // Random color
URL.random() // Random URL
// Strings
String.random(ofLength: 16) // 16-character random string
String.random(minimumLength: 16, maximumLength: 32) // Variable length
String.random(withCharactersInString: "abc", ofLength: 16) // Custom character set
```
### As Methods
```swift
// Basic Types
Randoms.randomInt(10, 20) // Int between 10-20
Randoms.randomDouble(10, 20) // Double between 10-20
Randoms.randomBool() // Random boolean
Randoms.randomPercentageisOver(70) // Returns true 30% of the time
// Strings
Randoms.randomString(ofLength: 16)
Randoms.randomString(minimumLength: 16, maximumLength: 32)
// Fake Data Generators
Randoms.randomFakeName() // e.g., "Megan Freeman"
Randoms.randomFakeFirstName() // e.g., "Megan"
Randoms.randomFakeLastName() // e.g., "Freeman"
Randoms.randomFakeCity() // e.g., "West Haven"
Randoms.randomFakeGender() // "Male" or "Female"
Randoms.randomFakeConversation()
Randoms.randomFakeTitle() // e.g., "CEO of Google"
Randoms.randomCurrency() // e.g., "USD"

// Gravatar Images
Randoms.randomGravatar { (image, error) in
    // Handle the image/error
}

// Custom Gravatar Style
Randoms.createGravatar(.Retro) { (image, error) in
    // Handle the image/error
}
```

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
.package(url: "https://github.com/JamesLeeTrigg/SwiftRandom.git", from: "1.0.0")
]
```

### Manual Installation

Download and drop 'SwiftRandom.swift' into your project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.


