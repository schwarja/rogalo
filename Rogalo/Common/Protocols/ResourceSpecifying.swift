//
//  Resource.swift
//  Rogalo
//
//  Created by Jan on 18.03.2021.
//

import Foundation

protocol ResourceSpecifying {
    var resourceName: String { get }
    var extensionName: String { get }
    var fileName: String { get }
}

extension ResourceSpecifying {
    var localizedResourceName: String {
        "\(resourceName)-\(Constants.currentLocalization.rawValue)"
    }
    
    var fileName: String {
        "\(localizedResourceName).\(extensionName)"
    }
}
