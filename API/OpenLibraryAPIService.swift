//
//  OpenLibraryAPIService.swift
//  midterm
//
//  Created by Akira Tou on 2022/02/23.
//

import Foundation


class OpenLibraryAPIService: ObservableObject {

  func fetchBook(book: Book) async throws -> OpenLibraryResponse {
    let url = OpenLibraryEndpoint.getAPIpath(book: book)
    let responseData: OpenLibraryResponse = try await RestAPIClient().performRequest(url: url)
    return responseData
  }

}
