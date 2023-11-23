# swift-contexts

[![API Docs](http://img.shields.io/badge/Read_the-docs-2196f3.svg)](https://swiftylab.github.io/swift-contexts/documentation/Contexts/)
[![Swift Package Manager Compatible](https://img.shields.io/github/v/tag/SwiftyLab/swift-contexts?label=SPM&color=orange)](https://badge.fury.io/gh/SwiftyLab%2Fswift-contexts)
[![Swift](https://img.shields.io/badge/Swift-5.2+-orange)](https://img.shields.io/badge/Swift-5-DE5D43)
[![Platforms](https://img.shields.io/badge/Platforms-all-sucess)](https://img.shields.io/badge/Platforms-all-sucess)
[![CI/CD](https://github.com/SwiftyLab/swift-contexts/actions/workflows/main.yml/badge.svg)](https://github.com/SwiftyLab/swift-contexts/actions/workflows/main.yml)
[![CodeFactor](https://www.codefactor.io/repository/github/swiftylab/swift-contexts/badge)](https://www.codefactor.io/repository/github/swiftylab/swift-contexts)
[![codecov](https://codecov.io/gh/SwiftyLab/swift-contexts/branch/main/graph/badge.svg?token=XcGO9JCN9Q)](https://codecov.io/gh/SwiftyLab/swift-contexts)
<!-- [![CodeQL](https://github.com/SwiftyLab/swift-contexts/actions/workflows/codeql-analysis.yml/badge.svg?event=schedule)](https://github.com/SwiftyLab/swift-contexts/actions/workflows/codeql-analysis.yml) -->

A no-boilerplate dependency management library for Swift.

## Overview

When following [Single responsibility](https://en.wikipedia.org/wiki/Single-responsibility_principle) in [SOLID](https://en.wikipedia.org/wiki/SOLID) principle, code is divided into multiple types/functions each representing a responsibility/goal, i.e. storage access, database and networking, scheduling etc.

These types/functions can depend on each other and it is important these dependencies need to be controlled to deterministically test each responsibility, free from side effects from external components, i.e. file systems, network connectivity and speed, server uptime etc.

This library addresses this concern by allowing controlling dependencies with following features:

- Propagating dependencies throughout application in a way that is more ergonomic than explicitly passing them around everywhere, but safer than having a global dependency.
- Override dependencies in different parts of application for testing or customizing experiences in various parts.

## Requirements

| Platform | Minimum Swift Version | Installation | Status |
| --- | --- | --- | --- |
| iOS 8.0+ / macOS 10.10+ / tvOS 9.0+ / watchOS 2.0+ | 5.2 | Swift Package Manager | Fully Tested |
| Linux | 5.2 | Swift Package Manager | Fully Tested |
| Windows | 5.2 | Swift Package Manager | Fully Tested |

## Installation

<details>
  <summary><h3>Swift Package Manager</h3></summary>

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding `swift-contexts` as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
.package(url: "https://github.com/SwiftyLab/swift-contexts.git", from: "1.0.0"),
```

Then you can add the `Contexts` module product as dependency to the `target`s of your choosing, by adding it to the `dependencies` value of your `target`s.

```swift
.product(name: "Contexts", package: "swift-contexts"),
```

</details>

## Usage

See the full [documentation](https://swiftylab.github.io/swift-contexts/documentation/Contexts/) for API details and use cases.

## Contributing

If you wish to contribute a change, suggest any improvements,
please review our [contribution guide](CONTRIBUTING.md),
check for open [issues](https://github.com/SwiftyLab/swift-contexts/issues), if it is already being worked upon
or open a [pull request](https://github.com/SwiftyLab/swift-contexts/pulls).

## License

`swift-contexts` is released under the MIT license. [See LICENSE](LICENSE) for details.
