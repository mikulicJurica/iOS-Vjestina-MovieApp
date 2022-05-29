import UIKit
import CoreData

class MoviesRepository {
    
    private let movieDatabaseDataSource = MoviesDatabaseDataSource()
    private let moviesNetworkDataSource = MoviesNetworkDataSource()
    
    private var allMoviesDatabase: [MovieModel] = []
    var movieListModel = MovieListModel(results: [])
        
    
    func getAllMoviesFromDatabase(completion: ([MovieModel]?) -> Void) {
        
        if (self.allMoviesDatabase.count != 0) {
            print("nije prazno")
            movieDatabaseDataSource.fetchAllMovies(completion: { movie in
                if let movie = movie {
                    allMoviesDatabase = movie
                }
                completion(allMoviesDatabase)
            })
        }
        
        
        //first launch
        else {
            
            allMoviesFromNetworkToDatabase()
            
            movieDatabaseDataSource.fetchAllMovies(completion: { movie in
                if let movie = movie {
                    allMoviesDatabase = movie
                }
                completion(allMoviesDatabase)
            })
        }
    }
    
    
    //problem
    func getMovieTop() {
        
        movieDatabaseDataSource.fetchMoviesInsideGroup(inputNameGroup: "top_rated", completion: { movie in
            if let movie = movie {
                allMoviesDatabase = movie
            }
//            DispatchQueue.main.async {
//                print(self.allMoviesDatabase)
//            }
        })
    }
    
    func getMovieGenres() {
        moviesNetworkDataSource.fetchGenreNames(completion: { completion in
            print(completion)
        })
    }
    
    func relationships() {
        let listOfGroups = ["popular", "trending", "top_rated", "recommendations"]
        
        for name in listOfGroups {
            movieDatabaseDataSource.buildGroupRelationship(inputGroupName: name)
        }
    }
    
    
    //if database is empty
    func allMoviesFromNetworkToDatabase() {
        
        let listOfGroups = ["popular", "trending", "top_rated", "recommendations"]
        
        for group in listOfGroups {
            moviesNetworkDataSource.fetchMoviesByGroupName(inputGroup: group) { completion in
                for movie in completion.results {
                    self.movieDatabaseDataSource.saveMovieFirstTime(inputMovie: movie, groupName: group)
                }
            }
        }
    }
    
    func getMoviesGroup() {
    }
}
