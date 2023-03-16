//
//  ShowcaseCollectionViewCell.swift
//  MovieApp
//
//  Created by Kemal Burak Talas on 14.03.2023.
//

import UIKit

final class ShowcaseCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ShowcaseCollectionViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailCV: UICollectionView!
    
    private var models: [MovieModel]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    func populate(with model: Any?) {
        if let item = model as? [MovieModel] {
            models = item
            DispatchQueue.main.async {
                self.detailCV.reloadData()
            }
        }
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
                      height: 340)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}


