import UIKit
import CoreData

class MoviesNetworkDataSource {
    
    private var networkService = NetworkService()
    
    func fetchMoviesByGroupName(inputGroup: String, completion: @escaping (MovieListModel) -> Void) {
        networkService.getMovieList(listName: inputGroup, completionHandler: { (result: Result<MovieListModel, RequestError>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let value):
                DispatchQueue.main.async {
                    completion(value)
                }
            }
        })
    }
    
    func fetchGenres(completion: @escaping (GenreListModel) -> Void) {
        networkService.getGenreList(completionHandler: { (result: Result<GenreListModel, RequestError>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let value):
                DispatchQueue.main.async {
                    completion(value)
                }
            }
        })
    }
}
