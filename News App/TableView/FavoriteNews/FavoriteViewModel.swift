//
//  FavoriteViewModel.swift
//  News App
//
//  Created by Matej Hetzel on 30/07/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RealmSwift

class FavoriteViewModel: FavoriteViewModelProtocol {
    
    struct Input {
        let getData: ReplaySubject<Bool>
        let changeFavoriteSubject: PublishSubject<Article>
    }
    
    struct Output {
        let favoriteChangeSubject: PublishSubject<favoriteChangeEnum>
        let disposables: [Disposable]
    }
    
    struct Dependencies {
        var realmManager: RealmManager
        var scheduler: SchedulerType
    }
    
    
    internal let dependencies: Dependencies
    internal var input: Input!
    internal var output: Output!
    
    var realmObject: Results<NewsFavorite>!
    
    
    var news = [Article]()
    
    
    var changeFavoriteStateDelegate: FavoriteDelegate?
    var selectedDetailsDelegate: DetailsNavigationDelegate?
    
    
    func fillData() {
        for index in realmObject{
            news.append(Article(title: index.title, description: index.descr, urlToImage: index.urlToImg, isFavorite: true))
        }
    }
    
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    
    func getData(subject: ReplaySubject<Bool>) -> Disposable{
        return subject
            .flatMap{ [unowned self] (bool) -> Observable<Results<NewsFavorite>> in
                return self.dependencies.realmManager.loadRealmData()
        }
            .subscribe(onNext: { [unowned self]value in
                self.realmObject = value
                self.fillData()
            })
    }
    
    
    
    func transform(input: Input) -> Output {
        var disposables = [Disposable]()
        
        self.input = input
        
        
        disposables.append(getData(subject: input.getData))
        disposables.append(changeFavorite(subject: input.changeFavoriteSubject))
        
        self.output = Output(favoriteChangeSubject: PublishSubject(), disposables: disposables)
        
        
        
        return output
    }
    
    func changeFavorite(subject: PublishSubject<Article>) -> Disposable{
        return subject
            .observeOn(MainScheduler.instance)
            .subscribeOn(dependencies.scheduler)
            .map({[unowned self] newss -> (Int, IndexPath) in
                if newss.isFavorite ?? false {
                    let newsIndex = self.returnIndexPathForCell(newss: newss)
                    let newIndexPath: IndexPath = IndexPath(row: newsIndex, section: 0)
                    self.news.remove(at: newsIndex)
                   
                    self.output.favoriteChangeSubject.onNext(favoriteChangeEnum.remove([newIndexPath]))
                    
                    return (newsIndex, newIndexPath)
                } else {
                    self.news.append(Article(title: newss.title, description: newss.description, urlToImage: newss.urlToImage, isFavorite: true))
                    let favNewsIndex = self.returnIndexPathForCell(newss: newss)
                    let newIndexOfCell: IndexPath = IndexPath(row: favNewsIndex, section: 0)
                    self.dependencies.realmManager.addobjToRealm(usedNew: newss, index: newIndexOfCell)
                    
                    self.output.favoriteChangeSubject.onNext(favoriteChangeEnum.add([newIndexOfCell]))
                    
                    return (favNewsIndex, newIndexOfCell)
                }
            })
            .subscribe(onNext: { newsIndex, newIndexPath in
            })
    }

    func returnIndexPathForCell(newss: Article) -> Int{
        guard let allNewsIndexOfCell = news.enumerated().first(where: { (data) -> Bool
            in data.element.urlToImage == newss.urlToImage
        }) else {return -1}
        return allNewsIndexOfCell.offset
    }
}

protocol FavoriteViewModelProtocol {
}

extension FavoriteViewModel: ButtonPressDelegate{
    func buttonIsPressed(new: Article) {
        changeFavoriteStateDelegate?.changeFavoriteState(news: new)
    }
}
