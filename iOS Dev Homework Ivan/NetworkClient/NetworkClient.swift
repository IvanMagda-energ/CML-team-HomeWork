//
//  NetworkClient.swift
//  iOS Dev Homework Ivan
//
//  Created by Иван Магда on 24.06.2022.
//

import Foundation
import Alamofire


class NetworkClient{
    
    static let shared = NetworkClient()
    
    private let baseURL = "https://re-next-qa.cmlteam.com"
    private let defaultHeaders: HTTPHeaders = [HTTPHeader(name: "Content-Type", value: "application/json")]
    private var authModel: AuthorizationModel?
    
    func loginRequest (email: String, password: String, completionHandler: @escaping (Error?) -> Void){
        
        let url = baseURL + "/auth/login"
        let parameters: [String: String] = ["email": email, "password": password]
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoder: .json,
                   headers: defaultHeaders).response { response in
            switch response.result {
            case .success(let successData):
                do {
                    let decoder = JSONDecoder()
                    self.authModel = try decoder.decode(AuthorizationModel.self, from: successData!)
                    completionHandler(nil)
                } catch {
                    completionHandler(error)
                }
            case .failure(let error):
                completionHandler(error)
            }
        }
    }
    
    func getCurrentUserRequest (completionHandler: @escaping (Result<CurrentUserModel, Error>) -> Void){
        let url = baseURL + "/auth/current-user"
        var headers: HTTPHeaders = defaultHeaders
        let authHeadersValue: String = "\(authModel?.tokenType ?? "") \(authModel?.accessToken ?? "")"
        headers.add(HTTPHeader(name: "Authorization", value: authHeadersValue))
        
        AF.request(url,
                   method: .get,
                   headers: headers).response { response in
            switch response.result {
            case .success(let successData):
                do {
                    let decoder = JSONDecoder()
                    let currentUser = try decoder.decode(CurrentUserModel.self, from: successData!)
                    completionHandler(.success(currentUser))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getAllPropertiesRequest (accountId: Int, completionHandler: @escaping (Result<PropertiesModel, Error>) -> Void){
        let url = baseURL + "/api/property/list?page=0&pageSize=10&accountId=\(String(accountId))"
        var headers: HTTPHeaders = defaultHeaders
        let authHeaderValue: String = "\(authModel?.tokenType ?? "") \(authModel?.accessToken ?? "")"
        headers.add(HTTPHeader(name: "Authorization", value: authHeaderValue))
        
        AF.request(url,
                   method: .get,
                   headers: headers).response { response in
            switch response.result {
            case .success(let successData):
                do {
                    let decoder = JSONDecoder()
                    let propertiesModel = try decoder.decode(PropertiesModel.self, from: successData!)
                    completionHandler(.success(propertiesModel))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

