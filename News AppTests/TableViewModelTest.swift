//
//  RequestTest.swift
//  News AppTests
//
//  Created by Matej Hetzel on 07/08/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import XCTest
import Cuckoo
import Quick
import Nimble
import RxSwift
import RxTest
@testable import News_App

class TableViewModelTest: QuickSpec {
    
        override func spec() {
                    describe("Json data to array"){
                        var viewModel: TableViewModelProtocol!
                        let mockArticleRepository = MockArticleRepository()
                        let mockRealmManager = MockRealmManager()
                        var newsArray = [Article]()
                        let disposeBag = DisposeBag()
                        var testScheduler: TestScheduler!
                        beforeSuite {
                            Cuckoo.stub(mockArticleRepository){ mock in
                                let testBunde = Bundle(for: TableViewModelTest.self)
                                guard let path = testBunde.url(forResource: "TestJson", withExtension: "json") else {return}
                                let dataFromLocation = try! Data(contentsOf: path)
                                let article = try! JSONDecoder().decode(News.self, from: dataFromLocation)
                                
                                when(mock.alamofireRequest()).thenReturn(Observable.just(article.articles))
                                newsArray = article.articles
                            }
                        }
                        context("Initialize viewModel"){
                            var spinnerSubject: TestableObserver<LoaderEnum>!
                            beforeEach {
                                testScheduler = TestScheduler(initialClock: 1)
                                viewModel = TableViewModel(dataRepository: mockArticleRepository, scheduler: testScheduler)
                                viewModel.getData(subject: viewModel.getNewsSubject).disposed(by: disposeBag)
                                viewModel.changeFavorite(subject: viewModel.changeFavoriteSubject).disposed(by: disposeBag)
                                spinnerSubject = testScheduler.createObserver(LoaderEnum.self)
                                viewModel.spinnerSubject.subscribe(spinnerSubject).disposed(by: disposeBag)
                            }
                            it("Check if its equal to the local array"){
                                testScheduler.start()
                                viewModel.getNewsSubject.onNext(true)
                                expect(viewModel.newsloaded.count).toEventually(equal(newsArray.count))
                            }
                            
                            it("Check is spinner running"){
                                testScheduler.start()
                                viewModel.getNewsSubject.onNext(true)
                                expect(spinnerSubject.events.count).toEventually(equal(2))
                                expect(spinnerSubject.events[0].value.element).toEventually(equal(.addLoader))
                                expect(spinnerSubject.events[1].value.element).toEventually(equal(.removeLoader))
                            }
                        }
                    }
    
        }
}
