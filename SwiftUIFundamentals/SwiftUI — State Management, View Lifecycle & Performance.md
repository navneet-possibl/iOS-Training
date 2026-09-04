# SwiftUI — State Management, View Lifecycle & Performance

## Today's Topics

- SwiftUI State Management
- Property Wrappers
- Data Flow
- View Lifecycle
- View Identity
- `body` Evaluation
- `onAppear` / `onDisappear`
- Task Lifecycle
- State Ownership
- Performance Optimization
- Common Performance Mistakes

---

# 1. SwiftUI State Management

SwiftUI is fundamentally **state-driven**.

The core idea is:

```text
State
  ↓
View
  ↓
UI
```

When state changes:

```text
State changes
     ↓
SwiftUI invalidates affected views
     ↓
body is evaluated
     ↓
SwiftUI determines what changed
     ↓
UI is updated
```

We don't manually update individual UI elements.

---

# 2. What Is State?

State is any data that can affect what the UI displays.

Example:

```swift
@State private var count = 0
```

The UI depends on `count`:

```swift
Text("Count: \(count)")
```

When:

```swift
count += 1
```

the UI changes automatically.

---

# 3. `@State`

Use `@State` when a view **owns local mutable state**.

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

### Important Rule

```text
@State = State owned by this View
```

The state should generally be private to the view that owns it.

```swift
@State private var isPresented = false
```

---

# 4. `@Binding`

`@Binding` is used when a child view needs to **read and modify state owned by another view**.

Parent:

```swift
struct ParentView: View {

    @State private var isOn = false

    var body: some View {
        ChildView(isOn: $isOn)
    }
}
```

Child:

```swift
struct ChildView: View {

    @Binding var isOn: Bool

    var body: some View {
        Toggle("Enabled", isOn: $isOn)
    }
}
```

### Data Flow

```text
Parent
  │
  │ $isOn
  ↓
Child
  │
  │ modifies binding
  ↓
Parent State
  ↓
UI updates
```

### Mental Model

```text
@State
  ↓
owns the data

@Binding
  ↓
borrows access to the data
```

---

# 5. `@State` vs `@Binding`

| Property | Purpose |
|---|---|
| `@State` | Owns local state |
| `@Binding` | Accesses state owned elsewhere |

Example:

```swift
@State private var username = ""
```

Parent owns the state.

```swift
@Binding var username: String
```

Child receives access to that state.

---

# 6. Observable State

For larger applications, state often needs to be shared across multiple views.

A ViewModel can expose observable state.

Modern SwiftUI can use the Observation framework:

```swift
@Observable
final class UserViewModel {
    var username = ""
    var isLoading = false
}
```

Then a view can observe it:

```swift
struct UserView: View {

    @State private var viewModel = UserViewModel()

    var body: some View {
        VStack {
            Text(viewModel.username)

            Button("Load") {
                viewModel.username = "Nav"
            }
        }
    }
}
```

The important idea is not the property wrapper itself, but **who owns the state and who is allowed to mutate it**.

---

# 7. Single Source of Truth

A major SwiftUI principle:

> **Each piece of state should have a clear owner.**

Avoid this:

```text
Parent has username
      +
Child has another username
      +
ViewModel has another username
```

This can create inconsistent UI.

Prefer:

```text
Single Source of Truth
        ↓
    State Flow
     ↙      ↘
 Parent     Child
```

---

# 8. Unidirectional Data Flow

A clean SwiftUI architecture generally follows:

```text
        State
          ↓
         View
          ↓
      User Action
          ↓
     State Update
          ↓
         View
```

For example:

```swift
Button("Login") {
    viewModel.login()
}
```

The view doesn't manually manipulate ten different UI components.

It triggers an action.

The state changes.

SwiftUI renders the new state.

---

# 9. View Lifecycle

One of the most important things to understand:

> **A SwiftUI View is not a traditional UIKit view object.**

A SwiftUI `View` is a lightweight value that describes UI.

Example:

```swift
struct ProfileView: View {
    var body: some View {
        Text("Profile")
    }
}
```

You should NOT think:

```text
ProfileView object lives forever
```

Instead think:

```text
SwiftUI repeatedly evaluates view descriptions
and manages the actual rendered UI.
```

---

# 10. `body` Is Not "Called Once"

Consider:

```swift
struct CounterView: View {

    @State private var count = 0

    var body: some View {
        print("body evaluated")

        return VStack {
            Text("\(count)")

            Button("Increment") {
                count += 1
            }
        }
    }
}
```

Every relevant state change can cause `body` to be evaluated again.

Therefore:

### DON'T

```swift
var body: some View {
    expensiveCalculation()
    
    return Text("Hello")
}
```

if `expensiveCalculation()` is genuinely expensive and doesn't need to happen during rendering.

### DO

Move expensive work to an appropriate place:

```swift
.task {
    await loadData()
}
```

or a ViewModel/service layer.

---

# 11. `body` Should Be Cheap

Think of:

```swift
var body: some View
```

as a **UI description**, not a place for heavy business logic.

Good:

```swift
var body: some View {
    Text(user.name)
}
```

Potentially problematic:

