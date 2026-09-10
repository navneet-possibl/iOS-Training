# Unit Test Coverage & Edge Cases

## Focus


- Unit test coverage
- Happy-path testing
- Edge-case testing
- Failure-path testing
- Boundary testing
- Branch coverage
- Testing state transitions
- Measuring code coverage in Xcode
- Understanding the difference between code coverage and test quality

The goal is not simply to achieve a high coverage percentage, but to verify important application behavior.

---

## Project Architecture

Our current Clean Architecture flow is:

```text
SwiftUI View
     ↓
UserViewModel
     ↓
GetUsersUseCase
     ↓
UserRepository
     ↓
APIClient
     ↓
API
```

For unit tests, dependencies are replaced with mocks:

```text
UserViewModel
     ↓
MockGetUsersUseCase
```

```text
GetUsersUseCaseImpl
     ↓
MockUserRepository
```

```text
UserRepositoryImpl
     ↓
MockAPIClient
```

This allows every layer to be tested independently without making real network requests.

---

# 1. What is Unit Test Coverage?

Code coverage tells us which parts of our production code are executed while running tests.

For example:

```text
20 executable lines
15 lines executed by tests

Coverage = 75%
```

Common coverage measurements include:

- Line coverage
- Function/method coverage
- File coverage
- Branch coverage

However:

> 100% code coverage does not mean the code is bug-free.

A test can execute a line without actually verifying that the behavior is correct.

### Coverage vs Testing

```text
Coverage
    ↓
Did the test execute this code?

Testing
    ↓
Did the test verify the behavior?
```

Both are important.

---

# 2. Why Edge Cases Matter

An edge case is an unusual, boundary, empty, unexpected, or failure situation.

For our Users application, examples include:

```text
Normal:
API returns users

Edge cases:
API returns zero users
API returns one user
API returns many users
API request fails
Two users have the same name
Names use different casing
Repository returns an error
ViewModel is asked to load while already loading
```

Good unit tests should cover important behavior, not just the happy path.

---

# 3. Repository Testing

The repository is responsible for getting DTOs from the API client and converting them into domain `User` objects.

The repository test replaces the real API client with:

```text
MockAPIClient
```

### Success case

```text
MockAPIClient
      ↓
[UserDTO]
      ↓
UserRepositoryImpl
      ↓
[User]
```

### Failure case

```text
MockAPIClient
      ↓
Error
      ↓
UserRepositoryImpl
      ↓
Error propagated
```

### Important repository scenarios

- Successful API response
- Empty response
- Single user
- Many users
- API failure
- DTO → Domain conversion

---

# 4. Use Case Testing

`GetUsersUseCaseImpl` contains application/business logic.

The current Use Case sorts users by name before returning them.

```text
Repository
    ↓
Unsorted Users
    ↓
GetUsersUseCase
    ↓
Sorted Users
```

### Test scenarios

- Users are returned
- Users are sorted by name
- Empty array is handled
- One user is handled
- Users with the same name are handled
- Different letter casing is handled
- Repository errors are propagated

The important principle is:

> Test the behavior introduced by the Use Case, not just whether data exists.

---

# 5. ViewModel Testing

The `UserViewModel` manages UI state:

```text
users
isLoading
errorMessage
```

### Initial state

```text
users = []
isLoading = false
errorMessage = nil
```

### Success state

```text
users = returned users
isLoading = false
errorMessage = nil
```

### Failure state

```text
users = []
isLoading = false
errorMessage = error description
```

### Important ViewModel scenarios

- Initial state
- Successful loading
- Empty response
- Loading failure
- Error message is set
- Loading finishes after success
- Loading finishes after failure
- Duplicate loading requests are prevented

---

# 6. Testing Branches

Consider:

```swift
if condition {
    // Branch A
} else {
    // Branch B
}
```

Testing only one branch does not provide complete behavioral coverage.

We should test:

```text
condition = true
condition = false
```

For our ViewModel:

```swift
guard !isLoading else {
    return
}
```

This creates two paths:

```text
Not loading
    ↓
Continue loading

Already loading
    ↓
Return
```

Both paths are worth testing.

---

# 7. Boundary Testing

Boundary testing checks behavior around important limits.

For our Users API:

```text
0 users
1 user
many users
```

These cases are more useful than testing only:

```text
10 users
```

because empty and minimum-size responses often expose bugs.

---

# 8. Empty Data Testing

An empty API response should not automatically be treated as an error.

Example:

```swift
apiClient.result = [UserDTO]()
```

Expected:

```swift
users.isEmpty == true
```

