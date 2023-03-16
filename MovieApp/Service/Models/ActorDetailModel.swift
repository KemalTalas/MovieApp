//
//  ActorDetailModel.swift
//  MovieApp
//
//  Created by Kemal Burak Talas on 14.03.2023.
//

import Foundation

struct ActorDetailModel: Codable {

    var biography: String?
    var birthday: String?
    var deathday: String?
    var homepage: String?
    var imdbID: String?
    var name: String?
    var profilePath: String?
    var placeOfBirth: String?
    var id: Int?
    var success: Bool?
    var statusCode: Int?
    var statusMessage: String?

    enum CodingKeys: String, CodingKey {
        case biography
        case birthday
        case deathday
        case homepage
        case name
        case id
        case success
        case imdbID = "imdb_id"
        case placeOfBirth = "place_of_birth"
        case profilePath = "profile_path"
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
