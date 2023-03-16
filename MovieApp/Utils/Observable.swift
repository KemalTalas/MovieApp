//
//  Observable.swift
//  MovieApp
//
//  Created by Kemal Burak Talas on 14.03.2023.
//

import Foundation

final class Observable<T> {
    typealias Listener = (T) -> Void
    
    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}

