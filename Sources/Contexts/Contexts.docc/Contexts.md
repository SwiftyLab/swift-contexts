# ``Contexts``

A no-boilerplate dependency management library for Swift.

## Overview

When following [Single responsibility](https://en.wikipedia.org/wiki/Single-responsibility_principle) in [SOLID](https://en.wikipedia.org/wiki/SOLID) principle, code is divided into multiple types/functions each representing a responsibility/goal, i.e. storage access, database and networking, scheduling etc.

These types/functions can depend on each other and it is important these dependences need to be controlled to deterministically test each responsibility, free from side effects from external components, i.e. file systems, network connectivity and speed, server uptime etc.

This library addresses this concern by allowing controlling dependencies with following features:

- Propagating dependencies throughout application in a way that is more ergonomic than explicitly passing them around everywhere, but safer than having a global dependency.
- Override dependencies in different parts of application for testing or customizing experiences in various parts.

## Installation

@TabNavigator {
    @Tab("Swift Package Manager") {

        The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

        Once you have your Swift package set up, adding `swift-contexts` as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

        ```swift
        .package(url: "https://github.com/SwiftyLab/swift-contexts.git", from: "1.0.0"),
        ```

        Then you can add the `Contexts` module product as dependency to the `target`s of your choosing, by adding it to the `dependencies` value of your `target`s.

        ```swift
        .product(name: "Contexts", package: "swift-contexts"),
        ```
    }
}

## Topics

### Dependency management

- ``Context``
- ``ContextKey(_:)``
- ``ContextKey()``
