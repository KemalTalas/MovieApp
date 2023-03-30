//
//  MainViewModel.swift
//  MovieApp
//
//  Created by Kemal Burak Talas on 14.03.2023.
//

import Foundation

final class MainViewModel {
    private var currentPagePM = 1
    private var maxPagePM = 0
    private var currentPageTM = 1
    private var maxPageTM = 0
    private var currentPageTRM = 1
    private var maxPageTRM = 0
    private var currentPagePTV = 1
    private var maxPagePTV = 0
    private var currentPageTTV = 1
    private var maxPageTTV = 0
    private var currentPageTRTV = 1
    private var maxPageTRTV = 0
    
    var error : Observable<customErrors?> = Observable(nil)
    var popularMovies : Observable<[MovieModel]> = Observable([])
    var trendingMovies : Observable<[MovieModel]> = Observable([])
    var topRatedMovies : Observable<[MovieModel]> = Observable([])
    var popularTV : Observable<[MovieModel]> = Observable([])
    var trendingTV : Observable<[MovieModel]> = Observable([])
    var topRatedTV : Observable<[MovieModel]> = Observable([])
    var searchResults : Observable<[SearchModel]> = Observable([])
    
    func loadData(dataType: MainVCViewType) {
        switch dataType {
        case .tv:
            getPopularTV()
            getTrendingTV()
            getTopratedTV()
        case .movie:
            getPopularMovies()
            getTopratedMovies()
            getTrendingMovies()
        }
    }
    
    func getPopularMovies(isNextPage: Bool = false) {
        if isNextPage {
            if currentPagePM < maxPagePM {
                currentPagePM += 1
            } else {
                return
            }
        }
        
        WebService.shared.request(type: .popularMovies,
                                  modelType: PopularMoviesModel.self,
                                  page: currentPagePM) { [weak self] response in
            if self?.currentPagePM == 1{
                self?.maxPagePM = response.totalPages ?? 0
                self?.popularMovies.value = response.results ?? []
                return
            }
            self?.popularMovies.value.append(contentsOf: response.results ?? [])
        } errorHandler: { [weak self] error in
            self?.error.value = error
        }
    }
    
    func getTrendingMovies(isNextPage : Bool = false) {
        if isNextPage {
            if currentPageTM < maxPageTM {
                currentPageTM += 1
            } else {
                return
            }
        }
        
        WebService.shared.request(type: .trendingMovies,
                                  modelType: PopularMoviesModel.self,
                                  page: currentPageTM) { [weak self] response in
            if self?.currentPageTM == 1 {
                self?.maxPageTM = response.totalPages ?? 0
                self?.trendingMovies.value = response.results ?? []
                return
            }
            
            self?.trendingMovies.value.append(contentsOf: response.results ?? [])
        } errorHandler: { [weak self] error in
            self?.error.value = error
        }
    }
    
    func getTopratedMovies(isNextPage : Bool = false) {
        if isNextPage {
            if currentPageTRM < maxPageTRM {
                currentPageTRM += 1
            } else {
                return
            }
        }
        
        WebService.shared.request(type: .topRatedMovies,
                                  modelType: PopularMoviesModel.self,
                                  page: currentPageTRM) { [weak self] response in
            if self?.currentPageTRM == 1 {
                self?.maxPageTRM = response.totalPages ?? 0
                self?.topRatedMovies.value = response.results ?? []
                return
            }
            
            self?.topRatedMovies.value.append(contentsOf: response.results ?? [])
        } errorHandler: { [weak self] error in
            self?.error.value = error
        }
    }
    
    func getPopularTV(isNextPage: Bool = false) {
        if isNextPage {
            if currentPagePTV < maxPagePTV {
                currentPagePTV += 1
            } else {
                return
            }
        }
        
        WebService.shared.request(type: .popularTV,
                                  modelType: PopularMoviesModel.self,
                                  page: currentPagePTV) { [weak self] response in
            if self?.currentPagePTV == 1{
                self?.maxPagePTV = response.totalPages ?? 0
                self?.popularTV.value = response.results ?? []
                print("count is:")
                print(self?.popularTV.value.count ?? 0)
                return
            }
            self?.popularTV.value.append(contentsOf: response.results ?? [])
        } errorHandler: { [weak self] error in
            self?.error.value = error
        }
    }
    
    func getTrendingTV(isNextPage: Bool = false) {
        if isNextPage {
            if currentPageTTV < maxPageTTV {
                currentPageTTV += 1
            } else {
                return
            }
        }
        
        WebService.shared.request(type: .trendingTV,
                                  modelType: PopularMoviesModel.self,
                                  page: currentPageTTV) { [weak self] response in
            if self?.currentPageTTV == 1{
                self?.maxPageTTV = response.totalPages ?? 0
                self?.trendingTV.value = response.results ?? []
                return
            }
            self?.trendingTV.value.append(contentsOf: response.results ?? [])
        } errorHandler: { [weak self] error in
            self?.error.value = error
        }
    }
    
    func getTopratedTV(isNextPage: Bool = false) {
        if isNextPage {
            if currentPageTRTV < maxPageTRTV {
                currentPageTRTV += 1
            } else {
                return
            }
        }
        
        WebService.shared.request(type: .topRatedTV,
                                  modelType: PopularMoviesModel.self,
                                  page: currentPageTRTV) { [weak self] response in
            if self?.currentPageTRTV == 1{
                self?.maxPageTRTV = response.totalPages ?? 0
                self?.topRatedTV.value = response.results ?? []
                return
            }
            self?.topRatedTV.value.append(contentsOf: response.results ?? [])
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
    
    func getText(for section: MainCVSectionType) -> String {
        switch section {
        case .popularMovie:
            return "Popular Movies"
        case .trendingMovie:
            return "Trending Movies"
        case .topRatedMovie:
            return "Top Rated Movies"
        case .popularTV:
            return "Popular Series"
        case .trendingTV:
            return "Trending Series"
        case .topRatedTV:
            return "Top Rated Series"
        }
    }
}
