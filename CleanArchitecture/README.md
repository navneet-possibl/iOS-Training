#  Clean Architecture Fundamentals (iOS)

A production-style learning project demonstrating **SwiftUI + MVVM + Clean Architecture** with dependency inversion, repository abstraction, DTO-to-domain mapping, async/await, dependency injection, and unit tests.

## Learning goals
- Understand Presentation, Domain, and Data layers.
- Apply the Dependency Rule.
- Keep business logic independent of frameworks and infrastructure.
- Use Use Cases for application operations.
- Define repository abstractions in Domain and implementations in Data.
- Separate API DTOs from Domain Entities.
- Make business logic testable without networking.

## Architecture

```text
┌──────────────────────────────┐
│ Presentation                 │
│ UserListView + ViewModel     │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│ Domain                       │
│ User + Repository + UseCase  │
└──────────────┬───────────────┘
               ↑
┌──────────────────────────────┐
│ Data                         │
│ DTO + Repository + APIClient │
└──────────────────────────────┘
```

Runtime flow:

```text
App
 ↓
DependencyContainer
 ↓
UserViewModel
 ↓
GetUsersUseCase
 ↓
UserRepository protocol
 ↓
UserRepositoryImpl
 ↓
APIClient
 ↓
URLSession
```


## 1. Why Clean Architecture?
Clean Architecture separates business rules from UI and infrastructure so that business logic is easier to test, maintain, and change.

## 2. Core rule
**Dependencies point inward.**

Practical iOS rule:

```text
Presentation → Domain
Data → Domain
```

Domain should not import SwiftUI, UIKit, URLSession, Core Data, Firebase, or networking libraries.

## 3. Layers

### Presentation
Responsible for UI and UI state.

Examples:
- SwiftUI View
- UIViewController
- ViewModel

### Domain
The business core.

Contains:
- Entities
- Use Cases
- Repository protocols

### Data
Infrastructure and external data.

Contains:
- DTOs
- API clients
- Repository implementations
- Persistence/data sources

## 4. Use Case
A Use Case represents an application/business operation.

```swift
protocol GetUsersUseCase {
    func execute() async throws -> [User]
}
```

It keeps business rules out of the ViewModel.

## 5. Repository
The Domain defines what data it needs:

```swift
protocol UserRepository {
    func getUsers() async throws -> [User]
}
```

The Data layer decides how to provide it.

## 6. Dependency Inversion

Bad:

```swift
final class GetUsersUseCaseImpl {
    private let repository = UserRepositoryImpl()
}
```

Good:

```swift
final class GetUsersUseCaseImpl {
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }
}
```

The Use Case depends on an abstraction.

## 7. DTO vs Entity

DTO = external/API representation.

Entity = business representation.

Mapping creates a boundary:

```text
API JSON
  ↓
UserDTO
  ↓
Mapper
  ↓
User
```

API schema changes should not leak into Domain.

## 8. MVVM vs Clean Architecture

MVVM:

```text
View ↔ ViewModel
```

Clean Architecture:

```text
Presentation
     ↓
Domain
     ↑
Data
```

They complement each other.

## 9. Testing advantage

A Use Case can be tested with:

```swift
MockUserRepository()
```

No real server is required.

Test:
- success
- repository failure
- business rules
- empty data
- mapping rules where appropriate

## 10. Don't over-engineer

Not every screen needs five abstractions.

Ask:

> What complexity am I trying to control?

Use Clean Architecture when the added boundaries provide value through:
- meaningful business logic
- multiple data sources
- testability
- team scale
- long-lived features
- replaceable infrastructure

