//
//  Model.swift
//  AR_monster_game
//
//  Created by Антон Казеннов on 18.06.2023.
//

import Foundation
import MapKit

enum MonstersNames:String, CaseIterable {
    case Joy, Tom, Anna, Rob, Anton, Serg
    
    private var name: String {
        switch self {
        case .Anna: return "Anna"
        case .Joy: return "Joy"
        case .Tom: return "Tom"
        case .Rob: return "Rob"
        case .Anton: return "Anton"
        case .Serg: return "Serg"
            
        }
    }
}

struct Mobs: Codable {
    var id: UUID
    var name: String
    var level: Int
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var imageAnnotationName: String
    
    init(coords: CLLocationCoordinate2D) {
        self.id = UUID()
        self.latitude = coords.latitude
        self.longitude = coords.longitude
        self.name = MonstersNames.allCases.randomElement()!.rawValue
        self.level = Int.random(in: 5...20)
        self.imageAnnotationName = name
    }
}


