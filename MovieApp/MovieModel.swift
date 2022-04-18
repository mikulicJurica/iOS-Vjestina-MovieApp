import UIKit

public struct MovieModel {

    public let id = UUID()
    public let title: String
    public let group: [MovieGroup]
    public let genre: Genre
    public let imageUrl: String
    public let description: String
    public let score: Int // up to 100
    public let year: Int
    public let length: Int // in minutes
    public let cast: [Cast]
    public let favorite: Bool

}

public struct Cast {

    public let name: String
    public let type: CastType

}

public enum CastType {

    case actor
    case director

}

public enum MovieFilter: String {

    case streaming = "Steaming"
    case onTv = "On TV"
    case forRent = "For Rent"
    case inTheaters = "In theaters"

    // genre
    case thriller
    case horror
    case comedy
    case romanticComedy
    case sport
    case action
    case sciFi
    case war
    case drama

    // time filters
    case day
    case week
    case month
    case allTime
}

public enum MovieGroup: CaseIterable {

    case popular
    case freeToWatch
    case trending
    case topRated
    case upcoming

    public var filters: [MovieFilter] {
        switch self {
        case .popular:
            return [.streaming, .onTv, .forRent, .inTheaters]
        case .freeToWatch:
            return [.drama, .thriller, .horror, .comedy, .romanticComedy, .sport, .action, .sciFi, .war]
        case .trending:
            return [.day, .week, .month, .allTime]
        case .topRated:
            return [.day, .week, .month, .allTime]
        case .upcoming:
            return [.drama, .thriller, .horror, .comedy, .romanticComedy, .sport, .action, .sciFi, .war]
        }
    }

}

public enum Genre {

    case thriller
    case horror
    case comedy
    case romanticComedy
    case sport
    case action
    case sciFi
    case war
    case drama

}
