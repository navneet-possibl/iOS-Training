# Scenario-Based Architecture Selection

A practical guide to selecting the right software architecture based on **project requirements, complexity, team size, scalability, testability, and expected product evolution**.

The goal is not to promote a single architecture, but to understand **which architecture fits which scenario**.

---

## 🎯 Objective

Architecture decisions are often made by following trends rather than evaluating the actual problem.

This repository provides a **scenario-driven approach** to architecture selection.

Instead of asking:

> "Which architecture is the best?"

We ask:

> "Which architecture is the best fit for this scenario?"

---

## 🏗️ Architectures Covered

Depending on the scenario, the following architectures can be considered:

- **MVC** — Model-View-Controller
- **MVVM** — Model-View-ViewModel
- **MVP** — Model-View-Presenter
- **VIPER** — View, Interactor, Presenter, Entity, Router
- **Clean Architecture**
- **Coordinator-based Architecture**
- **Composable Architecture (TCA)**
- **Feature-based / Modular Architecture**
- **Hybrid Architectures**

---

# 🔍 Architecture Selection Framework

Architecture selection should be based on multiple factors:

| Factor | Questions to Consider |
|---|---|
| Project Size | Is this a small, medium, or large application? |
| Feature Complexity | How complex are the business rules? |
| Team Size | How many developers will work on the project? |
| Testability | How important is unit/UI testing? |
| Scalability | Is the application expected to grow significantly? |
| Modularity | Do features need to be independently developed? |
| Maintainability | How long will the application be maintained? |
| Onboarding | How easy should it be for new developers to understand? |
| Performance | Are there strict performance constraints? |
| Development Speed | Is rapid delivery more important than architectural complexity? |

---

# 🧩 Scenario-Based Architecture Selection

## Scenario 1 — Small Application / Prototype

### Example

A simple application with:

- 3–5 screens
- Limited business logic
- Small development team
- Short development lifecycle
- No major scalability requirements

### Recommended

**MVC**

```text
View
  ↓
Controller
  ↓
Model
```

### Why?

MVC provides:

- Low setup cost
- Minimal abstractions
- Fast development
- Easy initial understanding

### Avoid

Over-engineering the project with VIPER/Clean Architecture when the application does not require that level of separation.

---

# Scenario 2 — Medium-Sized Application

### Example

An application containing:

- 10–30 screens
- API integration
- Moderate business logic
- Multiple reusable components
- Unit testing requirements

### Recommended

**MVVM**

```text
        ┌──────────────┐
        │     View     │
        └──────┬───────┘
               │
               ▼
        ┌──────────────┐
        │  ViewModel   │
        └──────┬───────┘
               │
               ▼
        ┌──────────────┐
        │   Service    │
        └──────┬───────┘
               │
               ▼
        ┌──────────────┐
        │     API      │
        └──────────────┘
```

### Why?

MVVM provides a good balance between:

- Simplicity
- Testability
- Separation of concerns
- Maintainability

### Best Fit

MVVM is often a strong default for applications where MVC starts becoming difficult to maintain but a highly granular architecture is unnecessary.

---

# Scenario 3 — Complex Business Logic

### Example

An application with:

- Complex business rules
- Multiple data sources
- Significant unit testing
- Independent business logic
- Long-term maintenance

### Recommended

**Clean Architecture**

```text
┌─────────────────────────────┐
│          UI Layer           │
│       View / ViewModel      │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│       Domain Layer          │
│ Entities / Use Cases        │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│         Data Layer          │
│ Repository / API / DB       │
└─────────────────────────────┘
```

### Why?

Clean Architecture makes business rules independent from:

- UI frameworks
- Networking
- Database implementations
- External dependencies

This improves testability and long-term maintainability.

---

# Scenario 4 — Very Large Application

### Example

A large application with:

- Hundreds of screens
- Multiple development teams
- Many independent features
- Long-term development
- Frequent releases

### Recommended

**Feature-Based + Modular Architecture**

```text
App
│
├── Core
│   ├── Networking
│   ├── Analytics
│   ├── DesignSystem
│   └── Utilities
│
├── Authentication
│
├── Home
│
├── Profile
│
├── Payments
│
├── Orders
│
└── Search
```

