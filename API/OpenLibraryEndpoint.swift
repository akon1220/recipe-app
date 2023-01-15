//
//  OpenLibraryEndpoint.swift
//  midterm
//
//  Created by Akira Tou on 2022/02/23.
//

import Foundation

struct OpenLibraryEndpoint {
static let baseUrl = "https://openlibrary.org/works/"
  
  static func getAPIpath(book: Book) -> String {
    let url = OpenLibraryEndpoint.baseUrl + book.id + ".json"
    return url
  }

}
