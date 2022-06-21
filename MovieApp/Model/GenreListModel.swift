import Foundation

struct GenreListModel: Codable {
    let genres: [GenreModel]
    
    enum CodingKeys: String, CodingKey {
        case genres
    }
}
