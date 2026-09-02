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


#Day 13 — Use Cases & Repository Pattern

Presentation
      ↓
   Use Case
      ↓
Repository Protocol
      ↑
Repository Implementation
      ↓
   Data Source

##1. Use Case Pattern

A Use Case represents one specific application or business operation.

Examples:

GetUsers

LoginUser

CreateOrder

UpdateProfile

DeleteAccount

Example:

protocol GetUsersUseCase {
    func execute() async throws -> [User]
}

Implementation:

final class GetUsersUseCaseImpl: GetUsersUseCase {

    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func execute() async throws -> [User] {
        try await repository.getUsers()
    }
}

Why Use Cases?

Use Cases keep application/business logic outside the ViewModel.

ViewModel → Use Case → Repository → Data Source

This improves testability, maintainability, and separation of responsibilities.

##2. Repository Pattern

A Repository provides an abstraction over data access.

The Domain should not need to know whether data comes from:

REST API

Core Data

SQLite

Firebase

Local JSON

Cache

Mock data

The Repository hides these implementation details.

##3. Repository Protocol

The Repository protocol belongs to the Domain layer.

protocol UserRepository {
    func getUsers() async throws -> [User]
}

The Domain defines what it needs, not how the data is retrieved.

##4. Repository Implementation

The concrete implementation belongs to the Data layer.

final class UserRepositoryImpl: UserRepository {

    private let apiClient: APIClientProtocol
    private let mapper: UserMapper

    init(
        apiClient: APIClientProtocol,
        mapper: UserMapper
    ) {
        self.apiClient = apiClient
        self.mapper = mapper
    }

    func getUsers() async throws -> [User] {
        // Fetch DTOs
        // Map DTOs to Domain entities
    }
}

Architecture:

Domain
   │
   │ defines
   ▼
UserRepository
   ▲
   │ implements
   │
Data
   │
   ▼
UserRepositoryImpl

##5. Dependency Inversion

The Use Case depends on the Repository abstraction, not the concrete implementation.

Bad

final class GetUsersUseCaseImpl {

    private let repository = UserRepositoryImpl()
}

Good

final class GetUsersUseCaseImpl {

    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }
}

The Use Case now depends on an abstraction.

##6. Why Dependency Inversion Matters

Different implementations can satisfy the same Repository protocol:

             UserRepository
                    ▲
          ┌─────────┼─────────┐
          │         │         │
          ▼         ▼         ▼
      API Repo   Local Repo  Mock Repo

This provides:

Loose coupling

Better testability

Easier maintenance

Replaceable data sources

7. Use Case vs Repository

Use Case

Repository

Represents an application action

Abstracts data access

Contains business/application logic

Retrieves or stores data

Lives in Domain

Protocol lives in Domain

Uses Repository

Implementation lives in Data

Example: GetUsersUseCase

Example: UserRepository

Easy way to remember

Use Case: What does the application want to do?

Repository: Where/how does the required data come from?

##8. Responsibilities

Use Case

Should handle:

Application logic

Business rules

Orchestration of repositories

Validation where appropriate

Domain-level transformations

Repository

Should handle:

Data retrieval

Data persistence

API/data-source communication

Database access

DTO-to-domain mapping where appropriate

The Repository should not become a container for unrelated business rules.

##9. Data Flow

SwiftUI View
      ↓
ViewModel
      ↓
GetUsersUseCase
      ↓
UserRepository
      ↑
UserRepositoryImpl
      ↓
APIClient
      ↓
API

For API data:

API JSON
   ↓
UserDTO
   ↓
Mapper
   ↓
User
   ↓
Repository
   ↓
Use Case
   ↓
ViewModel
   ↓
SwiftUI

##10. Dependency Injection

Dependencies are created at the Composition Root.

APIClient
    ↓
UserRepositoryImpl
    ↓
GetUsersUseCaseImpl
    ↓
UserViewModel
    ↓
UserListView

The Composition Root is responsible for assembling the dependency graph.

##11. Testing Advantage

Because the Use Case depends on a protocol, a mock repository can be injected.

struct MockUserRepository: UserRepository {

    func getUsers() async throws -> [User] {
        [
            User(
                id: 1,
                name: "Test User",
                email: "test@example.com"
            )
        ]
    }
}

Then:

let useCase = GetUsersUseCaseImpl(
    repository: MockUserRepository()
)

No real API or network connection is required.

##12. One Use Case — One Responsibility

Prefer focused Use Cases:

GetUsersUseCase
CreateUserUseCase
UpdateUserUseCase
DeleteUserUseCase
LoginUserUseCase

Avoid one large UserUseCase handling every operation.

Each Use Case should have a clear purpose.

##13. Common Mistakes

Avoid

View → API
ViewModel → URLSession
UseCase → UserRepositoryImpl()
Domain → Data
Repository → huge business logic

Prefer

View
 ↓
ViewModel
 ↓
Use Case
 ↓
Repository
 ↓
Data Source

##14. Key Takeaways

A Use Case represents a specific application/business operation.

A Repository abstracts data access.

Repository protocols belong to the Domain layer.

Repository implementations belong to the Data layer.

Use Cases should depend on abstractions.

Dependency Injection provides concrete implementations.

Repositories should focus on data access.

Mock repositories make Use Cases easy to unit test.

The preferred flow is:

Presentation
     ↓
   Use Case
     ↓
Repository
     ↓
Data Source

