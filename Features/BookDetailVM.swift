//
//  BookDetailVM.swift
//  midterm
//
//  Created by Akira Tou on 2022/02/22.
//

import Foundation
import Combine
import UIKit


@MainActor
class BookDetailVM: ObservableObject {
    let apiService: OpenLibraryAPIService
    let dataStore: DataStore
    
    private var cancellables: Set<AnyCancellable> = []
    @Published var book: Book
    @Published private(set) var state: LoadingState = .idle
    @Published var hasAPIError: Bool = false
    @Published var isAdded: Bool = false
    

      enum LoadingState {
       case idle
       case loading
       case success(data: String)
       case failed(error: Error)
       }
    
    init(apiService: OpenLibraryAPIService, dataStore: DataStore, book: Book) {
        self.apiService = apiService
        self.book = book
        self.dataStore = dataStore
        
        dataStore.$readingList
              .sink{ [weak self] updatedList in
                self?.isAdded = updatedList.contains(where: { $0.id == self?.book.id })
              }
              .store(in: &cancellables)
    }
    func getPlotSummary() async {
        self.state = .loading
        do {
            let response: OpenLibraryResponse = try await apiService.fetchBook(book: self.book)
            let summary = response.summaryContainer.summary
            self.state = .success(data: summary)
        } catch {
            self.state = .failed(error: error)
            self.hasAPIError = true
        }
    }
    
}
