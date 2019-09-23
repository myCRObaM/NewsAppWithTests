//
//  ViewNewsController.swift
//  News App
//
//  Created by Matej Hetzel on 15/07/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift
import RxSwift

class ViewNewsController: UIViewController {
    
    let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "Default")
        return imageView
    }()
    let newsTitleView: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let newsArticleView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor.darkGray
        return label
    }()
    let navBarTitleLabel:  UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        return titleLabel
    }()
    let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "NavBarStar"), for: .normal)
        button.setImage(UIImage(named: "NavBarStarFull"), for: .selected)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = true
        return button
    }()
    
    

    let disposeBag = DisposeBag()
    var buttonIsPressedDelegate: FavoriteDelegate?
    var selectedDetailsDelegate: DetailsNavigationDelegate?
    weak var coordinator: DetailsViewCoordinator?
    var viewModel: ViewNewsModelView!
    var workIsDelegate: WorkIsDoneDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupUI()
        setupView()
    }
    
    func setupViewModel(){
        let input = ViewNewsModelView.Input(starInitSubject: PublishSubject<Bool>())
        let output = viewModel.transform(input: input)
        
        configureStar(subject: viewModel.output.starSubject).disposed(by: disposeBag)
        for disposable in output.disposables {
            disposable.disposed(by: disposeBag)
        }
    }
    
    init(news: Article, model: ViewNewsModelView) {
        viewModel = model
        viewModel.loadDataToViewModel(news: news)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sendDataToViewController(news: Article){
        viewModel.loadDataToViewModel(news: news)
    }
    
    
    func setupUI(){
        view.addSubview(newsImageView)
        view.addSubview(newsTitleView)
        view.addSubview(newsArticleView)
        navBarTitleLabel.text = viewModel.dependecies.loadedNews.title
        navigationItem.titleView = navBarTitleLabel

        favoriteButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteButton)
        setupConstraints()
        
        starSetup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        workIsDelegate?.done(cooridinator: coordinator!)
    }
    
    
    func starSetup() {
        viewModel.input.starInitSubject.onNext(true)
    }

    @objc func addTapped(){
        self.buttonIsPressedDelegate?.changeFavoriteState(news: viewModel.dependecies.loadedNews)
        viewModel.changeState()
        viewModel.input.starInitSubject.onNext(true)
    }
    
    
    func configureStar(subject: PublishSubject<Bool>) -> Disposable{
        return subject
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: {[unowned self] bool in
                self.favoriteButton.isSelected = bool
            })
    }
    
    func setupConstraints(){
        
        navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = .white
        
        newsImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        newsImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        newsImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        newsImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        
        newsTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        newsTitleView.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 20).isActive = true
        newsTitleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        
        
        newsArticleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        newsArticleView.topAnchor.constraint(equalTo: newsTitleView.bottomAnchor, constant: 20).isActive = true
        newsArticleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
    }
    func setupView(){
        newsImageView.kf.setImage(with: URL(string: viewModel.dependecies.loadedNews.urlToImage))
        newsTitleView.text = viewModel.dependecies.loadedNews.title
        newsArticleView.text = viewModel.dependecies.loadedNews.description
        
    }
}



extension ViewNewsController: FavoriteDelegate{
    func changeFavoriteState(news: Article) {
        buttonIsPressedDelegate?.changeFavoriteState(news: news)
    }
}
