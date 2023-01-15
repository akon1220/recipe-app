//
//  BookDetail.swift
//  midterm
//
//  Created by Akira Tou on 2022/02/22.
//

import SwiftUI


struct BookDetailScreen: View {
    @StateObject var viewModel: BookDetailVM
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .idle:
                Color.clear
            case .loading:
              ProgressView()
            case .failed:
              Text("Could not load the description")
            case .success(let summary):
              BookDetail(viewModel: viewModel, summary: summary)
            }
        }
        .task {await viewModel.getPlotSummary()}
        .alert("Could not load the description", isPresented: $viewModel.hasAPIError, presenting: viewModel.state) { detail in
              Button("Retry") {
                Task { await viewModel.getPlotSummary() }
              }
              Button("Cancel") {}
              }
              message: { detail in
                if case let .failed(error) = detail {
                  Text(error.localizedDescription)
                }
              }
        }
    }


struct BookDetail:  View {
    
    @ObservedObject var viewModel: BookDetailVM
    let summary: String
//    let isAdded: Bool
    
        var body: some View {
          ScrollView {
            VStack {
              bookImage
              Text(viewModel.book.title).font(.headline)
                Text(viewModel.book.author)
                Spacer()
                Text(summary)
                
            }
            .padding(12)
            Spacer()
          }
          .toolbar {
              ToolbarItem(placement: .primaryAction) {
                  Button(viewModel.isAdded ? "Remove" : "Add") {
                      if (viewModel.isAdded) {
                          viewModel.dataStore.removeBookFromReadingList(viewModel.book)
                      } else {
                          viewModel.dataStore.addBookToReadingList(viewModel.book)
                      }
                      
                  }
              }
          }
//          .toolbar {
//                ToolbarItem(placement: .primaryAction) {
//                    Button(action: {$viewModel.addBookToReadingList(viewModel.book)}) {
//                        Text("Add")
//                    }
//                    { viewModel.isAdded = true }
//                }
            }


        var bookImage: some View {
          AsyncImage(url: viewModel.book.coverUrl) { image in
            image
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(height: 200)
          } placeholder: {
            if viewModel.book.coverUrl != nil {
              ProgressView()
            } else {
              Image(systemName: "fork.knife")
            }
          }
        }
      }
    
//}
