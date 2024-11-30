# TrueMasonryStack

https://github.com/user-attachments/assets/8a53cdff-aee1-4b17-b60c-86d177b68164

## Overview

**TrueMasonryStack** provides a custom layout container that arranges elements in a masonry-style grid, similar to Pinterest or Instagram's explore page. Unlike traditional flow layouts or `WrappedHStacks`, this implementation specializes in handling elements of varying widths and heights while maximizing space efficiency.

https://github.com/user-attachments/assets/d4c10092-71a7-4799-9ea2-694fff80a3b8

---

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: " https://github.com/SwiftTyper/TrueMasonryStack.git", from: "1.0.0")
]
```

Or add it directly in Xcode:

    1. Navigate to File > Swift Packages > Add Package Dependency.

    2. Enter the package URL: https://github.com/SwiftTyper/TrueMasonryStack.git.
    
    3. Follow the prompts to complete the setup.

### Usage

Import the package and use MStack in your SwiftUI views:
```swift
import TrueMasonryStack

struct ContentView: View {
    var items: [Item] // Your data model

    var body: some View {
        MStack {
            ForEach(items) { item in
                ItemView(item: item)
            }
        }
    }
}
```

## The Why?

The original idea for this package arose from the need for a better layout to display widgets in my app **Wigion**. Widgets in **Wigion** can be displayed in many different sizes, and using a typical `WrappingHStack` or grid proved to be extremely space inefficient. So i developed **TrueMasonryStack** to solve this problem by making better use of available space while keeping the layout visually appealing.


![wigion](https://github.com/user-attachments/assets/49bb329d-dfae-4844-b1cb-711b9db9165c)
