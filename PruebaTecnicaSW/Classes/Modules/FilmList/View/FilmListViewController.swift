//
//  FilmListViewController.swift
//  PruebaTecnicaSW
//
//  Created by Sergio Ulloa López on 09/08/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/**
 Vista del módulo del listado de películas
 */
class FilmListViewController: BaseView {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filmTableView: UITableView!
    
    var viewModel: FilmListViewModel? { super.baseViewModel as? FilmListViewModel }
    var films = PublishSubject<[Film]>()
    private let disposeBag = DisposeBag()
    var searchText = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBinding()
        
        self.title = LocalizedKeys.FilmList.title
        self.viewModel?.getFilmList()
    }
    
    /**
     Configuración de los observadores y del UITableView que contiene las celdas (FilmTableViewCell)
     con cada una de las películas disponibles
     */
    private func setupBinding() {
        // Loader
        self.viewModel?.loading.observeOn(MainScheduler.instance).subscribe(onNext: { loading in
            if loading {
                self.showLoading()
            } else {
                self.hideLoading()
            }
        }).disposed(by: disposeBag)
        
        // FilmTableView
        self.filmTableView.register(UINib(nibName: "FilmTableViewCell", bundle: nil), forCellReuseIdentifier: String(describing: FilmTableViewCell.self))
        
        self.films.bind(to: filmTableView.rx.items(cellIdentifier: "FilmTableViewCell", cellType: FilmTableViewCell.self)) { (row, film, cell) in
            cell.model = film
        }.disposed(by: disposeBag)
        
        self.viewModel?.filmArray.observeOn(MainScheduler.instance).bind(to: films).disposed(by: disposeBag)
        
        self.filmTableView.rx.modelSelected(Film.self).subscribe(onNext: { model in
            let filmDetail = FilmDetailAssembly.view(dto: FilmDetailAssemblyDTO(id: model.id, title: model.title))
            filmDetail.title = model.title
            self.navigationController?.pushViewController(filmDetail, animated: true)
        }).disposed(by: disposeBag)
        
        // Errors
        self.viewModel?.error.observeOn(MainScheduler.instance).subscribe(onNext: { error in
            self.showAlert(title: LocalizedKeys.Error.title, message: error)
        }).disposed(by: disposeBag)
        
        // SearchBar
        self.searchBar.rx.searchButtonClicked.observeOn(MainScheduler.instance).subscribe(onNext: { _ in
            self.searchText.onNext(self.searchBar.text ?? "")
        }).disposed(by: disposeBag)
        
        self.searchBar.rx.text.observeOn(MainScheduler.instance).subscribe(onNext: { text in
            self.searchText.onNext(text ?? "")
        }).disposed(by: disposeBag)
        
        self.searchBar.rx.cancelButtonClicked.observeOn(MainScheduler.instance).subscribe(onNext: { _ in
            self.searchText.onNext("")
        }).disposed(by: disposeBag)
    }

}
