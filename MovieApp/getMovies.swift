import Foundation
import MovieAppData

private let movies = Movies.all()

func getAllMovieData() -> [MovieAppData.MovieModel] {
    return movies
}

func getNumberOfAllMovies() -> Int {
    return movies.count
}

//func getMovies() -> [MovieAppData.MovieModel] {
//
//    let hasBatman = movies.map { $0.title }.contains("The Batman")
//}
