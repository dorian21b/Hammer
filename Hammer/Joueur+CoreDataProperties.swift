//
//  Joueur+CoreDataProperties.swift
//  Hammer
//
//  Created by Dorian Rousse on 20/02/2024.
//
//

import Foundation
import CoreData


extension Joueur {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Joueur> {
        return NSFetchRequest<Joueur>(entityName: "Joueur")
    }

    @NSManaged public var nom: String?
    @NSManaged public var prenom: String?
    @NSManaged public var ensembleDesScores: NSSet?

}

// MARK: Generated accessors for ensembleDesScores
extension Joueur {

    @objc(addEnsembleDesScoresObject:)
    @NSManaged public func addToEnsembleDesScores(_ value: Scores)

    @objc(removeEnsembleDesScoresObject:)
    @NSManaged public func removeFromEnsembleDesScores(_ value: Scores)

    @objc(addEnsembleDesScores:)
    @NSManaged public func addToEnsembleDesScores(_ values: NSSet)

    @objc(removeEnsembleDesScores:)
    @NSManaged public func removeFromEnsembleDesScores(_ values: NSSet)

}

extension Joueur : Identifiable {

}
