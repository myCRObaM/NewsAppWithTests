//
//  DataRepository.swift
//  News App
//
//  Created by Matej Hetzel on 07/08/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import RxSwift
import RxCocoa
import Foundation

class ArticleRepository: ArticleRepositoryProtocol {
    
    func alamofireRequest() -> Observable<[Article]> {
         let url = "https://newsapi.org/v1/articles?source=bbc-news&sortBy=top&apiKey=6946d0c07a1c4555a4186bfcade76398"
        let alamoManager = AlamofireManager()
        let urlToUse = URL(string: url)!
       return alamoManager.requestData(url: urlToUse)
    }
}
