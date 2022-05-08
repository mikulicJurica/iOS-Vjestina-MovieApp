import Foundation

enum MovieGroups: CaseIterable {

    case popular
    case trending
    case topRated
    case recommendations
    
    enum CodingKeys: String, CodingKey {
        case popular = "What's popular"
        case trending = "Trending"
        case topRated = "Top Rated"
        case recommendations = "Recommendations"
    }

}
