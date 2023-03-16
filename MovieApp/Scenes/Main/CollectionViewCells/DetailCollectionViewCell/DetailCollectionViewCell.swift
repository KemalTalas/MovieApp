//
//  DetailCollectionViewCell.swift
//  MovieApp
//
//  Created by Kemal Burak Talas on 14.03.2023.
//

import UIKit
import Kingfisher

final class DetailCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DetailCollectionViewCell"

    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func populate(with model: Any?) {
        if let item = model as? MovieModel {
            let url = URL(string: "https://image.tmdb.org/t/p/w500" + item.posterPath~)
            detailImageView.kf.setImage(with: url)
            detailTitleLabel.text = item.title
        }
    }
}