Each feature can internally use an architecture such as:

```text
Feature
│
├── Presentation
├── Domain
├── Data
└── Tests
```

### Why?

The primary challenge at this scale is no longer just code organization.

It becomes:

- Team ownership
- Build times
- Dependency management
- Feature isolation
- Parallel development
- Release scalability

---

# Scenario 5 — Navigation-Heavy Application

### Example

An application containing:

- Complex navigation
- Deep navigation stacks
- Multiple flows
- Authentication flow
- Onboarding flow
- Tab-based navigation
- Modal presentations

### Recommended

**MVVM + Coordinator**

```text
              Coordinator
              /    |    \
             /     |     \
         Screen  Screen  Screen
            │
        ViewModel
            │
         Service
```

### Why?

Navigation logic should not be tightly coupled to ViewControllers or Views.

The Coordinator owns:

- Navigation
- Flow creation
- Screen transitions
- Dependency injection between screens

---

# Scenario 6 — Highly Testable Application

### Example

Testing is a major requirement:

- High unit-test coverage
- Business rules need isolated testing
- Mocking external dependencies
- CI/CD validation

### Recommended

**MVVM + Dependency Injection**

or

**Clean Architecture**

Example:

```swift
protocol UserService {
    func fetchUsers() async throws -> [User]
}

final class UsersViewModel {
    private let service: UserService

    init(service: UserService) {
        self.service = service
    }
}
```

Production:

```swift
UsersViewModel(
    service: UserServiceImpl()
)
```

Testing:

```swift
UsersViewModel(
    service: MockUserService()
)
```

### Key Principle

> Dependencies should be injected rather than created inside the component that consumes them.

---

# Scenario 7 — SwiftUI Application

### Example

A modern SwiftUI application with:

- Observable state
- Async APIs
- Dependency injection
- Navigation
- Feature-level state management

### Recommended

**MVVM / Feature-Based MVVM**

Example:

```text
Feature
│
├── View
├── ViewModel
├── Model
├── Service
└── Tests
```

Example:

```swift
struct UsersView: View {
    @State private var viewModel: UsersViewModel

    var body: some View {
        List(viewModel.users) { user in
            Text(user.name)
        }
    }
}
```

### Important

SwiftUI does not require MVVM.

Architecture should still be selected based on:

- State complexity
- Business logic
- Dependencies
- Testing requirements
- Application scale

---

# Scenario 8 — State-Heavy Application

### Example

The application has:

- Large shared state
- Complex state transitions
- Many screens reacting to the same state
- Predictable state updates
- Strong need for state debugging

### Consider

**The Composable Architecture (TCA)**

Conceptually:

```text
        ┌──────────┐
        │   View   │
        └────┬─────┘
             │
          Action
             │
             ▼
        ┌──────────┐
        │ Reducer  │
        └────┬─────┘
             │
          State
             │
             ▼
        ┌──────────┐
        │   View   │
        └──────────┘
```

### Why?

TCA provides structured handling of:

- State
- Actions
- Reducers
- Effects
- Dependencies
- Testing

### Trade-off

TCA introduces additional concepts and should be adopted when its benefits justify the learning and architectural overhead.

---

# ⚖️ Architecture Comparison

| Architecture | Complexity | Testability | Scalability | Development Speed |
|---|---:|---:|---:|---:|
| MVC | Low | Low | Low | ⭐⭐⭐⭐⭐ |
| MVVM | Medium | High | Medium | ⭐⭐⭐⭐ |
| MVP | Medium | High | Medium | ⭐⭐⭐ |
| VIPER | High | Very High | High | ⭐⭐ |
| Clean Architecture | High | Very High | Very High | ⭐⭐ |
| MVVM + Coordinator | Medium | High | High | ⭐⭐⭐⭐ |
| Feature + Modular | High | High | Very High | ⭐⭐⭐ |
| TCA | High | Very High | High | ⭐⭐⭐ |

> These ratings are contextual rather than absolute. A team's familiarity with an architecture can significantly change the trade-offs.

---

