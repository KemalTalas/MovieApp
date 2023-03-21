//
//  MainViewModel.swift
//  MovieApp
//
//  Created by Kemal Burak Talas on 14.03.2023.
//

import Foundation

final class MainViewModel {
    private var currentPage = 1
    private var maxPage = 0
    
    var error : Observable<customErrors?> = Observable(nil)
    var popularMovies : Observable<[MovieModel]> = Observable([])
    var trendingMovies : Observable<[MovieModel]> = Observable([])
    var topRatedMovies : Observable<[MovieModel]> = Observable([])
    var searchResults : Observable<[SearchModel]> = Observable([])
    
    func getPopularMovies(isNextPage: Bool = false) {
        if isNextPage {
            if currentPage < maxPage {
                currentPage += 1
            } else {
                return
            }
        }
        
        WebService.shared.request(type: .popularMovies,
                                  modelType: [MovieModel].self,
                                  page: currentPage) { [weak self] response in
            self?.popularMovies.value.append(contentsOf: response)
        } errorHandler: { [weak self] error in
            self?.error.value = error
        }
    }
    
    func getRowCounts(for section: MainCVSectionType) -> Int {
        switch section {
        case .popularMovie:
            return 1
        case .trendingMovie:
            return 1
        case .topRatedMovie:
            return 1
        case .popularTV:
            return 1
        case .trendingTV:
            return 1
        case .topRatedTV:
            return 1
        }
    }
    
    
}
