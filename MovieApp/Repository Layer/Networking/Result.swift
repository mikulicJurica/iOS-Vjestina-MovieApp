import Foundation

enum Result<Success, Failure> where Failure : Error {
    case success(Success) //any type
    case failure(Failure) //type of error
}
