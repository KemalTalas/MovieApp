//
//  MainViewController.swift
//  MovieApp
//
//  Created by Kemal Burak Talas on 14.03.2023.
//

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
    
    private lazy var mainCV: UICollectionView = .init(frame: .zero,
                                                      collectionViewLayout: self.flowLayout)
    
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
        bindItems()
        loadData(viewType: .movie)
    }
    
    private func loadData(viewType: MainVCViewType) {
        switch viewType {
        case .movie:
            viewModel.getPopularMovies()
        case .tv:
            ()
        }
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
            sections = [.popularTV,
                        .topRatedTV,
                        .trendingTV]
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
            ()
        case .topRatedTV:
            ()
        case .popularTV:
            ()
        case .popularMovie:
            cell.populate(with: viewModel.popularMovies)
        case .trendingMovie:
            cell.populate(with: viewModel.trendingMovies)
        case .topRatedMovie:
            cell.populate(with: viewModel.topRatedMovies)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width,
                      height: 388)
    }
}
