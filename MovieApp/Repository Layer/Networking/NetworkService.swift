import Foundation

protocol NetworkServiceProtocol {
}

class NetworkService {
    
    let apiKey = "73b799ad19dc8be5b63d80264b6b1fa2"
    let baseUrl = "https://api.themoviedb.org/3/"
    
    func getMovieList(listName: String, completionHandler: @escaping (Result<MovieListModel, RequestError>) -> Void) {
        let trendingInterval = "day"
        var url: URL!

        if (listName == MovieGroups.recommendations.rawValue) {
            url = URL(string: "\(baseUrl)movie/103/recommendations?language=en-US&page=1&api_key=\(apiKey)")!
            
        } else if (listName == MovieGroups.trending.rawValue) {
            url = URL(string: "\(baseUrl)trending/movie/\(trendingInterval)?api_key=73b799ad19dc8be5b63d80264b6b1fa2&page=1")!

        } else {
            url = URL(string: "\(baseUrl)movie/\(listName)?language=en-US&page=1&api_key=\(apiKey)")!

        }
    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        executeUrlRequest(request, completionHandler: completionHandler)
    }
    
    func getGenreList(completionHandler: @escaping (Result<GenreListModel, RequestError>) -> Void) {
        let url = URL(string: "\(baseUrl)genre/movie/list?language=en-US&api_key=\(apiKey)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        executeUrlRequest(request, completionHandler: completionHandler)
    }
    
    private func executeUrlRequest<T: Decodable>(_ request: URLRequest, completionHandler: @escaping (Result<T, RequestError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else {
                completionHandler(.failure(.clientError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noDataError))
                return
            }
            guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                completionHandler(.failure(.decodingError))
                return
            }
            
            DispatchQueue.main.async {
                completionHandler(.success(value))
            }
        }
        
        dataTask.resume()
    }
    
}
