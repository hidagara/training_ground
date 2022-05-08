//
//  DataManagement.swift
//  training_ground
//
//  Created by Роман on 08.05.2022.
//

import Foundation
final class DataManager {
    var cardInfoArray: [CardInfo] = [
        CardInfo(title: "Create Variable", imgName: "")
    ]
}

struct CardInfo {
    let title: String
    let imgName: String
}
