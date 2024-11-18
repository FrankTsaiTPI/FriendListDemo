//
//  InitialViewModelTest.swift
//  FriendListDemoTests
//
//  Created by Tsai Frank on 2024/11/13.
//

import XCTest
import Combine
@testable import FriendListDemo

final class InitialViewModelTest: XCTestCase {
    
    var viewModel: InitialViewModel!
    var mockNetworkManager: MockNetworkManager!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        
        mockNetworkManager = MockNetworkManager()
        viewModel = .init(networkManager: mockNetworkManager)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables = nil
        mockNetworkManager = nil
        
        super.tearDown()
    }
    
    func testPageTypeItemValue() {
        let expectation = self.expectation(description: "page type item value data")
        viewModel.inputs.fetchPageTypeItems()
        
        let pageTypeItems = viewModel.outputs.pageTypeItemValue
        if let pageTypeItem = pageTypeItems.first {
            XCTAssertEqual(pageTypeItem.title, "無好友")
            XCTAssertEqual(pageTypeItem.pageType, .NoFriend)
            expectation.fulfill()
            wait(for: [expectation], timeout: 5)
        }
    }
    
    func testFetchPageTypeItems() {
        let expectation = self.expectation(description: "Fetch page type items")
        
        viewModel.outputs.pageTypeItemsPublisher
            .sink { items in
                if let item = items.first {
                    XCTAssertEqual(item.title, "無好友")
                    XCTAssertEqual(item.pageType, .NoFriend)
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        viewModel.inputs.fetchPageTypeItems()
        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchNoFriends() {
        let expectation = self.expectation(description: "Fetch no friend data")
        viewModel.outputs.manAndFriendPublisher
            .sink { manModel, friendModel in
                if let man = manModel.first, friendModel.isEmpty {
                    XCTAssertEqual(man.name, "蔡國泰")
                    expectation.fulfill()
                }  
        }.store(in: &cancellables)
        
        viewModel.inputs.fetchFriendList(pageType: .NoFriend)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchNoFriendsError() {
        mockNetworkManager.shouldReturnError = true
        let expectation = self.expectation(description: "Fetch no friend data error")
        viewModel.outputs.errorPublisher
            .sink { error in
                XCTAssertEqual(error.localizedDescription, "error")
                expectation.fulfill()
        }.store(in: &cancellables)
        
        viewModel.inputs.fetchFriendList(pageType: .NoFriend)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchFriendWithoutInvite() {
        let expectation = self.expectation(description: "fetch friend without invite data")
        viewModel.outputs.manAndFriendPublisher
            .sink { manModel, friendModel in
                if let man = manModel.first, !friendModel.isEmpty {
                    XCTAssertEqual(man.name, "蔡國泰")
                    expectation.fulfill()
                }
        }.store(in: &cancellables)
        
        viewModel.inputs.fetchFriendList(pageType: .FriendWithoutInvite)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchFriendWithoutInviteError() {
        mockNetworkManager.shouldReturnError = true
        let expectation = self.expectation(description: "fetch friend without invite data error")
        viewModel.outputs.errorPublisher
            .sink { error in
                XCTAssertEqual(error.localizedDescription, "error")
                expectation.fulfill()
        }.store(in: &cancellables)
        
        viewModel.inputs.fetchFriendList(pageType: .FriendWithoutInvite)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchFriendWithInvite() {
        let expectation = self.expectation(description: "fetch friend with invite data")
        viewModel.outputs.manAndFriendPublisher
            .sink { manModel, friendModel in
                if let man = manModel.first, !friendModel.isEmpty {
                    XCTAssertEqual(man.name, "蔡國泰")
                    expectation.fulfill()
                }
        }.store(in: &cancellables)
        
        viewModel.inputs.fetchFriendList(pageType: .FriendWithInvite)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchFriendWithInviteError() {
        mockNetworkManager.shouldReturnError = true
        let expectation = self.expectation(description: "fetch friend with invite data error")
        viewModel.outputs.errorPublisher
            .sink { error in
                XCTAssertEqual(error.localizedDescription, "error")
                expectation.fulfill()
        }.store(in: &cancellables)
        
        viewModel.inputs.fetchFriendList(pageType: .FriendWithInvite)
        
        wait(for: [expectation], timeout: 5)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
