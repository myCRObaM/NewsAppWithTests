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
            let mockedDetailsViewControllerDelegate = MockDetailsNavigationDelegate()
            let mockedFavoritesButton = MockButtonPressDelegate()
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
                Cuckoo.stub(mockedDetailsViewControllerDelegate){ mock in
                    when(mock.openDetailsView(news: any())).thenDoNothing()
                    
                }
                Cuckoo.stub(mockedFavoritesButton){ mock in
                    when(mock.buttonIsPressed(new: any())).thenDoNothing()
                }
            }
            context("Initialize viewModel"){
                var spinnerSubject: TestableObserver<LoaderEnum>!
                var favoritesChanged: TestableObserver<[IndexPath]>!
                beforeEach {
                    testScheduler = TestScheduler(initialClock: 1)
                    viewModel = TableViewModel(dataRepository: mockArticleRepository, scheduler: testScheduler)
                    
                    let input = TableViewModel.Input(changeFavoriteSubject: PublishSubject<Article>(), detailsViewControllerSubject: PublishSubject<IndexPath>(), getNewsSubject: PublishSubject<Bool>())
                    
                    let output = viewModel.transform(input: input)
                    for disposable in output.disposables {
                        disposable.disposed(by: disposeBag)
                    }
                    
                    spinnerSubject = testScheduler.createObserver(LoaderEnum.self)
                    favoritesChanged = testScheduler.createObserver([IndexPath].self)
                    
                    viewModel.output.favoritesChanged.subscribe(favoritesChanged).disposed(by: disposeBag)
                    viewModel.output.spinnerSubject.subscribe(spinnerSubject).disposed(by: disposeBag)
                }
                it("Check if its equal to the local array"){
                    testScheduler.start()
                    viewModel.input.getNewsSubject.onNext(true)
                    expect(viewModel.newsloaded.count).toEventually(equal(newsArray.count))
                }
                it("Check if spinner is running"){
                    testScheduler.start()
                    viewModel.input.getNewsSubject.onNext(true)
                    expect(spinnerSubject.events.count).toEventually(equal(2))
                    expect(spinnerSubject.events[0].value.element).toEventually(equal(.addLoader))
                    expect(spinnerSubject.events[1].value.element).toEventually(equal(.removeLoader))
                }
                it("Check the functionality of adding favorites"){
                    testScheduler.start()
                    viewModel.newsloaded = newsArray
                    viewModel.input.changeFavoriteSubject.onNext(newsArray[0])
                    expect(favoritesChanged.events.count).toEventually(equal(1))
                }
                it("Check the functionality of opening DetailsViewController"){
                    testScheduler.start()
                    viewModel.newsloaded = newsArray
                    viewModel.selectedDetailsDelegate = mockedDetailsViewControllerDelegate
                    viewModel.input.detailsViewControllerSubject.onNext(IndexPath(item: 0, section: 0))
                    verify(mockedDetailsViewControllerDelegate).openDetailsView(news: any())
                }
                it("Check button Press delegate"){
                    testScheduler.start()
                    viewModel.newsloaded = newsArray
                    viewModel.buttonPressDelegate = mockedFavoritesButton
                    viewModel.buttonPressDelegate?.buttonIsPressed(new: newsArray[0])
                    verify(mockedFavoritesButton).buttonIsPressed(new: any())
                }
            }
        }
    }
}
