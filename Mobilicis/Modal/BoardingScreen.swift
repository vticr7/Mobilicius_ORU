//
//  BoardingScreen.swift
//  BoardingScreen
//
//  Created by Vaibhav on 18/01/24.
//

import SwiftUI

struct BoardingScreen: Identifiable {
    var id = UUID().uuidString
    var image: String
    var title: String
    var description: String
}


let title = "MOBILICIS INDIA PRIVATE LIMITED"


let description = "Welcome to ORU Phones—buy and sell certified used phones with confidence. Enjoy the best prices, easy transactions, and expert support. Join now for smart deals"




var boardingScreens: [BoardingScreen] = [

    BoardingScreen(image: "screen1", title: title, description: description),
    BoardingScreen(image: "screen2", title: title, description: description),
    BoardingScreen(image: "screen3", title: title, description: description),
    BoardingScreen(image: "screen4", title: title, description: description),
]
