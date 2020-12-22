//
//  FiguresPresenterTest.swift
//  AmiiboMarioFiguresTests
//
//  Created by Sergey on 22.12.20.
//

import XCTest
@testable import AmiiboMarioFigures

class TestConstants {
    
    private init() {}
    
    static let figure = Figure(amiiboSeries: "Test", character: "Test", gameSeries: "Test", imageUrl: "Test", name: "Test", release: ReleaseDates.init(au: "Test", eu: "", jp: "Test", na: "Test"), type: "Test")
    
    static let response = FiguresResponse(amiibo: [figure])
}

class FiguresViewMock: FiguresView {
    
    var didCallShowData = false
    var didCallShowMessage = false

    func showFiguresData(figures: [Figure]) {
        // Given
        let actualFigures = figures
        
        let expectedFigures = TestConstants.response.amiibo

        // Verify
        XCTAssert(actualFigures == expectedFigures)
        
        didCallShowData = true
    }
    
    func showMessage(message: String) {
        didCallShowMessage = true
    }
    
    func configure(presenter: FiguresViewPresenter) { }
    
}

class NavigationControllerMock: UINavigationController { }

class CoordinatorMock: AppCoordinator {
    
    var didCallNavigateToDetails = false

    override func navigateToDetails(figure: Figure) {
        // Given
        let actualFigure = figure
        
        let expectedFigure = TestConstants.figure

        // Verify
        XCTAssertEqual(actualFigure, expectedFigure)

        didCallNavigateToDetails = true
    }
}

class ServiceMock : ServiceLayer {
    
    var didCallRequest = false
    
    override func request<T: Codable>(router: Router, completion: @escaping (Result<T>) -> Void) {
        // Given
        let actualMethod = router.method
        let actualScheme = router.scheme
        let actualHost = router.host
        let actualPath = router.path
        let actualParameters = router.parameters

        // Verify
        XCTAssertEqual(actualMethod, Router.getFigures.method)
        XCTAssertEqual(actualScheme, Router.getFigures.scheme)
        XCTAssertEqual(actualHost, Router.getFigures.host)
        XCTAssertEqual(actualPath, Router.getFigures.path)
        XCTAssertEqual(actualParameters, Router.getFigures.parameters)

        completion(.success(TestConstants.response as! T))
        
        didCallRequest = true
    }
}

class FiguresPresenterTest: XCTestCase {
    
    var service : ServiceMock?
    var coordinator : CoordinatorMock?
    var view : FiguresViewMock?
    
    var presenter : FiguresViewPresenter?
    
    override func setUpWithError() throws {
        super.setUp()
        service = ServiceMock()
        coordinator = CoordinatorMock(navController: NavigationControllerMock())
        view = FiguresViewMock()
        
        presenter = FiguresPresenter(view: view!, coordinator: coordinator!, service: service!)
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testFetchFigures() throws {
        
        // When
        presenter?.getFiguresData()
        
        // Verify
        XCTAssertEqual(service?.didCallRequest, true, "request() should have been called")
        XCTAssertEqual(view?.didCallShowData, true, "showFiguresData() should have been called")
        XCTAssertNotEqual(view?.didCallShowMessage, true, "didCallShowMessage() shouldn't have been called")
    }
    
    func testNavigateToDetails() throws {
        
        // Given
        let figure = TestConstants.figure
        
        // When
        presenter?.navigateToDetails(figure: figure)
        
        // Verify
        XCTAssertEqual(coordinator?.didCallNavigateToDetails, true, "showFiguresData() should have been called")
    }
    
}
