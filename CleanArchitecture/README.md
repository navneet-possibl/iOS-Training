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


# Day 12 — Domain, Data & Presentation Layers


Presentation
      ↓
    Domain
      ↑
     Data

##1. Presentation Layer

The Presentation layer is responsible for the UI and UI state.

Components

SwiftUI Views

ViewModels

Responsibilities

Display data

Handle user interactions

Manage UI state

Call Domain Use Cases

Update the UI based on results

Key Principle

The Presentation layer should not:

Make API calls directly

Know about DTOs

Create repositories

Contain business logic

##2. Domain Layer

The Domain layer is the core of the application and contains business-related logic.

Components

Entities

Use Cases

Repository Protocols

Responsibilities

Define business rules

Represent business entities

Define application operations

Define repository abstractions

Example:

struct User: Identifiable {
    let id: Int
    let name: String
    let email: String
}

Repository abstraction:

protocol UserRepository {
    func getUsers() async throws -> [User]
}

Key Principle

The Domain layer should not depend on:

SwiftUI

UIKit

URLSession

API implementation

Database

DTOs

Third-party frameworks

The Domain defines what the application needs, not how it is implemented.

##3. Data Layer

The Data layer is responsible for external data sources and infrastructure.

Components

DTOs

Mappers

API Clients

Repository Implementations

Database / Persistence

Responsibilities

Fetch data from APIs

Read/write persistent data

Decode API responses

Map DTOs to Domain Entities

Implement Domain repository protocols

Example:

struct UserDTO: Decodable {
    let id: Int
    let name: String
    let email: String
}

Repository implementation:

final class UserRepositoryImpl: UserRepository {

    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func getUsers() async throws -> [User] {
        // Fetch DTOs and map them to Domain entities
    }
}

##4. Data Flow

The overall flow is:

API
 ↓
UserDTO
 ↓
Mapper
 ↓
User
 ↓
UseCase
 ↓
ViewModel
 ↓
SwiftUI View

The API-specific model stays inside the Data layer.

The Presentation layer works with the clean Domain model.

##5. Domain Entity vs DTO

Domain Entity

DTO

Represents business data

Represents external/API data

Lives in Domain

Lives in Data

Independent of API

Usually tied to API structure

Used by Use Cases

Used for decoding

Should remain stable

Can change when API changes

Example:

API JSON
   ↓
UserDTO
   ↓
User

This separation prevents API changes from leaking into the business layer.

##6. Dependency Direction

The main dependency rule is:

Presentation → Domain
Data → Domain

The Domain layer should remain independent.

        Presentation
             ↓
          Domain
             ↑
            Data

The Data layer implements the abstractions defined by Domain.


##7. Key Takeaways

Presentation handles UI and UI state.

Domain contains business rules and application abstractions.

Data handles APIs, persistence, DTOs and implementations.

Repository protocols belong to Domain.

Repository implementations belong to Data.

DTOs should not leak into Presentation or Domain.

Mappers create a boundary between external data and business data.

Domain should remain independent of infrastructure.

Dependency Injection connects the layers.

Architecture should be proportional to application complexity.
