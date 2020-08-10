//
//  FilmDetailViewModel.swift
//  PruebaTecnicaSW
//
//  Created by Sergio Ulloa López on 10/08/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import Foundation
import RxSwift

/**
 ViewModel del módulo del detalle de película
 */
class FilmDetailViewModel: BaseViewModel {
    
    var assemblyDTO: FilmDetailAssemblyDTO?
    var filmProvider = FilmProvider()
    
    let filmDetail = PublishSubject<FilmDetail>()
    let loading = PublishSubject<Bool>()
    let error = PublishSubject<String>()
    
    /**
     Utiliza FilmProvider para realizar una llamada al servicio de detalle de película para
     luego obtener la respuesta y notificar un cambio a la vista
     */
    func getDetail() {
        self.loading.onNext(true)
        
        guard let id = assemblyDTO?.id else { return }
        
        self.filmProvider.getDetail(movieId: "\(id)", success: { filmDetail in
            self.loading.onNext(false)
            
            guard let detail = filmDetail else { return }
            self.filmDetail.onNext(detail)
        }) { error in
            self.loading.onNext(false)
            self.error.onNext(Utils.getErrorString(errorType: error))
        }
    }
    
}
