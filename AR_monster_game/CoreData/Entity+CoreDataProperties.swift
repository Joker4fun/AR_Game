//
//  Entity+CoreDataProperties.swift
//  AR_monster_game
//
//  Created by Антон Казеннов on 26.06.2023.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var name: String?
    @NSManaged public var level: String?
    @NSManaged public var image: String?

}

extension Entity : Identifiable {

}
