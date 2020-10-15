import os.log
import Foundation
import Alamofire

class NetworkManager {
    
    typealias WebServiceResponse<T> = (T?, AFError?) -> Void
    static let shared = NetworkManager()
    
    private init() { }
    
    func fetch<T: Decodable>(_ data: T.Type, url: API, _ completion: @escaping WebServiceResponse<T>) {
        AF
        .request(url.rawValue)
        .validate()
        .responseDecodable(of: data) { (response) in
            switch response.result {
            case .success(let fetchedResults):
                completion(fetchedResults, nil)
            case .failure(let error):
                os_log(.default, log: .network, "Couldn't fetch data, an error occured: %@", error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
}

enum API: String {
    case numbers = "http://client.proexe.eu/json.json"
}
