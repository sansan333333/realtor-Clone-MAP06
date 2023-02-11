//
//  SearchModel.swift
//  v3
//
//  Created by Jun on 2023-02-09.
//

import UIKit

struct SearchModel: Codable {
    let Results: [SearchResult]
}

struct SearchResult: Codable {
    let ListingId, ReferenceNumber, Address_EN, City, PostalCode, Province, RelativeURLEn: String
}
