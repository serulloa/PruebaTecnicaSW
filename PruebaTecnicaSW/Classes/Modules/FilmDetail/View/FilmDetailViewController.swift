//
//  FilmDetailViewController.swift
//  PruebaTecnicaSW
//
//  Created by Sergio Ulloa López on 10/08/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

/**
 Vista del módulo de detalle de película
 */
class FilmDetailViewController: BaseView {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreTitleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingCountLabel: UILabel!
    @IBOutlet weak var synopsisTitleLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var attributionLabel: UILabel!
    
    var viewModel: FilmDetailViewModel? { super.baseViewModel as? FilmDetailViewModel }
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBinding()
        
        self.setupLiterals()
        self.configureUI()
        self.viewModel?.getDetail()
    }
    
    /**
     Configuración de los observadores y los enlaces con el ViewModel, cuando esta clase es notificada de un cambio
     en el modelo se ejecuta la función setupView()
     */
    private func setupBinding() {
        // Loader
        self.viewModel?.loading.observeOn(MainScheduler.instance).subscribe(onNext: { loading in
            if loading {
                self.scrollView.isHidden = true
                self.showLoading()
            } else {
                self.scrollView.isHidden = false
                self.hideLoading()
            }
        }).disposed(by: disposeBag)
        
        // Model
        self.viewModel?.filmDetail.observeOn(MainScheduler.instance).subscribe(onNext: { filmDetail in
            self.setupView(model: filmDetail)
        }).disposed(by: disposeBag)
    }
    
    /**
     Dado un modelo, modifica los literales y las imágenes de la vista con los datos proporcionados
     */
    private func setupView(model: FilmDetail) {
        let backdropUrl = URL(string: URLEndpoint.getImageUrl(path: model.backdropPath ?? "", width: .backdrop))
        let posterUrl = URL(string: URLEndpoint.getImageUrl(path: model.posterPath ?? "", width: .poster))
        
        self.backdropImageView.kf.setImage(with: backdropUrl)
        self.posterImageView.kf.setImage(with: posterUrl)
        self.titleLabel.text = model.title
        
        self.genreLabel.text = model.genres?.map({($0.name ?? "")}).joined(separator: ", ")
        self.ratingLabel.text = "\(model.voteAverage ?? 0.0)"
        self.ratingCountLabel.text = "(\(model.voteCount ?? 0))"
        
        self.taglineLabel.text = model.tagline
        self.synopsisLabel.text = model.overview
        
    }
    
    /**
     Inicialización de literales
     */
    private func setupLiterals() {
        self.genreTitleLabel.text = LocalizedKeys.FilmDetail.genres
        self.synopsisTitleLabel.text = LocalizedKeys.FilmDetail.synopsis
        self.attributionLabel.text = LocalizedKeys.General.attributionTMDB
    }
    
    /**
     Configuración de componentes visuales
     */
    private func configureUI() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.backdropImageView.addSubview(blurEffectView)
    }

}
