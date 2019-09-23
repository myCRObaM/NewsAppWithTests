//
//  TableViewModel.swift
//  News App
//
//  Created by Matej Hetzel on 29/07/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//


import Foundation
import UIKit
import RxSwift
import RealmSwift


class TableViewModel: TableViewModelProtocol {
    
    
    struct Input {
        let changeFavoriteSubject: PublishSubject<Article>
        let detailsViewControllerSubject: PublishSubject<IndexPath>
        let getNewsSubject: PublishSubject<Bool>
    }
    
    struct Output {
        let requestedArticleSubject: PublishSubject<DataRequestEnum>
        let disposables: [Disposable]
        let favoritesChanged = PublishSubject<[IndexPath]>()
        let spinnerSubject: PublishSubject<LoaderEnum>
    }
    
    struct Dependencies {
        var dataRepository: ArticleRepository
        var realmManager: RealmManager
        var scheduler: SchedulerType
    }
    
    
    
    internal let dependencies: TableViewModel.Dependencies
    internal var input: TableViewModel.Input!
    internal var output: TableViewModel.Output!
    
    
    var saveTime: Int = 0

    var changeFavoriteStateDelegate: FavoriteDelegate?
    
    var buttonPressDelegate: ButtonPressDelegate?
    var selectedDetailsDelegate: DetailsNavigationDelegate?
    var changeFavoriteSubject = PublishSubject<Article>()
    
    var newsloaded = [Article]()
    
    
    func setupFavoriteState(new: [Article], realm: Results<NewsFavorite>)-> [Article] {
        var finishedArray = [Article]()
    
        for (n, newsIndex) in new.enumerated(){
            finishedArray.append(newsIndex)
            for realmIndex in realm{
                if realmIndex.urlToImg == newsIndex.urlToImage {
                    finishedArray[n].isFavorite = true
                }
            }
        }
        return finishedArray
    }
    
    init(dependencies: TableViewModel.Dependencies) {
        self.dependencies = dependencies
        buttonPressDelegate = self
    }
    
    func transform(input: TableViewModel.Input) -> TableViewModel.Output {
        var disposables = [Disposable]()
        self.input = input
        
        disposables.append(changeFavorite(subject: input.changeFavoriteSubject))
        disposables.append(detailsViewControllerOpen(subject: input.detailsViewControllerSubject))
        disposables.append(getData(subject: input.getNewsSubject))
        
        self.output = Output(requestedArticleSubject: PublishSubject(), disposables: disposables, spinnerSubject: PublishSubject())
        
        return output
    }
    
    
    func getData(subject: PublishSubject<Bool>) -> Disposable{
        let articleRepository = ArticleRepository()
        return subject.flatMap({[unowned self] (bool) -> Observable<(Results<NewsFavorite>, [Article])> in
            self.output.spinnerSubject.onNext(.addLoader)
            let observable = Observable.zip(self.dependencies.realmManager.loadRealmData(), articleRepository.alamofireRequest()) { (favorites, news) in
                return (favorites, news)
            }
            return observable
        })
            
            .observeOn(MainScheduler.instance)
            .subscribeOn(dependencies.scheduler)
            .map({[unowned self] (article, realm) -> ([Article]) in
                let allNewsWithFavorites = self.setupFavoriteState(new: realm, realm: article)
                return allNewsWithFavorites
            })
            .subscribe(onNext: {article in
                self.newsloaded = article
                let date = Date()
                self.saveTime = Int(date.timeIntervalSince1970)
                self.output.spinnerSubject.onNext(.removeLoader)
                self.output.requestedArticleSubject.onNext(.dataLoaded)
            }, onError: { [unowned self] error in
                self.output.requestedArticleSubject.onNext(.dataError)
                print(error)
            })
    }
    
    func checkRefreshTime(){
        let date = Date()
        if saveTime + 300 < Int(date.timeIntervalSince1970) || saveTime == 0 || newsloaded.isEmpty{
            input.getNewsSubject.onNext(true)
        }
        
    }
    
    
    func changeFavorite(subject: PublishSubject<Article>) -> Disposable{
        return subject
            .observeOn(MainScheduler.instance)
            .subscribeOn(dependencies.scheduler)
            .map({[unowned self] newss -> (Int, IndexPath) in
                if newss.isFavorite ?? false {
                    let index = self.returnIndexPathForCell(news: newss)
                    self.newsloaded[index].isFavorite = false
                    let newIndexOfCell: IndexPath = IndexPath(row: index, section: 0)
                    self.dependencies.realmManager.deleteObject(usedNew: newss, index: newIndexOfCell)
                    self.output.favoritesChanged.onNext([newIndexOfCell])
                    return (index, newIndexOfCell)
                } else {
                    let newsIndex = self.returnIndexPathForCell(news: newss)
                    let newIndexPath: IndexPath = IndexPath(row: newsIndex, section: 0)
                    self.newsloaded[newsIndex].isFavorite = true
                    self.output.favoritesChanged.onNext([newIndexPath])
                    return (newsIndex, newIndexPath)
                }
            })
            .subscribe(onNext: { newsIndex, newIndexPath in
            })
    }
    
    func returnIndexPathForCell(news: Article) -> Int{
        guard let allNewsIndexOfCell = newsloaded.enumerated().first(where: { (data) -> Bool
            in data.element.urlToImage == news.urlToImage
        }) else {return 0}
        return allNewsIndexOfCell.offset
    }
    
    func detailsViewControllerOpen(subject: PublishSubject<IndexPath>) -> Disposable {
       return subject
            .observeOn(MainScheduler.instance)
            .subscribeOn(dependencies.scheduler)
            .subscribe(onNext: {[unowned self]selected in
                self.selectedDetailsDelegate?.openDetailsView(news: self.newsloaded[selected.row])
            })
    }
    
}

protocol TableViewModelProtocol {
    var newsloaded: [Article] {get set}
    var selectedDetailsDelegate: DetailsNavigationDelegate? {get set}
    var buttonPressDelegate: ButtonPressDelegate? {get set}
    var input: TableViewModel.Input! {get set}
    var output: TableViewModel.Output! {get set}
    
    
    
    func detailsViewControllerOpen(subject: PublishSubject<IndexPath>) -> Disposable
    func changeFavorite(subject: PublishSubject<Article>) -> Disposable
    func getData(subject: PublishSubject<Bool>) -> Disposable
    func transform(input: TableViewModel.Input) -> TableViewModel.Output
}
extension TableViewModel: ButtonPressDelegate{
    func buttonIsPressed(new: Article) {
        self.input.changeFavoriteSubject.onNext(new)
        changeFavoriteStateDelegate?.changeFavoriteState(news: new)
    }
}
