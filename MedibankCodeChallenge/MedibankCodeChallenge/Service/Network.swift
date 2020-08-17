//  Copyright © 2020 Michael.H. All rights reserved.

import UIKit
import RxSwift

enum HTTPMethod {
    case get
    case post
    case patch
    case delete
    
    func name() -> String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .patch: return "PATCH"
        case .delete: return "DELETE"
        }
    }
}

enum NetworkService {
    case headline
    case source
    
    func urlComponent() -> URLComponents {
        // Base url
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "newsapi.org"
        
        // Path
        switch self {
        case .headline:
            urlComponent.path = "/v2/top-headlines"
            
        case .source:
            urlComponent.path = "/v2/sources/"
        }
        
        // Querries
        let lang = URLQueryItem(name: "language", value: "en")
        let apiKey = URLQueryItem(name: "apiKey", value: "b527d50560154e48bc7aa04c10e97f04")
        urlComponent.queryItems = [lang, apiKey]
        
        return urlComponent
    }
}

class NetworkClient {
    
    @discardableResult func networkRequest<T> (_ service: NetworkService, querries: [URLQueryItem] = []) -> Single<T> where T: Decodable {
        return Single<T>.create { single in
            
            var urlComponent = service.urlComponent()
            
            if querries.count > 0 {
                for querry in querries {
                    urlComponent.queryItems?.append(querry)
                }
            }
            
            guard let url = urlComponent.url else {
                return Disposables.create()
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.get.name()
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                self.handleResult(data: data,
                                  response: response,
                                  error: error,
                                  single: single)
            }
            task.resume()
            return Disposables.create(with: task.cancel)
        }
    }
    
    // MARK: - Private helper
    private func handleResult<T>(data: Data?,
                                 response: URLResponse?,
                                 error: Error?,
                                 single: @escaping (SingleEvent<T>) -> Void) where T: Decodable {
        if let error = error {
            handleError(error: error, single: single)
        }
        else {
            handleResponse(data: data, response: response, single: single)
        }
    }
    
    private func handleResponse<T>(data: Data?,
                                   response: URLResponse?,
                                   single: @escaping (SingleEvent<T>) -> Void) where T: Decodable {
        if let data = data, !data.isEmpty {
            do {
                let value = try T.decode(jsonData: data)
                single(.success(value))
                return
            }
            catch {
                single(.error(AppError.decodeError))
            }
        }
        return
    }
    
    private func handleError<T>(error: Error?,
                                single: @escaping (SingleEvent<T>) -> Void) where T: Decodable {
        single(.error(AppError.networkServiceFailed))
    }
    
}
