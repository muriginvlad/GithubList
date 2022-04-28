//
//  NetworkService.swift
//  GithubList
//
//  Created by Vladislav on 26.04.2022.
//

import Foundation
import Moya


protocol NetworkServiceProtocol {
    func getAllUser(since: Int, complition: @escaping (Result<MainUsersNetworkModel?, MoyaError>) -> Void)
    func getSingleUser(userName: String, complition: @escaping (Result<UserDetailNetworkModel?, MoyaError>) -> Void)
}

class NetworkService: NetworkServiceProtocol {

    
    lazy private var gitHubProvider = MoyaProvider<GitHub>(plugins: [NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter), logOptions: .verbose))])

    func getAllUser(since: Int , complition: @escaping (Result<MainUsersNetworkModel?, MoyaError>) -> Void) {
        gitHubProvider.request(.allUser(since, 50)) { result in
            switch result {
            case .success(let response):
                let responseModel = try? response.map(MainUsersNetworkModel.self)
                complition(.success(responseModel))
            case .failure(let error):
                print(error.errorDescription ?? "Unknown error")
                complition(.failure(error))
            }
        }
    }
    
    func getSingleUser(userName: String, complition: @escaping (Result<UserDetailNetworkModel?, MoyaError>) -> Void) {
        gitHubProvider.request(.userDetail(userName)) { result in
            switch result {
            case .success(let response):
                let responseModel = try? response.map(UserDetailNetworkModel.self)
                complition(.success(responseModel))
            case .failure(let error):
                complition(.failure(error))
                print(error.errorDescription ?? "Unknown error")
            }
        }
    }
    
    private func JSONResponseDataFormatter(_ data: Data) -> String {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
        } catch {
            return String(data: data, encoding: .utf8) ?? ""
        }
    }
    
}
