import Foundation

struct MovieListModel: Codable {
    var results: [MovieModel]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}
