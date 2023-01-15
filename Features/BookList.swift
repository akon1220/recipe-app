import SwiftUI
//displays the list of books and navigates to a detailed view

struct BookListScreen: View {
    @StateObject var viewModel: BookListVM
    
  var body: some View {
      
        BookList(viewModel: viewModel)
    
    .navigationTitle("Books - xd62")
  }
    
}

struct BookList: View {
    @ObservedObject var viewModel: BookListVM
    
    var body: some View {
        List(viewModel.dataStore.books) { book in
            NavigationLink(destination: BookDetailScreen(
                viewModel: BookDetailVM(apiService: OpenLibraryAPIService(), dataStore: viewModel.dataStore, book: book)
            ))
                           {
                    BookRow(book: book)
                }
            }.navigationTitle("Books - xd62")
        }
}

struct BookRow: View {
    let book: Book
    
    var body: some View {
        HStack {
            AsyncImage(url: book.coverUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                if book.coverUrl != nil {
                    ProgressView()
                } else {
                    Image(systemName: "film.fill")
                }
            }
            .frame(maxWidth: 100, maxHeight: 100)
            .cornerRadius(6)
            VStack(alignment: .leading) {
                Text(book.title).bold()
                Text(book.author)
            }
        }
        .padding(10)
    }
}


struct BookList_Previews: PreviewProvider {
    static let dataStore = DataStore()
    
  static var previews: some View {
    NavigationView {
        BookListScreen(viewModel: BookListVM(dataStore: dataStore))
    }
  }
}