This verifies that the application can safely handle:

```text
API → []
```

without crashing.

---

# 9. Failure Testing

External dependencies can fail.

Our mocks allow us to simulate failures:

```swift
mock.error = TestError.networkError
```

Then we verify that the error is handled correctly.

### Repository

```text
API error
    ↓
Repository
    ↓
Error
```

### Use Case

```text
Repository error
    ↓
Use Case
    ↓
Error
```

### ViewModel

```text
Use Case error
    ↓
ViewModel
    ↓
errorMessage
```

This gives us a complete failure path without using the real network.

---

# 10. Test Doubles

Our test target uses mocks to replace production dependencies.

```text
TestError.swift
MockAPIClient.swift
MockUserRepository.swift
MockGetUsersUseCase.swift
```

### Mock API Client

Used when testing:

```text
UserRepositoryImpl
```

### Mock Repository

Used when testing:

```text
GetUsersUseCaseImpl
```

### Mock Use Case

Used when testing:

```text
UserViewModel
```

This keeps unit tests isolated and deterministic.

---

# 11. What Should Be Covered?

| Layer | Important Scenarios |
|---|---|
| UserDTO | DTO → Domain mapping |
| Repository | Success, empty, failure, mapping |
| Use Case | Sorting, empty, failure, edge cases |
| ViewModel | Initial state, success, empty, failure, loading |
| UI | Tested separately with UI tests |

The goal is high coverage of important behavior rather than blindly testing every line.

---

# 12. Code Coverage in Xcode

To inspect coverage:

```text
Product
   ↓
Scheme
   ↓
Edit Scheme
   ↓
Test
   ↓
Options
   ↓
Enable Code Coverage
```

Enable coverage for:

```text
CleanArchitecture
```

Then run:

```text
⌘ + U
```

Review the test report and coverage information.

---

# 13. Coverage Targets

Coverage targets depend on the project and team.

For learning purposes, a useful goal is:

```text
Domain / Use Cases       → 90–100%
Repositories             → 90%+
ViewModels               → 85–100%
DTO mapping              → 90%+
UI                       → Separate UI tests
```

These are practical targets, not absolute rules.

A high percentage is useful only when the tests actually verify meaningful behavior.

---

# 14. Questions to Ask When Writing Tests

For every method, ask:

### 1. Happy path

What happens when everything works?

### 2. Empty

What happens when I receive nothing?

### 3. Failure

What happens when a dependency fails?

### 4. Boundary

What happens at the minimum or maximum?

### 5. Unexpected data

What happens with unusual input?

### 6. Repeated action

What happens if the method is called twice?

### 7. State transition

What happens before, during, and after the operation?

These questions help discover useful test cases.

---

# 15. Current Test Structure

```text
CleanArchitectureTests
│
├── Mocks
│   ├── TestError.swift
│   ├── MockAPIClient.swift
│   ├── MockUserRepository.swift
│   └── MockGetUsersUseCase.swift
│
├── DTOs
│   └── UserDTOTests.swift
│
├── Repositories
│   └── UserRepositoryTests.swift
│
├── UseCases
│   └── GetUsersUseCaseTests.swift
│
└── ViewModel
    └── UserViewModelTests.swift
```

---

# 16. Key Takeaways

- Code coverage shows which code is executed by tests.
- High coverage does not automatically mean high-quality tests.
- Edge cases are essential for reliable software.
- Empty responses should be tested.
- Failure paths should be tested.
- Boundary conditions should be tested.
- Important branches should be covered.
- Mocks allow us to test failures without a real API.
- Each Clean Architecture layer can be tested independently.
- Test behavior, not just code execution.
- Coverage should be used as a tool, not as the only quality metric.

---

# Interview Summary

> **Unit test coverage tells us how much of our code is executed by tests, while edge-case testing verifies that the application behaves correctly under unusual, boundary, empty, repeated, and failure conditions. I focus on meaningful behavioral coverage rather than simply trying to reach 100%. In Clean Architecture, dependency injection and mocks allow me to test each layer independently without relying on real network services.**

---

# Day 15 Checklist

- [x] Understand unit test coverage
- [x] Understand line and branch coverage
- [x] Understand edge cases
- [x] Test happy paths
- [x] Test empty responses
- [x] Test failure paths
- [x] Test boundary cases
- [x] Test Use Case business logic
- [x] Test ViewModel state
- [x] Use mocks for dependencies
- [x] Understand coverage vs test quality
- [ ] Review Code Coverage in Xcode
- [ ] Add remaining edge-case tests
