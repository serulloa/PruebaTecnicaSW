//
//  String+Extension.swift
//  PruebaTecnicaMeep
//
//  Created by Sergio Ulloa López on 20/07/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import Foundation

extension String {
    
    public var localized: String {
        
        return NSLocalizedString(self, comment: "")
    }
    
}
