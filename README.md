# TrueMasonryStack

A powerful and flexible masonry layout implementation for SwiftUI that intelligently optimizes space utilization by considering both horizontal and vertical dimensions.

---

## Overview

**TrueMasonryStack** provides a custom layout container that arranges elements in a masonry-style grid, similar to Pinterest or Instagram's explore page. Unlike traditional flow layouts or wrapped `HStack`s, this implementation specializes in handling elements of varying widths and heights while maximizing space efficiency.

---

## Features

- Intelligent space optimization for elements of varying sizes.
- Seamless integration with SwiftUI views.
- Fully customizable layout and styling options.

---

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/SwiftUIMasonryLayout.git", from: "1.0.0")
]
```

Or add it directly in Xcode:

    Navigate to File > Swift Packages > Add Package Dependency.
    Enter the package URL: https://github.com/yourusername/SwiftUIMasonryLayout.git.
    Follow the prompts to complete the setup.

Usage

Import the package and use MasonryLayout in your SwiftUI views:

import SwiftUIMasonryLayout

struct ContentView: View {
    var items: [Item] // Your data model

    var body: some View {
        MasonryLayout {
            ForEach(items) { item in
                // Your item view
                ItemView(item: item)
                    .frame(width: item.width, height: item.height)
            }
        }
        .padding()
    }
}

Demo
Screenshots

Videos

Add images and videos to showcase how the TrueMasonryStack works in real-world scenarios.
