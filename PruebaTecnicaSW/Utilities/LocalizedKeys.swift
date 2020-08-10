import Foundation
//swiftlint:disable nesting

/**
 Estructura de ayuda para realizar un mejor uso de los String localilzables
 */
struct LocalizedKeys {
    
    struct General {
        static let attributionTMDB = "general_tmdb_attribution".localized
    }
    
    struct Error {
        static let title = "error_title".localized
        static let network = "network_error".localized
        static let generic = "generic_error".localized
    }
    
    struct FilmList {
        static let title = "film_list_title".localized
    }
    
    struct FilmDetail {
        static let genres = "film_detail_genre".localized
        static let synopsis = "film_detail_synopsis".localized
    }
    
}
