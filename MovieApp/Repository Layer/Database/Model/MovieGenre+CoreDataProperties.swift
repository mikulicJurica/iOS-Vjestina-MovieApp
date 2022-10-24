//
//  MovieGenre+CoreDataProperties.swift
//  MovieApp
//
//  Created by Jurica Mikulic on 29.05.2022..
//
//

import Foundation
import CoreData


extension MovieGenre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieGenre> {
        return NSFetchRequest<MovieGenre>(entityName: "MovieGenre")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var movie: NSSet?

}

// MARK: Generated accessors for movie
extension MovieGenre {

    @objc(addMovieObject:)
    @NSManaged public func addToMovie(_ value: Movie)

    @objc(removeMovieObject:)
    @NSManaged public func removeFromMovie(_ value: Movie)

    @objc(addMovie:)
    @NSManaged public func addToMovie(_ values: NSSet)

    @objc(removeMovie:)
    @NSManaged public func removeFromMovie(_ values: NSSet)

}

extension MovieGenre : Identifiable {

}
