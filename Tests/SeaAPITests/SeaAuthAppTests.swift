import XCTest
@testable import SeaAPI

class SeaAuthAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetOAuthUrl() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = SeaAuthApp(baseUrl: URL(string: "https://example.com/sea/")!, credential: .init(id: "id", secret: "secret"))
        XCTAssertEqual(app.getOAuthUrl().absoluteString, "https://example.com/sea/oauth/authorize?client_id=id&response_type=code")
        XCTAssertEqual(app.getOAuthUrl(state: "状態").absoluteString, "https://example.com/sea/oauth/authorize?client_id=id&response_type=code&state=%E7%8A%B6%E6%85%8B")
    }
    
    static var allTests = [
        ("testGetOAuthUrl", testGetOAuthUrl),
    ]
}
