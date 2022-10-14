//
//  String+Extensions.swift
//  EncuentroCatolicoProfile
//
//  Created by René Sandoval on 17/04/21.
//

public extension String {
    var isEmptyStr: Bool {
        return trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty
    }
}

extension String {
    var forSorting: String {
        let simple = folding(options: [.diacriticInsensitive, .widthInsensitive, .caseInsensitive], locale: nil)
        let nonAlphaNumeric = CharacterSet.alphanumerics.inverted
        return simple.components(separatedBy: nonAlphaNumeric).joined(separator: "")
    }
}
