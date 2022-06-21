//
//  MovieGroup+CoreDataProperties.swift
//  MovieApp
//
//  Created by Jurica Mikulic on 29.05.2022..
//
//

import Foundation
import CoreData


extension MovieGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieGroup> {
        return NSFetchRequest<MovieGroup>(entityName: "MovieGroup")
    }

    @NSManaged public var name: String?
    @NSManaged public var movie: NSSet?

}

// MARK: Generated accessors for movie
extension MovieGroup {

    @objc(addMovieObject:)
    @NSManaged public func addToMovie(_ value: Movie)

    @objc(removeMovieObject:)
    @NSManaged public func removeFromMovie(_ value: Movie)

    @objc(addMovie:)
    @NSManaged public func addToMovie(_ values: NSSet)

    @objc(removeMovie:)
    @NSManaged public func removeFromMovie(_ values: NSSet)

}

extension MovieGroup : Identifiable {

}
