//
//  Model.swift
//  v3
//
//  Created by Jun on 2023-02-07.
//

import UIKit

struct PropertyMain: Codable {
    let PropertyList: PropertyList
}

struct PropertyList: Codable {
    let Results: [Result]?
    let Pins: [Pin]?
}

struct Pin: Codable {
    let propertyId: String?
    let count: Int?
    let longitude, latitude: String?
}

struct Result: Codable {
    let Id, MlsNumber, PublicRemarks: String?
    let Individual: [Individual]?
    let Property: Property?
    let Building: Building?
    let Land: Land?
    let PostalCode, RelativeDetailsURL: String?
}

struct Individual: Codable {
    let IndividualID: Int?
    let Name: String?
    let Organization: Organization
    let Phones: [Phone]?
    let PhotoHighRes: String?
}
    
struct Phone: Codable {
    let PhoneNumber, AreaCode: String?
}

struct Land: Codable {
    let SizeTotal: String?
}
 
struct Property: Codable {
    let Price: String?
    let Address: Address?
    let Photo: [Photo]?
    let ConvertedPrice, PriceUnformattedValue: String?
}

struct Address: Codable {
    let AddressText, Longitude, Latitude: String?
}

struct Photo: Codable {
    let HighResPath: String?
}

struct Building: Codable {
    let BathroomTotal, Bedrooms, StoriesTotal: String?
}

struct Organization: Codable {
    let OrganizationID: Int?
    let Name: String?
    let Logo: String?
    let Address: OrganizationAddress?
    let Websites: [Website]?
    let OrganizationType, designation: String?
    let RelativeDetailsURL: String?
}

struct OrganizationAddress: Codable{
    let AddressText: String?
}

struct Website: Codable{
    let Website: String?
}
