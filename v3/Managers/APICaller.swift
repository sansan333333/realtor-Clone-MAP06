//
//  APICaller.swift
//  v3
//
//  Created by Jun on 2023-02-08.
//

import Foundation


enum APIError: Error {
    case failedTogetData
}

class APICaller {
    static let shared = APICaller()
    
    
    
    
    
    
    
    
    //To refer to the built in Result type, you can either rename your struct to something else, or you qualify it with Swift.Result:
    //https://stackoverflow.com/questions/67656782/cannot-specialize-non-generic-type-result
    
    func getHomePageList(for currentPage: Int, completion: @escaping (Swift.Result<[Result],Error>) -> Void) {
        let endpoint = "https://realty-in-ca1.p.rapidapi.com/properties/list-residential?LatitudeMax=45.52265&LatitudeMin=45.51693&LongitudeMax=-73.71859&LongitudeMin=-73.72878&CurrentPage=\(currentPage)&RecordsPerPage=100&SortOrder=A&SortBy=1&CultureId=1&NumberOfDays=0&BedRange=0-0&BathRange=0-0&RentMin=0"
        
        guard let url = URL(string: endpoint) else {
            //            completed(nil, "This username created an invalid request. Please try again.")
            return
        }
        
        let headers = [
            "X-RapidAPI-Key": "53294f5dccmsh1441fa14fc4456dp1b1d97jsnc612376d341e",
            "X-RapidAPI-Host": "realty-in-ca1.p.rapidapi.com"
//            "X-RapidAPI-Host": "realtor-canadian-real-estate.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, _, error in
            
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(PropertyList.self, from: data)
                completion(.success(results.Results!))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    
    func getSearchList(for query: String, completion: @escaping (Swift.Result<[SearchResult],Error>) -> Void) {
        
        guard query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) != nil else { return }
        
        let endpoint = "https://realty-in-ca1.p.rapidapi.com/locations/v2/auto-complete?Query=\(query)&CultureId=1&IncludeLocations=true"
        
        guard let url = URL(string: endpoint) else {
            //            completed(nil, "This username created an invalid request. Please try again.")
            return
        }
        
        let headers = [
            "X-RapidAPI-Key": "53294f5dccmsh1441fa14fc4456dp1b1d97jsnc612376d341e",
            "X-RapidAPI-Host": "realtor-canadian-real-estate.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, _, error in
            
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(SearchModel.self, from: data)
                completion(.success(results.Results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func SearchByMLS(for mls: String, completion: @escaping (Swift.Result<[Result],Error>) -> Void) {
        
        guard mls.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) != nil else { return }
        
        let endpoint = "https://realty-in-ca1.p.rapidapi.com/properties/list-by-mls?ReferenceNumber=\(mls)&CultureId=1"
        
        guard let url = URL(string: endpoint) else {
            //            completed(nil, "This username created an invalid request. Please try again.")
            return
        }
        
        let headers = [
            "X-RapidAPI-Key": "53294f5dccmsh1441fa14fc4456dp1b1d97jsnc612376d341e",
            "X-RapidAPI-Host": "realtor-canadian-real-estate.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, _, error in
            
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(PropertyList.self, from: data)
                completion(.success(results.Results!))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    
    
    func getGPSAnotations(for currentPage: Int, completion: @escaping (Swift.Result<[Pin],Error>) -> Void) {
        let endpoint = "https://realty-in-ca1.p.rapidapi.com/properties/list-residential?LatitudeMax=45.52265&LatitudeMin=45.51693&LongitudeMax=-73.71859&LongitudeMin=-73.72878&CurrentPage=\(currentPage)&RecordsPerPage=100&SortOrder=A&SortBy=1&CultureId=1&NumberOfDays=0&BedRange=0-0&BathRange=0-0&RentMin=0"
        
        guard let url = URL(string: endpoint) else {
            //            completed(nil, "This username created an invalid request. Please try again.")
            return
        }
        
        let headers = [
            "X-RapidAPI-Key": "53294f5dccmsh1441fa14fc4456dp1b1d97jsnc612376d341e",
            "X-RapidAPI-Host": "realty-in-ca1.p.rapidapi.com"
//            "X-RapidAPI-Host": "realtor-canadian-real-estate.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, _, error in
            
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(PropertyList.self, from: data)
                completion(.success(results.Pins!))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }

    
    func getHomePageListByUpdateGPS(for currentPage: Int, LatitudeMax: Double, LatitudeMin: Double, LongitudeMax: Double, LongitudeMin: Double, completion: @escaping (Swift.Result<[Pin],Error>) -> Void) {
        let endpoint = "https://realty-in-ca1.p.rapidapi.com/properties/list-residential?LatitudeMax=\(LatitudeMax)&LatitudeMin=\(LatitudeMin)&LongitudeMax=\(LongitudeMax)&LongitudeMin=\(LongitudeMin)&CurrentPage=\(currentPage)&RecordsPerPage=100&SortOrder=A&SortBy=1&CultureId=1&NumberOfDays=0&BedRange=0-0&BathRange=0-0&RentMin=0"
        
        guard let url = URL(string: endpoint) else {
            //            completed(nil, "This username created an invalid request. Please try again.")
            return
        }
        
        let headers = [
            "X-RapidAPI-Key": "53294f5dccmsh1441fa14fc4456dp1b1d97jsnc612376d341e",
            "X-RapidAPI-Host": "realty-in-ca1.p.rapidapi.com"
//            "X-RapidAPI-Host": "realtor-canadian-real-estate.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, _, error in
            
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(PropertyList.self, from: data)
                completion(.success(results.Pins!))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
}
