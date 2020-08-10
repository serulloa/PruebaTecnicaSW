//
//  FilmListViewModel.swift
//  PruebaTecnicaSW
//
//  Created by Sergio Ulloa López on 09/08/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import Foundation
import RxSwift

/**
 ViewModel del módulo del listado de películas
 */
class FilmListViewModel: BaseViewModel {
    
    var view: FilmListViewController? { super.baseView as? FilmListViewController }
    var assemblyDTO: FilmListAssemblyDTO?
    var filmProvider = FilmProvider()
    
    var filmList: FilmList?
    let filmArray = PublishSubject<[Film]>()
    let loading = PublishSubject<Bool>()
    let error = PublishSubject<String>()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        self.setupBinding()
    }
    
    /**
     Utiliza FilmProvider para realizar la llamada a la API y luego recoger el listado
     de películas. Una vez hecho esto, notifica a los observadores que se ha actualizdo
     el listado
     */
    func getFilmList() {
        self.loading.onNext(true)
        
        self.filmProvider.getFilmList(success: { filmList in
            self.loading.onNext(false)
            self.filmList = filmList
            self.filmArray.onNext(self.filmList?.results ?? [])
        }) { error in
            self.loading.onNext(false)
            self.error.onNext(Utils.getErrorString(errorType: error))
        }
    }
    
    /**
     Realiza la configuración de los observadores cuando se realizan acciones sobre la vista
     como, por ejemplo, una búsqueda por texto
     */
    func setupBinding() {
        self.view?.searchText.observeOn(MainScheduler.instance).subscribe(onNext: { text in
            if text.isEmpty || text == "" {
                self.filmArray.onNext(self.filmList?.results ?? [])
            } else {
                self.filmArray.onNext(self.filmList?.results?.filter({ ($0.title?.lowercased().contains(text.lowercased()) ?? false) }) ?? [])
            }
        }).disposed(by: disposeBag)
    }
    
}
