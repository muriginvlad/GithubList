//
//  StringExtension.swift
//  GithubList
//
//  Created by Vladislav on 26.04.2022.
//

import Foundation

extension String {
    var urlEscaped: String {
        self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

extension String {
    
    public enum DateFormatType {
        case isoDate
        case isoDateTime
       
        var stringFormat:String {
            switch self {
            case .isoDate: return "yyyy-MM-dd"
            case .isoDateTime: return "yyyy-MM-dd'T'HH:mmZ"
            }
        }
    }
    
    func toDate(_ format: DateFormatType = .isoDate) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.stringFormat
        let date = dateFormatter.date(from: self)
        return date
    }
}
