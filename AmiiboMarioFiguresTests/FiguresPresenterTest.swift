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

    func showFiguresData(figures: [Figure]) {
        // Given
        let actualFigures = figures
        
        let expectedFigures = TestConstants.response.amiibo

        // Verify
        XCTAssert(actualFigures == expectedFigures)
        
        didCallShowData = true
    }
    
    func configure(presenter: FiguresViewPresenter) { }
    
    func showMessage(message: String) { }
}

class NavigationControllerMock: UINavigationController { }

class CoordinatorMock: AppCoordinator {
    
    var didCallNavigateToDetails = false

    override func navigateToDetails(figure: Figure) {
        // Given
        let actualFigure = figure
        
        let expectedFigure = TestConstants.figure

        // Verify
        XCTAssert(actualFigure.amiiboSeries == expectedFigure.amiiboSeries)
        XCTAssert(actualFigure.character == expectedFigure.character)
        XCTAssert(actualFigure.gameSeries == expectedFigure.gameSeries)
        XCTAssert(actualFigure.imageUrl == expectedFigure.imageUrl)
        XCTAssert(actualFigure.name == expectedFigure.name)
        XCTAssert(actualFigure.release.au == expectedFigure.release.au)
        XCTAssert(actualFigure.release.na == expectedFigure.release.na)
        XCTAssert(actualFigure.release.eu == expectedFigure.release.eu)
        XCTAssert(actualFigure.release.jp == expectedFigure.release.jp)

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
        XCTAssert(actualMethod == Router.getFigures.method)
        XCTAssert(actualScheme == Router.getFigures.scheme)
        XCTAssert(actualHost == Router.getFigures.host)
        XCTAssert(actualPath == Router.getFigures.path)
        XCTAssert(actualParameters == Router.getFigures.parameters)

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
        XCTAssert(service?.didCallRequest == true, "request() should have been called")
        XCTAssert(view?.didCallShowData == true, "showFiguresData() should have been called")
    }
    
    func testNavigateToDetails() throws {
        
        // Given
        let figure = TestConstants.figure
        
        // When
        presenter?.navigateToDetails(figure: figure)
        
        // Verify
        XCTAssert(coordinator?.didCallNavigateToDetails == true, "navigateToDetails() should have been called")
    }
    
}
