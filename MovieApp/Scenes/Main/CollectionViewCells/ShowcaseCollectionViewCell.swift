//
//  ShowcaseCollectionViewCell.swift
//  MovieApp
//
//  Created by Kemal Burak Talas on 14.03.2023.
//

import UIKit

protocol ShowcaseCollectionViewCellDelegate: AnyObject {
    func getNextPage(for type: MainCVSectionType)
}

final class ShowcaseCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ShowcaseCollectionViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailCV: UICollectionView!
    
    private var models: [MovieModel]?
    private var cellType: MainCVSectionType?
    private var pageCount: Int = 1
    weak var delegate: ShowcaseCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    func setTitle(text: String) {
        titleLabel.text = text
    }
    
    func populate(with model: Any?) {
        if let item = model as? Observable<[MovieModel]> {
            item.bind { [weak self] movieModels in
                self?.models = movieModels
                
                DispatchQueue.main.async {
                    self?.detailCV.reloadData()
                }
            }
        }
    }
    
    func setCellType(type: MainCVSectionType) {
        self.cellType = type
    }
}

//MARK: - CollectionView Stuff
extension ShowcaseCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func setupCollectionView() {
        registerNibs()
        
        detailCV.delegate = self
        detailCV.dataSource = self
        detailCV.showsHorizontalScrollIndicator = false
        detailCV.contentInset = UIEdgeInsets(top: 0,
                                             left: 20,
                                             bottom: 0,
                                             right: 20)
    }
    
    private func registerNibs() {
        detailCV.register(UINib(nibName: "DetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models~.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as! DetailCollectionViewCell
        cell.populate(with: models?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 185,
                      height: 380)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if pageCount * 20 == indexPath.row + 1 {
            guard let type = cellType
            else { return }
            pageCount += 1
            delegate?.getNextPage(for: type)
        }
    }
}


