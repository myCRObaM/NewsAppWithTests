//
//  ArticleRepository.swift
//  News App
//
//  Created by Matej Hetzel on 08/08/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Foundation
import RxSwift

protocol ArticleRepositoryProtocol {
    func alamofireRequest() -> Observable<[Article]>
}