```swift
var body: some View {
    let result = performHugeCalculation()
    
    return Text(result)
}
```

Better:

```text
View
 ↓
ViewModel
 ↓
Business Logic / Service
```

---

# 12. `onAppear`

`onAppear` executes when a view appears in the UI hierarchy.

```swift
Text("Profile")
    .onAppear {
        print("Profile appeared")
    }
```

Common use cases:

- Initial data loading
- Analytics
- Starting lightweight work
- Preparing UI state

Example:

```swift
.task {
    await viewModel.loadProfile()
}
```

For asynchronous work, `.task` is often preferable.

---

# 13. `onDisappear`

Called when a view disappears.

```swift
Text("Profile")
    .onDisappear {
        print("Profile disappeared")
    }
```

Possible uses:

- Cleanup
- Stop timers
- Stop temporary activity
- Cancel manually managed resources

However, don't assume `onDisappear` means:

> "This screen will never be used again."

SwiftUI may remove and recreate views depending on the hierarchy and identity.

---

# 14. `.task`

SwiftUI provides `.task` for asynchronous work associated with a view.

```swift
.task {
    await viewModel.loadUsers()
}
```

Example:

```swift
struct UserListView: View {

    @State private var viewModel = UserViewModel()

    var body: some View {
        List(viewModel.users) { user in
            Text(user.name)
        }
        .task {
            await viewModel.loadUsers()
        }
    }
}
```

The task is associated with the view's lifecycle.

When the associated view disappears or its identity changes appropriately, SwiftUI can cancel the task.

This makes `.task` useful for view-scoped asynchronous work.

---

# 15. `.task(id:)`

You can make a task restart when a specific value changes.

```swift
.task(id: searchText) {
    await viewModel.search(searchText)
}
```

Conceptually:

```text
searchText changes
       ↓
Previous task cancelled
       ↓
New task starts
```

This can be extremely useful for search and other state-driven async operations.

---

# 16. View Identity

SwiftUI needs to determine:

> "Is this the same view as before, or a different view?"

Identity is important for:

- State preservation
- Animations
- Task lifecycle
- Lists
- Performance

Example:

```swift
ForEach(users) { user in
    UserRow(user: user)
}
```

Each user should have stable identity.

That's why models often conform to:

```swift
Identifiable
```

Example:

```swift
struct User: Identifiable {
    let id: UUID
    let name: String
}
```

---

# 17. Stable Identity

Good:

```swift
ForEach(users) { user in
    UserRow(user: user)
}
```

Potentially problematic:

```swift
ForEach(users.indices, id: \.self) { index in
    UserRow(user: users[index])
}
```

Using indices as identity can become problematic when the collection changes.

Prefer stable model identity whenever possible.

---

# 18. Why View Identity Matters

Consider:

```swift
if isLoggedIn {
    ProfileView()
} else {
    LoginView()
}
```

These are two different branches of the view hierarchy.

SwiftUI uses identity and structure to determine how state should be preserved or recreated.

This affects things such as:

```text
@State
animations
tasks
transitions
```

Understanding identity is essential for debugging "why did my state reset?" issues.

---

# 19. SwiftUI View Lifecycle Mental Model

A simplified lifecycle:

```text
View appears
    ↓
body evaluated
    ↓
UI rendered
    ↓
State changes
    ↓
body evaluated again
    ↓
SwiftUI compares/reconciles UI
    ↓
Only necessary changes applied
```

When removed:

```text
View disappears
    ↓
View-scoped work may be cancelled
    ↓
onDisappear may execute
```

Important:

> `body` evaluation does NOT mean the entire screen is recreated from scratch.

SwiftUI performs reconciliation/diffing to update the underlying UI efficiently.

---

# 20. SwiftUI Performance

SwiftUI performance is largely about avoiding unnecessary work.

The biggest rule:

> **Make view computation cheap and state changes appropriately scoped.**

---

# 21. Avoid Heavy Work in `body`

Avoid:

```swift
var body: some View {
    let data = expensiveDatabaseOperation()

    return List(data) {
        ...
    }
}
```

Instead:

```text
View
 ↓
ViewModel
 ↓
Repository / Service
 ↓
Data
```

---

# 22. Keep State Local

Don't put all application state into one giant object.

Bad architecture:

```text
AppViewModel
 ├── user
 ├── products
 ├── settings
 ├── messages
 ├── cart
 ├── notifications
 └── everything else
```

A change to one area can cause a much larger part of the UI to become invalidated.

Prefer logically scoped state:

```text
User State
Product State
Cart State
Settings State
```

---

# 23. Avoid Unnecessary State

Don't create state for values that can simply be derived.

Instead of:

```swift
@State private var fullName = ""
```

when it can be derived from:

```swift
let firstName: String
let lastName: String
```

use:

```swift
var fullName: String {
    "\(firstName) \(lastName)"
}
```

### Principle

```text
Stored State
    ↓
Only when necessary

Derived Data
    ↓
Calculate from source of truth
```

This reduces synchronization bugs.

---

# 24. Large Lists

Use lazy containers when appropriate.

```swift
LazyVStack {
    ForEach(users) { user in
        UserRow(user: user)
    }
}
```

