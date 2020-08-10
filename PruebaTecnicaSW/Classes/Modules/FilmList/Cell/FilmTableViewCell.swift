//
//  FilmTableViewCell.swift
//  PruebaTecnicaSW
//
//  Created by Sergio Ulloa López on 10/08/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import UIKit
import Kingfisher

/**
 Celda utilizada en FilmList para representar cada elemento del listado
 de películas
 */
class FilmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var model: Film! {
        didSet {
            let url = URL(string: URLEndpoint.getImageUrl(path: self.model.posterPath ?? "", width: .poster))
            self.posterImageView.kf.setImage(with: url)
            self.labelTitle.text = self.model.title
            self.labelRating.text = "\(self.model.voteAverage ?? 0.0)"
            self.labelOverview.text = self.model.overview
            self.labelDate.text = self.model.releaseDate
        }
    }
    
}
