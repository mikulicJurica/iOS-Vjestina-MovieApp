import UIKit
import CoreData

class MoviesRepository {
    
    private let movieDatabaseDataSource = MoviesDatabaseDataSource()
    private let moviesNetworkDataSource = MoviesNetworkDataSource()
    
    private var allMoviesDatabase: [Movie] = []
    private var allMoviesFromNetwork: [MovieModel] = []
    private var allGenresDatabase: [MovieGenre] = []
    private let movieGroups = MovieGroups.allCases
    
    func appLaunch(firstAppLaunchCompletion: @escaping (Bool) -> Void) {
        let group = movieDatabaseDataSource.fetchGroup(inputGroupName: movieGroups.first?.rawValue ?? "")
        if (group.count == EMPTY) {
            print("First app launch")
            
            buildRelationships(relationshipsCompletion: { isDone in
                if (isDone) {
                    print("Relationships (Groups and Genres) builded")
                    
                    self.saveAllMoviesFromNetworkToDatabase(completion: { isDone in
                        if (isDone) {
                            print("All movies added to database")
                            firstAppLaunchCompletion(true)
                        }
                    })
                }
            })
        }
        else {
            print("Not first launch")
            firstAppLaunchCompletion(true)
            
//            var tmpGroups: [String] = []
//
//            for group in movieGroups {
//                moviesNetworkDataSource.fetchMoviesByGroupName(inputGroup: group.rawValue) { completionMovieList in
//                    for movie in completionMovieList.results {
//                        self.allMoviesFromNetwork.append(movie)
//                        tmpGroups.append(group.rawValue)
//
//                        if (group == self.movieGroups.last && movie.id == completionMovieList.results.last?.id) {
//                            self.movieDatabaseDataSource.funkcija(inputMovieModelList: self.allMoviesFromNetwork, groupNames: tmpGroups, completion: { isDone in
//                                if (isDone) {
//                                    firstAppLaunchCompletion(true)
//                                }
//                            })
//                        }
//                    }
//                }
//            }
            
        }
    }
    
    func getAllMoviesFromDatabase(completion: ([Movie]?) -> Void) {
        movieDatabaseDataSource.fetchAllMoviesFromDatabase(completion: { movie in
            if let movie = movie {
                allMoviesDatabase = movie
            }
            completion(allMoviesDatabase)
        })
        
    }
    
    
    //MARK: - First app launch functions
    
    func buildRelationships(relationshipsCompletion: @escaping (Bool) -> Void) {
        for name in movieGroups {
            movieDatabaseDataSource.buildGroupRelationship(inputGroupName: name.rawValue)
        }
        
        moviesNetworkDataSource.fetchGenres(completion: { completionGenreList in
            for genre in completionGenreList.genres {
                self.movieDatabaseDataSource.buildGenreRelationship(inputGenreId: genre.id, inputGenreName: genre.name)
            }
            relationshipsCompletion(true)
        })
    }
    
    func saveAllMoviesFromNetworkToDatabase(completion: @escaping (Bool) -> Void) {
        for group in movieGroups {
            moviesNetworkDataSource.fetchMoviesByGroupName(inputGroup: group.rawValue) { completionMovieList in
                for movie in completionMovieList.results {
                    self.movieDatabaseDataSource.saveMovieToDatabase(inputMovie: movie, groupName: group.rawValue, completion: { isDone in
                        if (isDone && group == self.movieGroups.last && movie.id == completionMovieList.results.last?.id) {
                            completion(true)
                        }
                    })
                }
            }
        }
    }
    
    //MARK: - Search filtering
    
    func getSearchingMovies(searchString: String, completion: ([Movie]?) -> Void) {
        movieDatabaseDataSource.fetchMovieSearchFiltering(filterText: searchString, completion: { movie in
            if let movie = movie {
                allMoviesDatabase = movie
            }
            completion(allMoviesDatabase)
        })
    }
    
    //MARK: - Fetch movies based on group and filter button
    
    //get movies based on group
    func getMovieList(groupName: String, completion: ([Movie]?) -> Void) {
        movieDatabaseDataSource.fetchMoviesByGroup(inputNameGroup: groupName, completion: { movie in
            if let movie = movie {
                allMoviesDatabase = movie
            }
            completion(movie)
        })
    }
    
    //get movies based on group and filter
    func getMovieListByFilter(groupName: String, completion: ([Movie]?) -> Void) {
        movieDatabaseDataSource.fetchMoviesByGroupAndFilter(inputNameGroup: groupName, completion: { movie in
            if let movie = movie {
                allMoviesDatabase = movie
            }
            completion(movie)
        })
    }
    
    //MARK: - Favorite movies functions
    
    func getFavoriteMovies(completion: ([Movie]?) -> Void) {
        movieDatabaseDataSource.fetchFavoriteMovies(completion: { movies in
            completion(movies)
        })
    }
    
    func changeFavoriteMovieState(inputMovie: Movie, completion: (Bool) -> Void) {
        movieDatabaseDataSource.editMovieFavoriteState(inputMovie: inputMovie, completion: { isDone in
            completion(isDone)
        })
    }
    
    //MARK: - To see what genres do exist
    
    func getAllGenres(completion: ([MovieGenre]?) -> Void) {
        movieDatabaseDataSource.fetchAllGenresFromDatabase(completion: { genre in
            if let genre = genre {
                allGenresDatabase = genre
            }
            completion(allGenresDatabase)
        })
    }
    
}
