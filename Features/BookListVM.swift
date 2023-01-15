//
//  BookListVM.swift
//  midterm
//
//  Created by Akira Tou on 2022/02/22.
//

//Subscribes to the dataStore’s list of books and provides them to the view. I
//agree that the book list is not changing, but it’s still the dataStore’s responsibility to provide it.

import Foundation
import Combine

enum LoadingState {
    case notAvailable
    case loading
    case success
    case failed(error: Error)
}



//@MainActor
class BookListVM: ObservableObject {
    let dataStore: DataStore
    
    private var cancellables: Set<AnyCancellable> = []
    @Published var books: [Book] = []
    
    init(dataStore: DataStore) {
        self.dataStore = dataStore
    }
    
}
