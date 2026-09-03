# SwiftUI Fundamentals & Declarative UI

## Overview

SwiftUI is Apple's modern framework for building user interfaces across Apple platforms.

Unlike UIKit's imperative approach, SwiftUI follows a **declarative UI** approach. We describe what the UI should look like based on the current state, and SwiftUI automatically updates the UI when that state changes.

---

## 1. Declarative UI

### Imperative UI — UIKit

In UIKit, we explicitly tell the UI what to do.

```swift
label.text = "Hello"

if isLoggedIn {
    label.text = "Welcome"
}
```

The developer manually updates UI elements when data changes.

### Declarative UI — SwiftUI

In SwiftUI, we describe the UI based on the current state.

```swift
Text(isLoggedIn ? "Welcome" : "Please Login")
```

When `isLoggedIn` changes, SwiftUI automatically updates the affected UI.

### Core Mental Model

```text
State
  ↓
View
  ↓
Rendered UI
```

When state changes:

```text
State changes
     ↓
SwiftUI detects the change
     ↓
View is recomputed
     ↓
UI reflects the new state
```

---

# 2. SwiftUI View

Everything displayed in SwiftUI is generally a `View`.

```swift
struct ContentView: View {

    var body: some View {
        Text("Hello World")
    }
}
```

### `body`

The `body` describes the UI hierarchy for the current state.

```swift
var body: some View {
    VStack {
        Text("Hello")
        Button("Tap Me") {
            print("Tapped")
        }
    }
}
```

---

# 3. Basic Views

### Text

```swift
Text("Hello World")
```

### Image

```swift
Image(systemName: "heart.fill")
```

### Button

```swift
Button("Login") {
    print("Login tapped")
}
```

### Spacer

```swift
VStack {
    Text("Top")

    Spacer()

    Text("Bottom")
}
```

---

# 4. Layout Containers

## VStack

Arranges views vertically.

```swift
VStack {
    Text("Name")
    Text("Email")
    Button("Login") {
        print("Login")
    }
}
```

## HStack

Arranges views horizontally.

```swift
HStack {
    Image(systemName: "person")
    Text("Profile")
}
```

## ZStack

Places views on top of each other.

```swift
ZStack {
    Color.blue

    Text("Hello")
}
```

---

# 5. Modifiers

Modifiers change the appearance or behavior of a view.

```swift
Text("Hello")
    .font(.title)
    .bold()
    .foregroundStyle(.blue)
    .padding()
```

Modifiers can be chained.

### Modifier Order Matters

```swift
Text("Hello")
    .background(.yellow)
    .padding()
```

is different from:

```swift
Text("Hello")
    .padding()
    .background(.yellow)
```

The order creates a different view hierarchy and therefore can produce different results.

---

# 6. State

SwiftUI is **state-driven**.

Example:

```swift
struct CounterView: View {

    @State private var count = 0

    var body: some View {
        VStack {
            Text("Count: \(count)")

            Button("Increment") {
                count += 1
            }
        }
    }
}
```

When:

```swift
count += 1
```

executes, SwiftUI detects the state change and updates the UI that depends on `count`.

---

# 7. `@State`

`@State` is commonly used for local state owned by a SwiftUI view.

```swift
@State private var isLoggedIn = false
```

Example:

```swift
struct LoginView: View {

    @State private var isLoggedIn = false

    var body: some View {
        VStack {

            Text(
                isLoggedIn
                ? "Welcome!"
                : "Please Login"
            )

            Button("Login") {
                isLoggedIn = true
            }
        }
    }
}
```

### Important Concept

Don't think:

```text
"How do I manually change the Text?"
```

Think:

```text
"What state determines what the Text should display?"
```

---

# 8. Conditional UI

SwiftUI makes conditional rendering straightforward.

```swift
if isLoggedIn {
    Text("Welcome!")
} else {
    Text("Please Login")
}
```

The UI automatically changes when the state changes.

---

# 9. `ForEach`

`ForEach` creates views dynamically from a collection.

```swift
ForEach(users) { user in
    Text(user.name)
}
```

Example model:

```swift
struct User: Identifiable {
    let id = UUID()
    let name: String
}
```

Example:

```swift
struct UserListView: View {

    let users = [
        User(name: "John"),
        User(name: "Sarah"),
        User(name: "Alex")
    ]

    var body: some View {
        VStack {
            ForEach(users) { user in
                Text(user.name)
            }
        }
    }
}
```

---

# 10. List

`List` is used to display scrollable collections of data.

```swift
List(users) { user in
    Text(user.name)
}
```

Example:

```swift
struct UserListView: View {

    let users = [
        User(name: "John"),
        User(name: "Sarah"),
        User(name: "Alex")
    ]

    var body: some View {
        List(users) { user in
            Text(user.name)
        }
        .navigationTitle("Users")
    }
}
```

---

# 11. Navigation

Modern SwiftUI navigation commonly uses `NavigationStack`.

```swift
NavigationStack {
    List {
        NavigationLink("Profile") {
            ProfileView()
        }
    }
    .navigationTitle("Home")
}
```

The navigation destination is declared directly in the UI hierarchy.

---

# 12. Reusable Components

SwiftUI encourages creating small reusable views.

```swift
struct ProfileView: View {

    var body: some View {
        VStack {
            Image(systemName: "person.circle")

            Text("Nav")

            Text("iOS Developer")
        }
    }
}
```

The component can then be reused:

```swift
ProfileView()
```

This makes UI code easier to maintain and test.

---

# 13. SwiftUI vs UIKit

| UIKit | SwiftUI |
|---|---|
| Imperative | Declarative |
| `UIViewController` | `View` |
| `UILabel` | `Text` |
| `UIButton` | `Button` |
| `UIStackView` | `VStack` / `HStack` |
| `UITableView` | `List` |
| Auto Layout | SwiftUI Layout System |
| Delegates | State / Data Flow |
| Manual UI updates | State-driven UI |
| Storyboards/XIBs | Swift code |

---

# 14. Data Flow

A simplified SwiftUI data-flow model:

```text
        Source of Truth
              ↓
            State
              ↓
             View
              ↓
        User Interaction
              ↓
        State Changes
              ↓
       View Updates
```

The goal is to have a clear **single source of truth** for important data.

---

# 15. Declarative vs Imperative Thinking

### Imperative Thinking

```text
Create UI
   ↓
Change label
   ↓
Hide button
   ↓
Show loading indicator
   ↓
Update list
```

The developer manages individual UI changes.

### Declarative Thinking

```text
State
  ↓
What should the UI look like?
  ↓
SwiftUI renders the appropriate UI
```

Example:

```swift
if isLoading {
    ProgressView()
} else {
    UserListView(users: users)
}
```

Instead of manually showing and hiding views, we describe the UI for each state.

---

# 16. Important SwiftUI Principles

### 1. UI is a function of state

```text
UI = f(State)
```

The same state should produce the same UI.

### 2. State drives the UI

When state changes, dependent UI updates automatically.

### 3. Views should be small

Break large screens into reusable components.

### 4. Prefer a single source of truth

Avoid maintaining the same piece of data independently in multiple places.

### 5. Describe the UI, don't manually manage it

Focus on **what the UI should be**, rather than manually instructing every UI change.

---


---

# Key Takeaway

> **SwiftUI is a declarative, state-driven UI framework where we describe what the UI should look like for the current state, rather than manually updating individual UI elements.**

The most important mental model is:

```text
State
  ↓
View
  ↓
User Action
  ↓
State Change
  ↓
View Updates
```

Understanding this cycle is the foundation for building larger SwiftUI applications with **MVVM, networking, and Clean Architecture**.
