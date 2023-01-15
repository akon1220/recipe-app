//
//  ReadingListVM.swift
//  midterm
//
//  Created by Akira Tou on 2022/02/22.
//

//Subscribes to the dataStore’s readingList and provides those items to the
//view

import Foundation
import Combine


class ReadingListVM: ObservableObject {
    let dataStore: DataStore
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(dataStore: DataStore) {
        self.dataStore = dataStore
    }
    
}
