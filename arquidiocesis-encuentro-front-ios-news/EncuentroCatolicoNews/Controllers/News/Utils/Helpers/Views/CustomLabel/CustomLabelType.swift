//
//  CustomLabelType.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 06/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation

enum CustomLabelElement {
    case mention(String)
    case hashtag(String)
    case url(original: String, trimmed: String)
    case custom(String)
    
    static func create(with CustomLabelType: CustomLabelType, text: String) -> CustomLabelElement {
        switch CustomLabelType {
        case .mention: return mention(text)
        case .hashtag: return hashtag(text)
        case .url: return url(original: text, trimmed: text)
        case .custom: return custom(text)
        }
    }
}

public enum CustomLabelType {
    case mention
    case hashtag
    case url
    case custom(pattern: String)
    
    var pattern: String {
        switch self {
        case .mention: return RegexParser.mentionPattern
        case .hashtag: return RegexParser.hashtagPattern
        case .url: return RegexParser.urlPattern
        case .custom(let regex): return regex
        }
    }
}

extension CustomLabelType: Hashable, Equatable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .mention: hasher.combine(-1)
        case .hashtag: hasher.combine(-2)
        case .url: hasher.combine(-3)
        case .custom(let regex): hasher.combine(regex)
        }
    }
}

public func ==(lhs: CustomLabelType, rhs: CustomLabelType) -> Bool {
    switch (lhs, rhs) {
    case (.mention, .mention): return true
    case (.hashtag, .hashtag): return true
    case (.url, .url): return true
    case (.custom(let pattern1), .custom(let pattern2)): return pattern1 == pattern2
    default: return false
    }
}
