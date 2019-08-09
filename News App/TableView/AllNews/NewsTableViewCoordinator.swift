//
//  NewsTableViewCoordinator.swift
//  News App
//
//  Created by Matej Hetzel on 01/08/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class NewsTableViewCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parent: UINavigationController
    var tabBarCoordRoot: TabBarCoordinator
    var changeFavoriteStateDelegate: FavoriteDelegate?
    
    init (navController: UINavigationController, root: TabBarCoordinator){
        self.parent = navController
        self.tabBarCoordRoot = root
        let newsTableViewModel = TableViewModel(dataRepository: ArticleRepository(), scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
        newsTableViewModel.selectedDetailsDelegate = self
        newsTableViewModel.changeFavoriteStateDelegate = root
        let NewsTableView = NewsTableViewController(viewModel: newsTableViewModel)
        
        root.allNewsViewController = NewsTableView
    }
    
    
    func start() {
    }
  
}
extension NewsTableViewCoordinator: DetailsNavigationDelegate, ChildHasFinishedDelegate, WorkIsDoneDelegate{
    func openDetailsView(news: Article) {
        let details = DetailsViewCoordinator(navController: parent, news: news, root: self, tabBarDelegate: tabBarCoordRoot)
        self.addCoordinator(coordinator: details)
        details.childFinishedDelegate = self
        self.addCoordinator(coordinator: details)
        details.start()
    }
    
    func done(cooridinator: Coordinator) {
        childCoordinators.removeAll()
        childIsDone(coordinator: cooridinator)
    }
    
    func childIsDone(coordinator: Coordinator) {
        self.removeCoordinator(coordinator: coordinator)
        print(coordinator)
    }
}




