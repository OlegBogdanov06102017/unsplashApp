import Foundation


public enum NetworkError : Error {
    case badURL
    case invalidStatusCode
    case emptyResponse
    case lostConnection
}
