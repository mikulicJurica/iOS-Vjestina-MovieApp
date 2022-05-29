import Foundation

struct MovieModel: Codable {

    let id: Int
    let title: String
    let posterPath: String
    let releaseDate: String
    let voteAverage: Float
    let genreIds: [Int]
    let adult: Bool
    let backdropPath: String
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let voteCount: Int16
    let popularity: Float
    let video: Bool
    
    //let runtime: Int
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case genreIds = "genre_ids"
        case adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case voteCount = "vote_count"
        case popularity
        case video
        
        //case runtime
    }
    
}
