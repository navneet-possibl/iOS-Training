//
//  ArchitectualTradeOffs.swift
//  Day06
//
//  Created by HIMANK on 28/08/26.
//

/*# Architectural Trade-offs — iOS

An architectural trade-off means **choosing one approach over another because every design has advantages and disadvantages**.

There is no architecture that is perfect for every application.

Which architecture is the most appropriate for this application's requirements?

---

# 2. Common Architecture Choices

Typical iOS architectures include:

* MVC
* MVVM
* MVP
* VIPER
* Clean Architecture
* TCA
* Coordinator-based architecture

The right choice depends on:

* Application size
* Team size
* Feature complexity
* Testing requirements
* Development speed
* Maintainability
* Performance
* Expected future changes

---

# 3. MVVM — Main Trade-offs

### Advantages

* Separates UI from business logic
* ViewModel is easier to unit test
* Works well with SwiftUI
* Reduces ViewController complexity
* Encourages separation of responsibilities

### Disadvantages

* ViewModels can become very large
* Developers may put too much business logic inside ViewModel
* Additional abstraction compared with simple MVC
* Can introduce unnecessary complexity for small features

### Example

Instead of:

```swift
struct UserView: View {
    var body: some View {
        // API call
        // validation
        // business logic
        // UI
    }
}
```

Prefer:

```swift
struct UserView: View {
    @StateObject var viewModel: UserViewModel

    var body: some View {
        // UI only
    }
}
```

The ViewModel handles presentation-related state and actions.

---

# 4. MVC Trade-off

### Advantages

* Simple
* Easy to understand
* Less boilerplate
* Good for small applications/features

### Disadvantages

* ViewController can become massive
* Business logic gets mixed with UI logic
* Difficult to unit test
* Harder to maintain as the application grows

For a small screen:

> MVC may be completely reasonable.

For a complex feature:

> MVVM or another architecture may provide better separation.

---

# 5. Abstraction vs Simplicity

One of the most important architectural trade-offs is:

**More abstraction ≠ better architecture.**

For example:

```text
View
 ↓
ViewModel
 ↓
UseCase
 ↓
Repository
 ↓
Service
 ↓
APIClient
```

This can provide excellent separation.

But if the feature only needs:

```text
View
 ↓
ViewModel
 ↓
APIClient
```

adding five additional layers may be unnecessary.

### Rule

> **Introduce abstraction when it solves a real problem.**

Don't create protocols, repositories, factories and use cases simply because "Clean Architecture requires them."

---

# 6. Protocols — Flexibility vs Complexity

Protocols provide abstraction and testability.

Example:

```swift
protocol UserServiceProtocol {
    func fetchUsers() async throws -> [User]
}
```

Then:

```swift
final class UserService: UserServiceProtocol {
    // production implementation
}
```

Testing becomes easier:

```swift
final class MockUserService: UserServiceProtocol {
    // mock implementation
}
```

### Benefit

```text
Flexibility
Testability
Dependency Injection
Loose Coupling
```

### Cost

Too many protocols can create:

* More files
* More boilerplate
* Harder navigation
* Increased cognitive overhead


Use protocols around **boundaries and dependencies**, not every class by default.

---

# 7. Dependency Injection Trade-off

Dependency Injection improves testability and decoupling.

Example:

```swift
final class UserViewModel {

    private let service: UserServiceProtocol

    init(service: UserServiceProtocol) {
        self.service = service
    }
}
```

### Advantage

We can inject:

```swift
UserService()
```

or:

```swift
MockUserService()
```

### Trade-off

Dependency injection increases setup complexity.

For a very small feature, manually creating dependencies may be sufficient.

For a large application, centralized dependency management becomes valuable.

---

# 8. Repository Pattern

Repository abstracts where data comes from.

```text
ViewModel
    ↓
Repository
    ↓
 ┌───────────────┐
 │               │
API           Database
```

The ViewModel doesn't care whether the data comes from:

* REST API
* Core Data
* SwiftData
* Cache
* Local JSON

### Advantage

Easy to change data sources.

### Disadvantage

Additional abstraction.

For a feature with only one simple API request, a repository may not provide enough value to justify its complexity.

---

# 9. Networking Abstraction

A common architecture:

```text
View
 ↓
ViewModel
 ↓
Service
 ↓
APIClient
 ↓
URLSession
```

### Why?

Each layer has a responsibility.

**ViewModel**

Handles presentation state.

**Service**

Handles feature/business-level API operations.

**APIClient**

Handles generic HTTP functionality.

Example:

```swift
protocol APIClientProtocol {
    func request<T: Decodable>(
        _ endpoint: Endpoint
    ) async throws -> T
}
```

### Trade-off

This architecture is highly reusable but introduces more layers than directly using `URLSession`.

---

# 10. Performance vs Abstraction

Abstraction can improve maintainability but sometimes introduces overhead.

For example:

```text
Direct implementation
        ↓
Simple + fast

Highly abstracted implementation
        ↓
Flexible + maintainable
```

Usually, the abstraction overhead is insignificant compared with network/database operations.

However, in performance-critical areas such as:

* Large lists
* Image processing
* Animation
* Real-time rendering
* High-frequency data processing

performance should be considered explicitly.

### Principle

> **Measure before optimizing.**

Don't sacrifice architecture based on assumed performance problems.

---

# 11. Reusability vs Feature-Specific Design

Reusable components are useful, but excessive generalization can make code harder to understand.

Bad approach:

```swift
UniversalConfigurableDataProvider
```

when the code is only used by one screen.

Better:

Create a simple feature-specific abstraction first.

Generalize when repeated patterns actually emerge.

### Principle

> **Duplication is sometimes cheaper than premature abstraction.**

---

# 12. Testability vs Development Speed

Highly testable architecture usually requires:

* Dependency injection
* Protocols
* Mock objects
* Clear boundaries
* Smaller components

This increases initial development time.

But it reduces the cost of:

* Regression testing
* Refactoring
* Debugging
* Adding features

### Trade-off

```text
More upfront effort
        ↓
Better long-term maintainability
```

For a prototype:

> Optimize for speed.

For a long-lived production application:

> Optimize for maintainability and reliability.

---

# 13. SwiftUI Architecture Trade-off

SwiftUI naturally encourages:

```text
View
 ↓
State / ViewModel
 ↓
Services
```

SwiftUI reduces some of the problems associated with UIKit MVC.

However, developers can still create massive Views.

Example:

```swift
var body: some View {
    // 500 lines of UI
    // networking
    // validation
    // navigation
    // business logic
}
```

SwiftUI does not automatically guarantee good architecture.

### Principle

> SwiftUI changes how UI is built, not the need for architectural boundaries.

---

# 14. State Management Trade-offs

Possible approaches:

### Local State

```swift
@State
```

Good for:

* UI-only state
* Small components
* Temporary state

### Observable ViewModel

```swift
@Observable
final class UserViewModel {
}
```

Good for:

* Feature-level state
* API state
* Business/presentation coordination

### Global State

Useful when many unrelated screens need shared state.

But global state can create:

* Hidden dependencies
* Difficult testing
* Unexpected side effects

### Principle

> Keep state as local as possible and make it shared only when necessary.

---

# 15. Coordinator vs Navigation in View

Navigation can be handled directly inside SwiftUI or through a Coordinator pattern.

### Direct Navigation

```text
Simple
Less code
Easy to understand
```

### Coordinator

```text
Centralized navigation
Better for complex flows
More testable
More abstraction
```

For a simple app:

> Direct navigation may be enough.

For complex flows:

```text
Login
 ↓
Onboarding
 ↓
Home
 ↓
Deep Link
 ↓
Checkout
```

A Coordinator can provide significant value.

---

# 16. Clean Architecture Trade-off

Typical structure:

```text
Presentation
     ↓
Domain
     ↓
Data
```

### Advantages

* Strong separation
* Highly testable
* Easy to replace implementations
* Good for large applications
* Business logic becomes framework-independent

### Disadvantages

* Lots of boilerplate
* More files
* Steeper learning curve
* Slower initial development
* Can be over-engineering for small apps

 
Don't use Clean Architecture simply because it is considered "more professional."

Use it when the application's complexity justifies it.

---

# 17. Architecture Should Follow Complexity

A useful progression:

```text
Small Feature
    ↓
Simple MVVM

Medium Feature
    ↓
MVVM + Services + DI

Large Feature
    ↓
MVVM + Repository + DI + Coordinators

Very Large Application
    ↓
Modular/Clean Architecture
```

The exact architecture can vary.

The important concept is:

> **Architecture should scale with complexity.**

---

# 18. Common Architectural Mistakes

### 1. Over-engineering

Creating many layers before they are needed.

### 2. Massive ViewModel

Putting networking, persistence, validation and business rules into one ViewModel.

### 3. Massive View

Putting business logic directly into SwiftUI View.

### 4. Protocol Everywhere

Creating protocols for every class without a meaningful abstraction boundary.

### 5. Global Singleton Abuse

```swift
NetworkManager.shared
```

everywhere.

This creates hidden dependencies and makes testing harder.

### 6. Premature Optimization

Complicating architecture because of an assumed performance issue without measuring it.

### 7. Architecture by Trend

Choosing TCA, VIPER, Clean Architecture, etc. simply because other teams use it.

---


Before selecting an architecture, ask:

### Complexity

* How complex is the feature?
* How many business rules exist?

### Scale

* Is this a small app or a large production system?
* Will the feature grow?

### Team

* How many developers will maintain it?
* Is everyone familiar with the architecture?

### Testing

* What needs to be unit tested?
* Are dependencies easy to replace?

### Change

* What is likely to change?
* API?
* Database?
* UI?
* Business rules?

### Performance

* Are there performance-sensitive paths?

### Maintenance

* Will another developer understand this six months later?

---


If asked:

**"Why did you choose MVVM?"**

A strong answer:

> "I chose MVVM because the feature had enough presentation and business complexity that keeping everything inside the ViewController or SwiftUI View would make it difficult to maintain and test. The ViewModel gives us a clear boundary for presentation state and user actions, while services handle external dependencies. I also kept the architecture lightweight rather than introducing additional layers that the feature didn't need."

---

# 21. Key Principle

The most important architectural principle:

> **There is no universally best architecture.**

Good architecture balances:

```text
Maintainability
      +
Testability
      +
Scalability
      +
Simplicity
      +
Performance
      +
Team Productivity
```

The best architecture is the one that provides **enough structure without unnecessary complexity**.

---

*/
