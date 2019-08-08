//
//  AlamofireRequest.swift
//  News App
//
//  Created by Matej Hetzel on 25/07/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import RxCocoa

open class AlamofireManager {
    
    func requestData(url: URL) -> Observable<[Article]>{
        return Observable.create{ observer -> Disposable in
            
            Alamofire.request(url)
                .responseJSON { response in
                    do{
                        guard let data = response.data else {return}
                        let articles = try JSONDecoder().decode(News.self, from: data)
                        observer.onNext(articles.articles)
                        observer.onCompleted()
                    } catch let jsonErr {
                        print("Error serializing json ", jsonErr)
                        observer.onError(jsonErr)
                    }
            }
            
            return Disposables.create()
        }
    }
}
