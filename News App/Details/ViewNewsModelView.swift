//
//  ViewNewsModelView.swift
//  News App
//
//  Created by Matej Hetzel on 30/07/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import RealmSwift
import RxSwift

class ViewNewsModelView {
    
    struct Input {
        let starInitSubject: PublishSubject<Bool>
    }
    
    struct Output {
        let starSubject: PublishSubject<Bool>
        let disposables: [Disposable]
    }
    
    struct Dependencies {
        var loadedNews: Article
    }
    
    var input: Input!
    var output: Output!
    var dependecies: Dependencies

    
    init(dependencies: Dependencies) {
        self.dependecies = dependencies
    }
    
    func loadDataToViewModel(news: Article){
        self.dependecies.loadedNews = news
    }

    func transform(input: Input) -> Output {
        var disposables = [Disposable]()
        self.input = input
        disposables.append(configureStars(subject: self.input.starInitSubject))
        self.output = Output(starSubject: PublishSubject(), disposables: disposables)
        return output
    }
    
    
    func configureStars(subject: PublishSubject<Bool>) -> Disposable{
        return subject.flatMap({ (bool) -> Observable<Bool> in
            return Observable.just(bool)
        }).observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: {[unowned self] (bool) in
                self.output.starSubject.onNext(self.dependecies.loadedNews.isFavorite ?? false)
            })
    }
    
    func changeState(){
        if dependecies.loadedNews.isFavorite ?? false {
            dependecies.loadedNews.isFavorite = false
        } else {
            dependecies.loadedNews.isFavorite = true
        }
    }
    
}
