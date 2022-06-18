import UIKit
import CoreData

class MoviesDatabaseDataSource {
    
    private let coreDataStack = CoreDataStack()
    lazy var managedContext = coreDataStack.persistentContainer.viewContext
    
    func fetchAllMoviesFromDatabase(completion: ([Movie]?) -> Void) {
        do {
            let movies = try managedContext.fetch(Movie.fetchRequest())
            completion(movies)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func fetchMoviesByGroup(inputNameGroup: String, completion: ([Movie]?) -> Void) {
        
        do {
            let request: NSFetchRequest<MovieGroup> = MovieGroup.fetchRequest()
            let predicate = NSPredicate(format: "name = %@", "\(inputNameGroup)")
            request.predicate = predicate
            request.fetchLimit = 1
            
            do {
                let movieGroup = try managedContext.fetch(request)
                guard let moviesCoreData = movieGroup[0].movie?.allObjects as? [Movie] else { return }
                completion(moviesCoreData)
                
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    
    
    
    func fetchMoviesByGroupAndFilter(inputNameGroup: String, completion: ([Movie]?) -> Void) {
        
        do {
            let request: NSFetchRequest<MovieGroup> = MovieGroup.fetchRequest()
            let predicate = NSPredicate(format: "name = %@", "\(inputNameGroup)")
            request.predicate = predicate
            request.fetchLimit = 1
            
            do {
                let movieGroup = try managedContext.fetch(request)
                guard let moviesCoreData = movieGroup[0].movie?.allObjects as? [Movie] else { return }
                
                completion(moviesCoreData)
                
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func saveMovieToDatabase(inputMovie: MovieModel, groupName: String, completion: (Bool) -> Void) {
        checkForMovieInDatabase(inputMovie: inputMovie, completion: { (movieCheck, existingMovie) in
            if (movieCheck) {
                if let existingMovie = existingMovie {
                    let group = fetchGroup(inputGroupName: groupName)
                    existingMovie.addToGroups(group[0])
                }
            }
            else {
                let newMovie = Movie(context: managedContext)
                
                newMovie.id = Int16(truncatingIfNeeded: inputMovie.id)
                newMovie.title = inputMovie.title
                newMovie.posterPath = inputMovie.posterPath
                newMovie.releaseDate = inputMovie.releaseDate
                newMovie.voteAverage = inputMovie.voteAverage
                newMovie.genreIds = inputMovie.genreIds
                newMovie.adult = inputMovie.adult
                newMovie.backdropPath = inputMovie.backdropPath
                newMovie.originalLanguage = inputMovie.originalLanguage
                newMovie.originalTitle = inputMovie.originalTitle
                newMovie.overview = inputMovie.overview
                newMovie.voteCount = inputMovie.voteCount
                newMovie.popularity = inputMovie.popularity
                newMovie.video = inputMovie.video
                newMovie.favorite = false
                
                let group = fetchGroup(inputGroupName: groupName)
                newMovie.addToGroups(group[0])
                
                for genreId in inputMovie.genreIds {
                    let genre = fetchGenre(inputGenreId: genreId)
                    newMovie.addToGenres(genre[0])
                }
            }
            do {
                try managedContext.save()
                completion(true)
                
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        })
    }
    
    func funkcija(inputMovieModelList: [MovieModel], groupNames: [String], completion: (Bool) -> Void) {
        let tmpGroups = groupNames
        var tmpUpdatedPositions: [Int] = []
        var position = 0
        
        fetchAllMoviesFromDatabase(completion: { movieList in
            for movieFromDatabase in movieList! {
                position = 0
                for movieFromNetwork in inputMovieModelList {
                    if (movieFromDatabase.id == movieFromNetwork.id) {
                        
                        //print("Update\(position): \(movieFromDatabase.title)=\(movieFromNetwork.title)")
                        
                        tmpUpdatedPositions.append(position)
                        
                        updateMovieInDatabase(inputMovie: movieFromNetwork)
                        
                        break
                    }
                    
                    else if (movieFromNetwork.id == inputMovieModelList.last?.id) {
                        print("zadnji iz mreze, pozicija= \(position)")
                        if (movieFromDatabase.id != movieFromNetwork.id) {
                            if (movieFromDatabase.favorite == true) {

                                print("destroy relationship")
                                //destroy group relationship


                            }
                            else {
                                print("delete movie")
                                //deleteMovie(inputMovie: movieFromNetwork)
                            }
                        }
                    }
                    position += 1
                }
                
                if (movieFromDatabase == movieList?.last) {
                    
                    completion(true)
                    
//                    checkForMovieInDatabase(inputMovie: inputMovie, completion: { (movieCheck, existingMovie) in
//                        if (movieCheck) {
//                            if let existingMovie = existingMovie {
//                                //update movie
//                                do {
//
//                                } catch let error as NSError {
//                                    print("Could not fetch. \(error), \(error.userInfo)")
//                                }
//                            }
//                        }
//                        else {
//                            let newMovie = Movie(context: managedContext)
//
//                            newMovie.id = Int16(truncatingIfNeeded: inputMovie.id)
//                            newMovie.title = inputMovie.title
//                            newMovie.posterPath = inputMovie.posterPath
//                            newMovie.releaseDate = inputMovie.releaseDate
//                            newMovie.voteAverage = inputMovie.voteAverage
//                            newMovie.genreIds = inputMovie.genreIds
//                            newMovie.adult = inputMovie.adult
//                            newMovie.backdropPath = inputMovie.backdropPath
//                            newMovie.originalLanguage = inputMovie.originalLanguage
//                            newMovie.originalTitle = inputMovie.originalTitle
//                            newMovie.overview = inputMovie.overview
//                            newMovie.voteCount = inputMovie.voteCount
//                            newMovie.popularity = inputMovie.popularity
//                            newMovie.video = inputMovie.video
//                            newMovie.favorite = true
//
//                            let group = fetchGroup(inputGroupName: groupName)
//                            newMovie.addToGroups(group[0])
//
//                            for genreId in inputMovie.genreIds {
//                                let genre = fetchGenre(inputGenreId: genreId)
//                                newMovie.addToGenres(genre[0])
//                            }
//                        }
//                        do {
//                            try managedContext.save()
//                            completion(true)
//
//                        } catch let error as NSError {
//                            print("Could not fetch. \(error), \(error.userInfo)")
//                        }
//                    })
                }
                
//                if (movieFromDatabase == movieList?.last) {
//                    print("Last in database")
//                    position = 0
//                    print("\(tmpUpdatedPositions.count) azuriranih filmova")
//
//                    if (tmpUpdatedPositions.count > 0) {
//
//                        for tmpMovieFromNetwork in inputMovieModelList {
//
//                            let newMovie = Movie(context: managedContext)
//
//                            newMovie.id = Int16(truncatingIfNeeded: tmpMovieFromNetwork.id)
//                            newMovie.title = tmpMovieFromNetwork.title
//                            newMovie.posterPath = tmpMovieFromNetwork.posterPath
//                            newMovie.releaseDate = tmpMovieFromNetwork.releaseDate
//                            newMovie.voteAverage = tmpMovieFromNetwork.voteAverage
//                            newMovie.genreIds = tmpMovieFromNetwork.genreIds
//                            newMovie.adult = tmpMovieFromNetwork.adult
//                            newMovie.backdropPath = tmpMovieFromNetwork.backdropPath
//                            newMovie.originalLanguage = tmpMovieFromNetwork.originalLanguage
//                            newMovie.originalTitle = tmpMovieFromNetwork.originalTitle
//                            newMovie.overview = tmpMovieFromNetwork.overview
//                            newMovie.voteCount = tmpMovieFromNetwork.voteCount
//                            newMovie.popularity = tmpMovieFromNetwork.popularity
//                            newMovie.video = tmpMovieFromNetwork.video
//                            newMovie.favorite = false
//
//                            let group = fetchGroup(inputGroupName: tmpGroups[position])
//                            newMovie.addToGroups(group[0])
//
//                            position += 1
//
//                            for genreId in tmpMovieFromNetwork.genreIds {
//                                let genre = fetchGenre(inputGenreId: genreId)
//                                newMovie.addToGenres(genre[0])
//                            }
//                        }
//                        completion(true)
//                    }
//
//                    else {
//                        completion(true)
//                    }
//                }
            }
        })
        
        

    }
    
    
    func checkForMovieInDatabase(inputMovie: MovieModel, completion: (Bool, Movie?) -> Void) {
        do {
            let request: NSFetchRequest<Movie> = Movie.fetchRequest()
            let predicate = NSPredicate(format: "id = %@", "\(inputMovie.id)")
            request.predicate = predicate
            request.fetchLimit = 1
            do {
                let movie = try managedContext.fetch(request)
                if (movie.count > 0) {
                    completion(true, movie[0])
                }
                else {
                    completion(false, nil)
                }
                
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    //update movie in database with new data
    func updateMovieInDatabase(inputMovie: MovieModel) {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        let predicate = NSPredicate(format: "id = %@", "\(inputMovie.id)")
        request.predicate = predicate
        request.fetchLimit = 1
        
        do {
            let movie = try managedContext.fetch(request)
            
            movie[0].id = Int16(truncatingIfNeeded: inputMovie.id)
            movie[0].title = inputMovie.title
            movie[0].posterPath = inputMovie.posterPath
            movie[0].releaseDate = inputMovie.releaseDate
            movie[0].voteAverage = inputMovie.voteAverage
            movie[0].genreIds = inputMovie.genreIds
            movie[0].adult = inputMovie.adult
            movie[0].backdropPath = inputMovie.backdropPath
            movie[0].originalLanguage = inputMovie.originalLanguage
            movie[0].originalTitle = inputMovie.originalTitle
            movie[0].overview = inputMovie.overview
            movie[0].voteCount = inputMovie.voteCount
            movie[0].popularity = inputMovie.popularity
            movie[0].video = inputMovie.video
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        do {
            try managedContext.save()

        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: - Favorite functions
    
    func editMovieFavoriteState(inputMovie: Movie, completion: (Bool) -> Void) {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        let predicate = NSPredicate(format: "id = %@", "\(inputMovie.id)")
        request.predicate = predicate
        request.fetchLimit = 1
        
        do {
            let movie = try managedContext.fetch(request)
            if (movie[0].favorite == true) {
                movie[0].favorite = false
            }
            else {
                movie[0].favorite = true
            }
            
            do {
                try managedContext.save()
                completion(true)
                
            } catch let error as NSError {
                print("Could not update. \(error), \(error.userInfo)")
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func fetchFavoriteMovies(completion: ([Movie]?) -> Void) {
        do {
            let request = Movie.fetchRequest()
            let predicate = NSPredicate(format: "favorite == %@", NSNumber(value: true))
            request.predicate = predicate
            
            let movies = try managedContext.fetch(request)
            completion(movies)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: - Groups Functions
    
    func buildGroupRelationship(inputGroupName: String) {
        let movieGroup = MovieGroup(context: managedContext)
        movieGroup.name = inputGroupName
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func fetchGroup(inputGroupName: String) -> [MovieGroup] {
        let request: NSFetchRequest<MovieGroup> = MovieGroup.fetchRequest()
        let predicate = NSPredicate(format: "name = %@", "\(inputGroupName)")
        request.predicate = predicate
        request.fetchLimit = 1
        
        do {
            return try managedContext.fetch(request)
        } catch let error as NSError {
            print("Error \(error) | Info: \(error.userInfo)")
            return []
        }
    }
    
    //MARK: - Genres Functions
    
    func buildGenreRelationship(inputGenreId: Int, inputGenreName: String) {
        let movieGenre = MovieGenre(context: managedContext)
        movieGenre.id = Int16(inputGenreId)
        movieGenre.name = inputGenreName
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func fetchGenre(inputGenreId: Int) -> [MovieGenre] {
        let request: NSFetchRequest<MovieGenre> = MovieGenre.fetchRequest()
        let predicate = NSPredicate(format: "id = %@", "\(inputGenreId)")
        request.predicate = predicate
        request.fetchLimit = 1
        
        do {
            return try managedContext.fetch(request)
        } catch let error as NSError {
            print("Error \(error) | Info: \(error.userInfo)")
            return []
        }
    }
    
    //MARK: - Search Filtering
    
    func fetchMovieSearchFiltering(filterText: String, completion: ([Movie]?) -> Void) {
        do {
            let request = Movie.fetchRequest()
            let pred = NSPredicate(format: "title CONTAINS %@", "\(filterText)")
            request.predicate = pred
            
            let movies = try managedContext.fetch(request)
            completion(movies)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    
    
    
    func deleteMovie(inputMovie: MovieModel) {
        
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        let predicate = NSPredicate(format: "id = %@", "\(inputMovie.id)")
        request.predicate = predicate
        request.fetchLimit = 1
        
        do {
            let movie = try managedContext.fetch(request)
            managedContext.delete(movie[0])
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        do {
            try managedContext.save()
            print("Movie deleted")
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }
    
}
