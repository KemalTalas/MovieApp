//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Kemal Burak Talas on 31.03.2023.
//

import Foundation

final class MovieDetailViewModel {
    
    enum Texts {
        case title
        case overview
        case rateCounts
        case releaseDate
        case runTime
        case genres
    }
    
    var movieId : Int?
    var movieDetails: Observable<MovieDetailModel?> = Observable(nil)
    var genreArray : Observable<[String]?> = Observable([])
    var genreString : String = ""
    
    var error: Observable<customErrors?> = Observable(nil)
    
    func getMovieDetails() {
        
        WebService.shared.request(type: .movieDetail, modelType: MovieDetailModel.self, movieID:movieId) { [weak self] response in
            self?.movieDetails.value = response
            response.genres?.forEach({ genre in
                self?.genreArray.value?.append(genre.name ?? "")
            })
            self?.genreString = self?.genreArray.value?.joined(separator: ", ") ?? "AQ"
            print(self!.genreArray.value)
            print("GENRES: \(self?.genreString)")
        } errorHandler: { [weak self] error in
            self?.error.value = error
        }
    }
    
    func getText(type: Texts) -> String {
        let dateFormatter = DateFormatter()
        guard let date = movieDetails.value?.releaseDate
        else { return "" }
        
        dateFormatter.locale = Locale(identifier: "en_US")
        print(dateFormatter.date(from: date))
        
        guard let title = movieDetails.value?.title
        else { return "" }
         
        guard let model = movieDetails.value
        else { return "" }
        
        switch type {
            
        case .title:
            return model.title~
        case .overview:
            return model.overview~
        case .rateCounts:
            return String(model.voteCount~)
        case .releaseDate:
            return model.releaseDate~ // Entension yaz dateformatter
        case .runTime:
            return String(model.runtime~) //Extension yaz int.runtime
        case .genres:
            return genreString
        }
    }
    
    func getRating() -> Int{
        guard let rating = movieDetails.value?.voteAverage
        else { return 0 }
        print(rating)
        return Int(rating/2)
    }
    
    func getTableViewCell() {
        
    }
    
    func getGenreArray() -> Array<String> {
        
        guard let model = movieDetails.value?.genres
        else { return [] }
        
        var stringArray : [String] = []
        
        for genre in model {
            stringArray.append(genre.name ?? "")
        }
        
        return stringArray
    }
    
}
