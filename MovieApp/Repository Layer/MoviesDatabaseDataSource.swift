import UIKit
import CoreData

class MoviesDatabaseDataSource {
    
    private let coreDataStack = CoreDataStack()
    lazy var managedContext = coreDataStack.persistentContainer.viewContext
    
    func fetchAllMovies(completion: ([MovieModel]?) -> Void) {
        do {
            let movie = try managedContext.fetch(Movie.fetchRequest())
            var singleMovieModel = [MovieModel]()
            for i in movie {
                let tempMovie = MovieModel(id: Int(i.id), title: i.title!, posterPath: i.posterPath!, releaseDate: i.releaseDate!, voteAverage: i.voteAverage, genreIds: i.genreIds!, adult: i.adult, backdropPath: i.backdropPath!, originalLanguage: i.originalLanguage!, originalTitle: i.originalTitle!, overview: i.overview!, voteCount: i.voteCount, popularity: i.popularity, video: i.video)
                
                singleMovieModel.append(tempMovie)
            }
            completion(singleMovieModel)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    //problem!!!!!!!!!!!
    func fetchMoviesInsideGroup(inputNameGroup: String, completion: ([MovieModel]?) -> Void) {
        
        do {
            let movie = try managedContext.fetch(Movie.fetchRequest())
            var singleMovieModel = [MovieModel]()
            
            for i in movie {
                if (i.groups == NSString(utf8String: inputNameGroup)) { //!!!!!!!!!!
                    let tempMovie = MovieModel(id: Int(i.id), title: i.title!, posterPath: i.posterPath!, releaseDate: i.releaseDate!, voteAverage: i.voteAverage, genreIds: i.genreIds!, adult: i.adult, backdropPath: i.backdropPath!, originalLanguage: i.originalLanguage!, originalTitle: i.originalTitle!, overview: i.overview!, voteCount: i.voteCount, popularity: i.popularity, video: i.video)
                    singleMovieModel.append(tempMovie)
                }
            }
            completion(singleMovieModel)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func saveMovieFirstTime(inputMovie: MovieModel, groupName: String) {
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
        
//        let group = fetchGroup(inputGroupName: groupName)
//
//        newMovie.addToGroups(group[0])
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func editMovieFavoriteState(inputMovie: MovieModel) {
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

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }
    
    func updateMovie(inputMovie: MovieModel) {
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
    
    func fetchMovieSearchFiltering(filterText: String, completion: ([MovieModel]?) -> Void) {
        do {
            let request = Movie.fetchRequest()
            let pred = NSPredicate(format: "title CONTAINS %@", "\(filterText)")
            request.predicate = pred
            
            let movie = try managedContext.fetch(request)
            var singleMovieModel = [MovieModel]()
            
            for i in movie {
                let tempMovie = MovieModel(id: Int(i.id), title: i.title!, posterPath: i.posterPath!, releaseDate: i.releaseDate!, voteAverage: i.voteAverage, genreIds: i.genreIds!, adult: i.adult, backdropPath: i.backdropPath!, originalLanguage: i.originalLanguage!, originalTitle: i.originalTitle!, overview: i.overview!, voteCount: i.voteCount, popularity: i.popularity, video: i.video)
                
                singleMovieModel.append(tempMovie)
            }
            completion(singleMovieModel)
            
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
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }

}
