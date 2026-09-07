# XCTest Framework & Unit Testing Basics

## 1. What is Unit Testing?

Unit testing is the process of testing small, independent parts of an application, such as functions, methods, or classes.

The main purpose is to verify that the code works as expected and to catch bugs early.

### Example

```swift
func add(_ a: Int, _ b: Int) -> Int {
    return a + b
}
```

We can test it with:

```swift
XCTAssertEqual(add(2, 3), 5)
```

---

## 2. What is XCTest?

`XCTest` is Apple's testing framework used to write and run automated tests for Swift and iOS applications.

To use XCTest:

```swift
import XCTest
```

A test class generally inherits from `XCTestCase`.

```swift
final class CalculatorTests: XCTestCase {
    
}
```

---

## 3. @testable import

`@testable import` allows the test target to access internal code from the application module.

```swift
@testable import MyApp
```

Example:

```swift
import XCTest
@testable import MyApp

final class CalculatorTests: XCTestCase {

}
```

---

## 4. Writing a Test

A test method starts with `test`.

```swift
func testAddition() {
    let calculator = Calculator()

    let result = calculator.add(2, 3)

    XCTAssertEqual(result, 5)
}
```

### Basic flow

```text
Arrange → Act → Assert
```

### Arrange

Prepare the objects and data required for the test.

### Act

Execute the functionality being tested.

### Assert

Verify that the actual result matches the expected result.

---

## 5. XCTest Assertions

Assertions are used to verify expected results.

### XCTAssertEqual

Checks whether two values are equal.

```swift
XCTAssertEqual(result, 5)
```

### XCTAssertNotEqual

Checks whether two values are different.

```swift
XCTAssertNotEqual(result, 10)
```

### XCTAssertTrue

Checks whether a condition is true.

```swift
XCTAssertTrue(isValid)
```

### XCTAssertFalse

Checks whether a condition is false.

```swift
XCTAssertFalse(isValid)
```

### XCTAssertNil

Checks whether a value is `nil`.

```swift
XCTAssertNil(user)
```

### XCTAssertNotNil

Checks whether a value is not `nil`.

```swift
XCTAssertNotNil(user)
```

### XCTAssert

Checks a general Boolean condition.

```swift
XCTAssert(age >= 18)
```

---

## 6. setUp()

`setUp()` is executed before each test.

It is useful for creating common objects or preparing test data.

```swift
override func setUp() {
    super.setUp()

    calculator = Calculator()
}
```

---

## 7. tearDown()

`tearDown()` is executed after each test.

It is commonly used to clean up or reset objects.

```swift
override func tearDown() {
    calculator = nil

    super.tearDown()
}
```

### Flow

```text
setUp()
   ↓
Test Method
   ↓
tearDown()
```

This happens independently for each test.

---

## 8. Testing Edge Cases

Tests should not only cover normal situations. We should also test invalid and boundary conditions.

For example:

```swift
func divide(_ a: Int, by b: Int) -> Int? {
    guard b != 0 else {
        return nil
    }

    return a / b
}
```

Normal case:

```swift
XCTAssertEqual(divide(10, by: 2), 5)
```

Edge case:

```swift
XCTAssertNil(divide(10, by: 0))
```

Important cases to consider:

- Normal input
- Empty input
- Zero
- Negative values
- Boundary values
- Invalid input
- Unexpected conditions

---

## 9. Test Naming

Test names should clearly explain what is being tested and what is expected.

Good:

```swift
func testLoginWithValidCredentialsReturnsSuccess()
```

```swift
func testWithdrawalGreaterThanBalanceFails()
```

Less descriptive:

```swift
func testLogin()
```

A good test name makes it easier to understand why a test failed.

---

## 10. Unit Tests vs UI Tests

### Unit Tests

Used to test individual pieces of application logic.

Examples:

- Functions
- View models
- Validators
- Calculations
- Data transformations
- Business logic

Unit tests are generally fast and isolated.

### UI Tests

Used to test the application through the user interface.

Example:

```text
Launch App
   ↓
Tap Login
   ↓
Enter Username
   ↓
Enter Password
   ↓
Tap Login
   ↓
Verify Home Screen
```

---

## 11. Example — Calculator Tests

Production code:

```swift
struct Calculator {

    func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    }

    func subtract(_ a: Int, _ b: Int) -> Int {
        return a - b
    }
}
```

Test:

```swift
import XCTest
@testable import MyApp

final class CalculatorTests: XCTestCase {

    var calculator: Calculator!

    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }

    override func tearDown() {
        calculator = nil
        super.tearDown()
    }

    func testAddition() {
        let result = calculator.add(2, 3)

        XCTAssertEqual(result, 5)
    }

    func testSubtraction() {
        let result = calculator.subtract(5, 2)

        XCTAssertEqual(result, 3)
    }
}
```

---

## 12. Best Practices

- Keep tests small and focused.
- Test one behavior at a time.
- Use meaningful test names.
- Keep tests independent from each other.
- Test both success and failure cases.
- Test edge cases.
- Avoid unnecessary dependencies.
- Follow Arrange → Act → Assert.
- Tests should be repeatable and predictable.

---

