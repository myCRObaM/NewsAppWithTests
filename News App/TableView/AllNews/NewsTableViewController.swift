//
//  ViewController.swift
//  News App
//
//  Created by Matej Hetzel on 15/07/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//




import UIKit
import Alamofire
import Kingfisher
import RealmSwift
import RxSwift

class NewsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    let titleLabel:  UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        return titleLabel
    }()
    
    private let refreshControl = UIRefreshControl()
    var vSpinner : UIView?
    let disposeBag = DisposeBag()
    let viewModel: TableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareForViewModel()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.checkRefreshTime()
    }
    
    init (viewModel: TableViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func prepareForViewModel(){
        articlesDataLoaded(subject: viewModel.requestedArticleSubject)
        viewModel.changeFavorite(subject: viewModel.changeFavoriteSubject).disposed(by: disposeBag)
        viewModel.detailsViewControllerOpen(subject: viewModel.detailsViewControllerSubject).disposed(by: disposeBag)
        viewModel.getData(subject: viewModel.getNewsSubject).disposed(by: disposeBag)
        editFavoriteRows()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsloaded.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let singleNews = viewModel.newsloaded[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? NewsTableViewCell else {
            fatalError("Nije instanca ")
        }
        cell.configureCell(news: singleNews)
        cell.buttonIsPressedDelegate = viewModel.buttonPressDelegate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        viewModel.selectedDetailsDelegate?.openDetailsView(news: viewModel.newsloaded[indexPath.row])
        viewModel.detailsViewControllerSubject.onNext(indexPath)
    }
    
    
    func setupTableView(){
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "CellID")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    func setupView(){
        setupTableView()
        titleLabel.text = "Factory"
        self.navigationItem.titleView = titleLabel
        
        setupConstraints()
    }
    
    
    func setupConstraints(){
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        refreshControlFunc()
        
    }
    func refreshControlFunc(){
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshApiData), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing News Data")
        loaderControl()
    }
    
    func articlesDataLoaded(subject: PublishSubject<DataRequestEnum>){
        subject
            .observeOn(MainScheduler.instance)
            .subscribeOn(viewModel.scheduler)
            .subscribe(onNext: {[unowned self] bool in
                switch bool {
                case .dataError:
                    self.popUpErrorSetup()
                case .dataLoaded:
                    self.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }
    
    
    func popUpErrorSetup(){
        let alert = UIAlertController(title: "Greška", message: "Ups, došlo je do pogreške.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "U redu", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @objc private func refreshApiData() {
        viewModel.getNewsSubject.onNext(true)
    }
    
    
    func changeFavorite(news: Article){
        viewModel.changeFavoriteSubject.onNext(news)
    }
    
    func editFavoriteRows(){
        viewModel.favoritesChanged
            .observeOn(MainScheduler.instance)
            .subscribeOn(viewModel.scheduler)
            .subscribe(onNext: { [unowned self] index in
              self.tableView.reloadRows(at: index, with: .automatic)
            }).disposed(by: disposeBag)
        
    }
    
    
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    func loaderControl(){
        viewModel.spinnerSubject
            .subscribe(onNext: {[unowned self] value in
                switch value {
                case .addLoader:
                    self.showSpinner(onView: self.view)
                case .removeLoader:
                    self.removeSpinner()
                    self.refreshControl.endRefreshing()
                }
            }).disposed(by: disposeBag)
    }
    
    
}






