import SwiftUI
//Displays the current reading list. Also has a delete swipe action to facilitate
//remove items from the reading list.


struct ReadingListScreen: View {
    @StateObject var viewModel: ReadingListVM
    var body: some View {
        ReadingList(viewModel: viewModel)
    }
}
struct ReadingList: View {
    @ObservedObject var viewModel: ReadingListVM

        var body: some View {
            List(viewModel.dataStore.readingList) { book in
                ReadingListRow(book: book)
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        viewModel.dataStore.removeBookFromReadingList(book)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }.navigationTitle("Reading List")
            }

  }



struct ReadingListRow: View {
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

struct ReadingList_Previews: PreviewProvider {
  static let dataStore = DataStore()
  static var previews: some View {
      ReadingListScreen(viewModel: ReadingListVM(dataStore: dataStore))
  }
}
