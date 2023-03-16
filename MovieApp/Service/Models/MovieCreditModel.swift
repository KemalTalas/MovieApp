//
//  MovieCreditModel.swift
//  MovieApp
//
//  Created by Kemal Burak Talas on 14.03.2023.
//

import Foundation

struct MovieCreditsModel:Codable {

    var id: Int?
    var cast: [MovieCast]?
    var success: Bool?
    var statusCode: Int?
    var statusMessage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case cast
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}

struct MovieCast: Codable {

    var id: Int?
    var name: String?
    var profilePath: String?
    var character: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case character
        case profilePath = "profile_path"
    }
}
