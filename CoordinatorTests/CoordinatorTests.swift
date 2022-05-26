//
//  CoordinatorTests.swift
//  CoordinatorTests
//
//  Created by Tradesocio on 26/05/22.
//

import XCTest
@testable import Coordinator

class CoordinatorTests: XCTestCase {
    var eventDetails : EventListViewController!
    
    override func setUp(){
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.eventDetails = storyboard.instantiateViewController(withIdentifier: "EventListViewController") as? EventListViewController
        
        self.eventDetails.loadView()
        self.eventDetails.viewDidLoad()
        
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHasATableView() {
        XCTAssertNotNil(eventDetails.tblEventList)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(eventDetails.tblEventList.delegate)
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(eventDetails.tblEventList.dataSource)
    }
    
    func testemployeeData() {
        XCTAssertNotNil(eventDetails.viewModel.numberOfRows)
    }
    
    func testmath() {
        XCTAssertEqual(2+3, 5)
    }
    
}
