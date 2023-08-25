# Weather App
> Get to know more about the weather and stuff.

[![Swift Version][swift-image]][swift-url]

Usage of [Open Weather Map API](https://openweathermap.org/api) to present some weather information to the user.


## Running

This project has some dependencies. They are attached using Swift Package Manager.
To learn more about this native package manager, [click here](https://www.swift.org/package-manager/).


## Testing

When running tests, you'll need to record the snapshots first. To do so:
1. Open ```WeatherViewSnapshotTests``` class.
2. Update ```recordMode``` variable inside ```setUp()``` method to true.
3. Run tests.

It's going to fail. Now, update ```recordMode``` variable to false again and voi'la. Run tests again.


## Technologies

[I18n](https://medium.com/i18n-and-l10n-resources-for-developers/quick-guide-ios-internationalization-i18n-and-localization-l10n-bce64b0de5c2#:~:text=Internationalization%20(i18n)%20in%20iOS,to%20set%20dates%2C%20numbers%20etc) to localize the app. Using English, Portuguese and Spanish.

[Native network layer](https://malcolmkmd.medium.com/writing-network-layer-in-swift-protocol-oriented-approach-4fa40ef1f908) with protocols;

[Native unit test](https://developer.apple.com/documentation/xctest) with XCTest;

[Kingfisher](https://github.com/onevcat/Kingfisher) library to download images;

[Snapshot tests](https://github.com/uber/ios-snapshot-test-case/) with Uber's library.


## Contact

Gabriel Todaro – [@gabrieltodaro](http://linkedin.com/in/gabrieltodaro/) – gabriel.todaro@outlook.com

[swift-image]: https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
