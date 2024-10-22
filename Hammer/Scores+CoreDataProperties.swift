//
//  Scores+CoreDataProperties.swift
//  Hammer
//
//  Created by Dorian Rousse on 20/02/2024.
//
//

import Foundation
import CoreData


extension Scores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Scores> {
        return NSFetchRequest<Scores>(entityName: "Scores")
    }

    @NSManaged public var date: Date?
    @NSManaged public var score: Double
    @NSManaged public var quelJoueur: Joueur?

}

extension Scores : Identifiable {

}
