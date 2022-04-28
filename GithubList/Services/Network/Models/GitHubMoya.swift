// swiftlint:disable force_unwrapping

import Foundation
import Moya

// MARK: - Provider support

public enum GitHub {
    case allUser(Int,Int)
    case userDetail(String)
}

extension GitHub: TargetType {
    public var baseURL: URL { URL(string: "https://api.github.com")! }
    
    public var path: String {
        switch self {
        case .allUser(_,_):
            return "/users"
        case .userDetail(let name):
            return "/users/\(name.urlEscaped)"
        }
    }
    
    public var method: Moya.Method { .get }

    public var task: Task {
        switch self {
        case .allUser(let since,let perPage):
            return .requestParameters(parameters: ["since": since, "per_page": perPage], encoding: URLEncoding.default)
        case .userDetail:
            return .requestParameters(parameters: ["sort": "pushed"], encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }

    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String: String]? {
        [ "Authorization" :  "token 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" ] }
}

public func url(_ route: TargetType) -> String {
    route.baseURL.appendingPathComponent(route.path).absoluteString
}