# 🧠 Decision Tree

```text
                 Start
                   │
                   ▼
          Is the app very small?
             /            \
           Yes             No
            │               │
           MVC              ▼
                    Is business logic
                       moderate?
                      /          \
                    Yes           No
                     │             │
                    MVVM          ▼
                           Complex business rules?
                              /          \
                            Yes           No
                             │             │
                      Clean Architecture  ▼
                                  Is navigation complex?
                                     /        \
                                   Yes         No
                                    │           │
                           MVVM + Coordinator  MVVM
```

For larger applications:

```text
Multiple teams?
      │
     Yes
      │
      ▼
Feature-Based + Modular
      │
      ▼
Use MVVM / Clean / TCA
inside individual features
```

---

# 🏛️ Recommended Default Strategy

Instead of selecting one architecture for the entire application, consider a **layered decision approach**.

```text
Application Architecture
        │
        ▼
Feature-Based Structure
        │
        ├── Feature A
        ├── Feature B
        └── Feature C
               │
               ▼
       Internal Architecture
               │
        ┌──────┼──────┐
        ▼      ▼      ▼
      MVVM   Clean   TCA
```

This allows architecture to evolve with complexity.

---

# 🚨 Avoid Architecture by Trend

Do not choose an architecture simply because:

- It is popular
- Another company uses it
- It appears in a tutorial
- It looks cleaner
- It has more layers
- It is considered "enterprise"

A more complex architecture is **not automatically a better architecture**.

---

# 📌 Architecture Decision Principles

### 1. Start Simple

Use the simplest architecture that satisfies the current requirements.

### 2. Optimize for Change

Architecture should make expected future changes easier.

### 3. Separate Responsibilities

Each component should have a clear responsibility.

### 4. Prefer Testability

Important business logic should be independently testable.

### 5. Control Dependencies

Dependencies should flow in a predictable direction.

### 6. Avoid Premature Abstraction

Do not introduce abstractions until they solve a real problem.

### 7. Consider the Team

An architecture is only useful if the team can understand and maintain it.

### 8. Revisit Decisions

Architecture is not permanent.

As the application grows:

```text
MVC
 ↓
MVVM
 ↓
MVVM + Coordinator
 ↓
Feature-Based
 ↓
Modular + Clean / TCA
```

The evolution should be driven by **actual complexity**, not by arbitrary rules.

---

# 📂 Suggested Repository Structure

```text
scenario-based-architecture-selection/
│
├── README.md
│
├── scenarios/
│   ├── small-app.md
│   ├── medium-app.md
│   ├── complex-business-logic.md
│   ├── navigation-heavy.md
│   ├── highly-testable.md
│   ├── large-scale-app.md
│   └── state-heavy.md
│
├── architectures/
│   ├── mvc.md
│   ├── mvvm.md
│   ├── clean-architecture.md
│   ├── viper.md
│   ├── coordinator.md
│   ├── modular.md
│   └── tca.md
│
└── examples/
    ├── mvc-example/
    ├── mvvm-example/
    ├── clean-example/
    └── modular-example/
```

---

# 🎯 Final Takeaway

There is **no universally best architecture**.

The right architecture depends on the problem you are solving.

```text
Requirements
     ↓
Complexity
     ↓
Team & Scale
     ↓
Testing Needs
     ↓
Expected Change
     ↓
Architecture Selection
```

The objective is not to build the most sophisticated architecture.

> **Build the simplest architecture that can comfortably handle the current problem and expected growth.**

---

## 📚 Architecture Decision Record

For every major architecture decision, document:

```text
Context
↓
Problem
↓
Options Considered
↓
Decision
↓
Why?
↓
Trade-offs
↓
Consequences
```

Example:

```text
Decision:
Use MVVM + Coordinator.

Context:
Medium-sized SwiftUI application with multiple navigation flows.

Why:
- Good separation of UI and business logic
- Easy unit testing
- Navigation remains independent
- Low architectural overhead

Trade-offs:
- Additional ViewModel and Coordinator abstractions
- More files compared with MVC
```

This makes architecture decisions **intentional, explainable, and reviewable**.
