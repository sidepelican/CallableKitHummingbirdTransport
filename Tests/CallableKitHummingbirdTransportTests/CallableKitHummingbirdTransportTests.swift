import CallableKit
import CallableKitHummingbirdTransport
import Hummingbird
import HummingbirdTesting
import XCTest

@Callable
public protocol TestServiceProtocol {
    func hello(name: String) async throws -> String
}

struct TestService: TestServiceProtocol {
    func hello(name: String) async throws -> String {
        "Hello, \(name)!"
    }
}

final class CallableKitHummingbirdTransportTests: XCTestCase {
    func testExample() async throws {
        let router = Router()
        configureTestServiceProtocol(transport: HummingbirdTransport(router: router) { _, _ in
            TestService()
        })

        let app = Application(router: router)
        try await app.test(.router) { client in
            try await client.execute(
                uri: "/Test/hello",
                method: .post,
                body: .init(string: """
                "Hummingbird"
                """)
            ) { response in
                XCTAssertEqual(response.status, .ok)
                XCTAssertEqual(String(buffer: response.body), """
                "Hello, Hummingbird!"
                """)
            }
        }
    }
}
