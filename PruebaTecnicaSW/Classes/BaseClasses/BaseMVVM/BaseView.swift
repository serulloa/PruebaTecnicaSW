//
//  BaseView.swift
//  PruebaTecnicaSW
//
//  Created by Sergio Ulloa López on 08/08/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

/**
 Clase padre de todos las vistas o ViewControllers utilizados en el código
 */
class BaseView: UIViewController {
    
    internal var baseViewModel: BaseViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseViewModel?.viewDidLoad()
    }
    
    /**
     Función que muestra alertas genéricas que sólo tienen un botón de aceptar
     */
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     Utiliza el Pod SVProgressHUD para mostrar un loader
     */
    func showLoading() {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
    }
    
    /**
     Utiliza el Pod SVProgressHUD para ocultar un loader
     */
    func hideLoading() {
        SVProgressHUD.dismiss()
    }
    
}
