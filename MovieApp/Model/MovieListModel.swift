import Foundation

struct MovieListModel: Codable {
    let results: [MovieModel]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

