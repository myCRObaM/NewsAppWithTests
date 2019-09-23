//
//  FavoriteNewsTableCoordinator.swift
//  News App
//
//  Created by Matej Hetzel on 01/08/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class FavoriteNewsTableCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    var parent: UINavigationController
    var rootCoord: TabBarCoordinator
    
    init (navController: UINavigationController, root: TabBarCoordinator){
        self.parent = navController
        self.rootCoord = root
        
        let favoriteViewModel = FavoriteViewModel(dependencies: FavoriteViewModel.Dependencies(realmManager: RealmManager(), scheduler: ConcurrentDispatchQueueScheduler(qos: .background)))
        favoriteViewModel.changeFavoriteStateDelegate = root
        favoriteViewModel.selectedDetailsDelegate = self
        
        let favoriteNewsTableViewController = FavoriteNewsViewController(viewModel: favoriteViewModel)
        root.favoriteNewsViewController = favoriteNewsTableViewController
    }
    
    func start() {
    }
}
extension FavoriteNewsTableCoordinator: DetailsNavigationDelegate, ChildHasFinishedDelegate, WorkIsDoneDelegate{
    func openDetailsView(news: Article) {
        let details = DetailsViewCoordinator(navController: parent, news: news, root: self, tabBarDelegate: rootCoord)
        self.addCoordinator(coordinator: details)
        details.childFinishedDelegate = self
        self.addCoordinator(coordinator: details)
        details.start()
    }
    func childIsDone(coordinator: Coordinator) {
        self.removeCoordinator(coordinator: coordinator)
        print(coordinator)
    }
    
    func done(cooridinator: Coordinator) {
        childCoordinators.removeAll()
        childIsDone(coordinator: cooridinator)
    }
}