Instead of eagerly constructing a very large hierarchy.

For scrolling collections:

```swift
ScrollView {
    LazyVStack {
        ForEach(users) { user in
            UserRow(user: user)
        }
    }
}
```

---

# 25. Efficient Images

Large images can cause memory and rendering problems.

Avoid loading huge raw images directly into every list row.

Consider:

```text
Remote Image
      ↓
Downsample / Resize
      ↓
Cache
      ↓
Display
```

For image-heavy lists, caching and appropriate image sizing are especially important.

---

# 26. Avoid Unnecessary View Work

If a view performs expensive calculations every time `body` is evaluated, performance can suffer.

Instead of:

```swift
var body: some View {
    let sortedUsers = users.sorted {
        $0.name < $1.name
    }

    return List(sortedUsers) {
        ...
    }
}
```

For small collections this may be completely fine.

For large or frequently changing datasets, consider moving expensive transformations outside the rendering path:

```text
Data Layer / ViewModel
        ↓
Prepared Data
        ↓
SwiftUI View
```

Optimization should be based on measurement, not fear.

---

# 27. Don't Over-Optimize

SwiftUI's rendering system is designed to handle frequent view updates.

Don't assume:

```text
body runs again
=
entire UI is rebuilt expensively
```

That is not how SwiftUI should be mentally modeled.

First write clear code.

Then measure.

Then optimize the actual bottleneck.

---

# 28. Instruments

For serious performance investigation, use Apple's profiling tools.

Useful areas include:

- Time Profiler
- Allocations
- SwiftUI-related instrumentation
- Memory Graph
- Animation performance

General workflow:

```text
App feels slow
      ↓
Reproduce problem
      ↓
Profile
      ↓
Find actual bottleneck
      ↓
Optimize
      ↓
Profile again
```

---

# 29. Common Performance Mistakes

### Mistake 1 — Heavy work in `body`

```swift
var body: some View {
    performExpensiveWork()
    ...
}
```

### Mistake 2 — One giant observable object

```text
Everything
   ↓
One ViewModel
```

### Mistake 3 — Unstable identity

```swift
ForEach(items.indices, id: \.self)
```

when stable model identity is available.

### Mistake 4 — Unnecessary duplicated state

```text
Source of Truth
      +
Copied State
      +
Another Copy
```

### Mistake 5 — Massive views

A 500-line view containing everything becomes difficult to reason about and optimize.

Break it into meaningful components.

---

# 30. State Management Decision Guide

Ask:

### Does this view own the state?

Use:

```swift
@State
```

### Does a child need to modify parent's state?

Use:

```swift
@Binding
```

### Does multiple UI need shared observable state?

Use an appropriate observable model.

### Is the value derived from existing state?

Don't create another state variable unnecessarily.

### Is it application-wide/environmental state?

Consider environment-based dependency/state injection where appropriate.

---

# 31. Practical Example

Consider a search screen:

```swift
struct SearchView: View {

    @State private var searchText = ""
    @State private var viewModel = SearchViewModel()

    var body: some View {
        List(viewModel.results) { result in
            Text(result.title)
        }
        .searchable(text: $searchText)
        .task(id: searchText) {
            await viewModel.search(searchText)
        }
    }
}
```

The flow is:

```text
User types
    ↓
searchText changes
    ↓
.task(id:) reacts
    ↓
Previous search task can be cancelled
    ↓
New search starts
    ↓
Results update
    ↓
View updates
```

This is a good example of combining:

- State
- Binding
- Observable state
- View lifecycle
- Async work
- Declarative UI

---

# 32. Golden Rules

### State

```text
Give every piece of state a clear owner.
```

### Data Flow

```text
Prefer one source of truth.
```

### View

```text
Keep body simple and cheap.
```

### Lifecycle

```text
Use lifecycle modifiers for lifecycle-related work.
```

### Async

```text
Prefer structured concurrency and view-scoped .task
for appropriate asynchronous work.
```

### Identity

```text
Give dynamic content stable identity.
```

### Performance

```text
Measure first.
Optimize the actual bottleneck.
```

---


# Today's Key Mental Model

The most important concept to remember:

```text
                STATE
                  │
                  ↓
                VIEW
                  │
                  ↓
             UI Rendering
                  │
                  ↓
           User Interaction
                  │
                  ↓
             State Changes
                  │
                  └───────────────┐
                                  ↓
                              VIEW UPDATE
```

And for lifecycle:

```text
View appears
     ↓
body evaluated
     ↓
View rendered
     ↓
State changes
     ↓
body evaluated again
     ↓
SwiftUI reconciles changes
     ↓
View disappears
     ↓
View-scoped work can be cancelled
```

And for performance:

```text
        Keep state scoped
               +
        Keep body cheap
               +
       Use stable identity
               +
      Avoid unnecessary work
               +
          Measure first
               ↓
        Better SwiftUI apps
```

## Final Takeaway

> **SwiftUI isn't about controlling the lifecycle of individual UI objects. It's about managing state and describing what the UI should be for that state.**

Once you understand **state ownership + data flow + identity + lifecycle**, performance becomes much easier to reason about.
