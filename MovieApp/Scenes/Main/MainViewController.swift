//
//  MainViewController.swift
//  MovieApp
//
//  Created by Kemal Burak Talas on 14.03.2023.
//
//TODO: Segment, SetSections'ı segment içinde çağır
//TODO: Viewmodel'a bak orda fonksiyonları düzenle

import UIKit

enum MainCVSectionType {
    case popularMovie
    case trendingMovie
    case topRatedMovie
    case popularTV
    case trendingTV
    case topRatedTV
}

enum MainVCViewType {
    case tv
    case movie
}

class MainViewController: UIViewController {
    
    private var viewModel: MainViewModel
    
    private var cvSections: Observable<[MainCVSectionType]> = Observable([])
    private var viewType: Observable<MainVCViewType> = Observable(.movie)
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        return flowLayout
    }()
    
    lazy var mainCV: UICollectionView = .init(frame: .zero,
                                                      collectionViewLayout: self.flowLayout)
    private lazy var segmentController = UISegmentedControl (items: ["Movie","TV"])
    
    init(with viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setNavigation()
        bindItems()
        loadData(viewType: .movie)
        loadData(viewType: .tv)
    }
    
    private func loadData(viewType: MainVCViewType) {
        viewModel.loadData(dataType: viewType)
    }
    
    private func bindItems() {
        viewType.bind { [weak self] type in
            self?.setSections(viewType: type)
        }
        
        cvSections.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.mainCV.reloadData()
            }
        }
    }
    
}

extension MainViewController : UICollectionViewDelegate,
                               UICollectionViewDelegateFlowLayout,
                               UICollectionViewDataSource {
    private func setupCollectionView() {
        mainCV.dataSource = self
        mainCV.delegate = self
        mainCV.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        mainCV.register(UINib(nibName: ShowcaseCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ShowcaseCollectionViewCell.identifier)
        self.view.addSubview(mainCV)
        mainCV.translatesAutoresizingMaskIntoConstraints = true
        self.mainCV.frame = self.view.frame
    }
    
    private func setSections(viewType type: MainVCViewType) {
        cvSections.value.removeAll()
        
        let sections: [MainCVSectionType]
        
        switch type {
        case .tv:
            sections = [.popularTV,
                        .topRatedTV,
                        .trendingTV]
        case .movie:
            sections = [.popularMovie,
                        .topRatedMovie,
                        .trendingMovie]
        }
        
        cvSections.value = sections
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cvSections.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        let currentSection = cvSections.value[section]
        return viewModel.getRowCounts(for: currentSection)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowcaseCollectionViewCell.identifier, for: indexPath) as! ShowcaseCollectionViewCell
        let currentSection = cvSections.value[indexPath.section]
        switch currentSection {
        case .trendingTV:
            cell.populate(with: viewModel.trendingTV)
        case .topRatedTV:
            cell.populate(with: viewModel.topRatedTV)
        case .popularTV:
            cell.populate(with: viewModel.popularTV)
        case .popularMovie:
            cell.populate(with: viewModel.popularMovies)
        case .trendingMovie:
            cell.populate(with: viewModel.trendingMovies)
        case .topRatedMovie:
            cell.populate(with: viewModel.topRatedMovies)
        }
        
        cell.setTitle(text: viewModel.getText(for: currentSection))
        cell.delegate = self
        cell.setCellType(type: currentSection)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width,
                      height: 420)
    }
    
    func setNavigation() {
        
        segmentController.selectedSegmentIndex = 0
        segmentController.addTarget(self, action:#selector(self.segmentChanged(_:)), for: .valueChanged)
        segmentController.sizeToFit()
        self.navigationItem.titleView = segmentController
    }
    
    @objc func segmentChanged(_ sender : UISegmentedControl!) {
        switch sender.selectedSegmentIndex{
        case 0:
            setSections(viewType: .movie)
        case 1:
            setSections(viewType: .tv)
        default:
            setSections(viewType: .movie)
        }
    }
}

extension MainViewController: ShowcaseCollectionViewCellDelegate {
    func getNextPage(for type: MainCVSectionType) {
        switch type {
        case .popularMovie:
            viewModel.getPopularMovies(isNextPage: true)
        case .trendingMovie:
            viewModel.getTrendingMovies(isNextPage: true)
        case .topRatedMovie:
            viewModel.getTopratedMovies(isNextPage: true)
        case .popularTV:
            viewModel.getPopularTV(isNextPage: true)
        case .trendingTV:
            viewModel.getTrendingTV(isNextPage: true)
        case .topRatedTV:
            viewModel.getTopratedTV(isNextPage: true)
        }
    }
}
