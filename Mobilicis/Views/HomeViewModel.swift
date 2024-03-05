//
//  HomeViewModel.swift
//  ActiveVibe
//
//  Created by Vaibhav  Tiwary on 19/01/24.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    @Published var score: Int = 0
    private var db = Firestore.firestore()
    private var userID: String

    init(userID: String) {
        self.userID = userID
        fetchUserScore()
    }

    private func fetchUserScore() {
        db.collection("users").document(userID).getDocument { [weak self] document, error in
            if let document = document, document.exists {
                let data = document.data()
                DispatchQueue.main.async {
                    self?.score = data?["score"] as? Int ?? 0
                }
            } else {
                print("Document does not exist or error: \(error?.localizedDescription ?? "")")
            }
        }
    }
}
