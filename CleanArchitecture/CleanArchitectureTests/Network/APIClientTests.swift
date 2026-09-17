//
//  APIClientTests.swift
//  CleanArchitecture
//
//  Created by HIMANK on 16/09/26.
//

import XCTest
@testable import CleanArchitecture

final class APIClientTests: XCTestCase {

    private let url = URL(string: "https://jsonplaceholder.typicode.com/users")!

    func test_get_success_decodesUsers() async throws {
        let session = MockURLSession()
        session.data = validUsersJSON
        session.response = httpResponse(statusCode: 200)

        let client = APIClient(session: session)
        let users: [UserDTO] = try await client.get([UserDTO].self, from: url)

        XCTAssertEqual(session.requestedURL, url)
        XCTAssertEqual(users.count, 1)
        XCTAssertEqual(users.first?.id, 1)
        XCTAssertEqual(users.first?.name, "John")
        XCTAssertEqual(users.first?.email, "john@example.com")
    }

    func test_get_invalidResponse_throwsInvalidResponse() async {
        let session = MockURLSession()
        session.data = Data()
        session.response = URLResponse(
            url: url,
            mimeType: nil,
            expectedContentLength: 0,
            textEncodingName: nil
        )

        let client = APIClient(session: session)

        do {
            _ = try await client.get([UserDTO].self, from: url)
            XCTFail("Expected APIError.invalidResponse")
        } catch let error as APIError {
            XCTAssertEqual(error, .invalidResponse)
            XCTAssertEqual(error.localizedDescription, "The server returned an invalid response.")
        } catch {
            XCTFail("Expected APIError.invalidResponse, got \(error)")
        }
    }

    func test_get_httpStatus_throwsHTTPStatus() async {
        let session = MockURLSession()
        session.data = Data()
        session.response = httpResponse(statusCode: 500)

        let client = APIClient(session: session)

        do {
            _ = try await client.get([UserDTO].self, from: url)
            XCTFail("Expected APIError.httpStatus(500)")
        } catch let error as APIError {
            XCTAssertEqual(error, .httpStatus(500))
            XCTAssertEqual(error.localizedDescription, "The server returned HTTP status 500.")
        } catch {
            XCTFail("Expected APIError.httpStatus(500), got \(error)")
        }
    }

    func test_get_invalidJSON_throwsDecodingError() async {
        let session = MockURLSession()
        session.data = Data("not-json".utf8)
        session.response = httpResponse(statusCode: 200)

        let client = APIClient(session: session)

        do {
            _ = try await client.get([UserDTO].self, from: url)
            XCTFail("Expected APIError.decodingError")
        } catch let error as APIError {
            XCTAssertEqual(error, .decodingError)
            XCTAssertEqual(
                error.localizedDescription,
                "The server returned data in an unexpected format."
            )
        } catch {
            XCTFail("Expected APIError.decodingError, got \(error)")
        }
    }

    func test_get_emptyJSONArray_returnsEmptyUsers() async throws {
        let session = MockURLSession()
        session.data = Data("[]".utf8)
        session.response = httpResponse(statusCode: 200)

        let client = APIClient(session: session)
        let users: [UserDTO] = try await client.get([UserDTO].self, from: url)

        XCTAssertTrue(users.isEmpty)
    }

    func test_invalidURLErrorDescription() {
        XCTAssertEqual(APIError.invalidURL.localizedDescription, "The URL is invalid.")
    }

    private func httpResponse(statusCode: Int) -> HTTPURLResponse {
        HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
    }

    private var validUsersJSON: Data {
        Data("""
        [
            {
                "id": 1,
                "name": "John",
                "email": "john@example.com"
            }
        ]
        """.utf8)
    }
}
