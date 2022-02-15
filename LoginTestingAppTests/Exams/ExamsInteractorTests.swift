//
//  ExamsInteractorTests: XCTestCase.swift
//  LoginTestingAppTests
//
//  Created by Maximus on 15.02.2022.
//

import XCTest
@testable import LoginTestingApp

class ExamsInteractorTests: XCTestCase {
    
     var sut: ExamInteractor!
     var worker: ExamWorkingLogicSpy!
     var presenter: ExamPresentationLogicSpy!
    
    override func setUp() {
        super.setUp()
        
        let examInteractor = ExamInteractor()
        let examWorker = ExamWorkingLogicSpy()
        let examPresenter = ExamPresentationLogicSpy()
        
        examInteractor.worker = examWorker
        examInteractor.presenter = examPresenter
        
        sut = examInteractor
        worker = examWorker
        presenter = examPresenter
    }
    
    override func tearDown() {
      sut = nil
      worker = nil
      presenter = nil
      
      super.tearDown()
    }
    
    
    func testFetchExams() {
        let request = ExamModels.FetchExams.Request()
        sut.fetchExams(request, sortBy: .server)
        XCTAssertTrue(worker.isCalledFetchExams, "Doesnt not call workers fetch exams")
        XCTAssertTrue(presenter.isCalledPresentFetchedUsers, "Odesnt not call presenter fetchedUsers")
        XCTAssertEqual(sut.exams.count, worker.exams.count)
        
    }
    
    func testSelectExam() {
        let expectationId = "2"
        let expectaionTitle = "Second"
        
        let exams: [Exam] = [
            Exam(id: "1", title: "One", text: "One One", image: "", sort: 2, date: ""),
            Exam(id: "2", title: "Second", text: "Two Two", image: "", sort: 2, date: "")
        ]
        
        let request = ExamModels.SelectExam.Request(index: 1)
        
        sut.exams = exams
        sut.selectExam(request)
        XCTAssertNotNil(sut.selectedExam, "Not selected")
        XCTAssertEqual(sut.selectedExam?.id, expectationId)
        XCTAssertEqual(sut.selectedExam?.title, expectaionTitle)
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
