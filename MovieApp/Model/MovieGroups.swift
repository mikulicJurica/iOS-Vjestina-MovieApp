import Foundation

enum MovieGroups: CaseIterable {

    case popular
    case trending
    case topRated
    case recommendations

    enum CodingKeys: String, CodingKey {
        case popular = "popular"
        case trending = "trending"
        case topRated = "top_rated"
        case recommendations = "recommendations"
    }
}
