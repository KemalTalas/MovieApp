//
//  WebServiceEnums.swift
//  MovieApp
//
//  Created by Kemal Burak Talas on 14.03.2023.
//

import Foundation

enum urlType {
    case movieDetail
    case popularMovies
    case search
    case movieCredits
    case actorDetail
    case actorMovies
    case trailer

}

protocol customErrors {
    var description: String {get}
}

enum webServiceErrors: customErrors {
    case internetError
    case apiError
    case urlError
    case unknown

    var description: String {
        switch self {
        case .internetError:
            return "Internet connection error occured. Check your connection and try again"
        case .apiError:
            return "Service error occured. Please try again later"
        case .urlError:
            return "Url failed. Contact with us"
        case .unknown:
            return "An unknown error occured. Please try again later"
        }
    }
}
