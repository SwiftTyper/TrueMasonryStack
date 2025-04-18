# TrueMasonryStack

https://github.com/user-attachments/assets/8a53cdff-aee1-4b17-b60c-86d177b68164

## Overview

**TrueMasonryStack** provides a custom layout container that arranges elements in a row-based masonry-style grid, however unlike other flow layouts or `WrappedHStacks`, this implementation specializes in handling elements of varying widths and heights while maximizing space efficiency. It arranges elements in rows while trying to cram in as of them as possible into a given row.

https://github.com/user-attachments/assets/d4c10092-71a7-4799-9ea2-694fff80a3b8

## Suggestion/Disclaimer

If you are dealing with a bunch of unconsistently sized elements they might not necessary fit well in a row based layout, if so then I would recommend should you check out [BentoStack](https://github.com/SwiftTyper/BentoStack)
which should be save you more space.

---

## Installation

### Swift Package Manager

Add it directly in Xcode:

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

The original idea for this package arose from the need for a better layout to display widgets in my app **[Wigion](https://apps.apple.com/us/app/wigion/id6578453601)**. Widgets in **Wigion** can be displayed in many different sizes, and using a typical `WrappingHStack` or grid proved to be extremely space inefficient. So i developed **TrueMasonryStack** to solve this problem by making better use of available space while keeping the layout visually appealing.


![wigion](https://github.com/user-attachments/assets/49bb329d-dfae-4844-b1cb-711b9db9165c)
