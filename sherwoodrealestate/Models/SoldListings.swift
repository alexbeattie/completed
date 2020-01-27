//
//  SoldListings.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 5/21/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

import UIKit
import Foundation
struct SoldListings: Codable {
    
    static let shared = SoldListings()
    
    struct responseData: Codable {
        var D: ResultsData
    }
    struct ResultsData: Codable {
        var Results: [resultsArr]
    }
    struct Pagination: Codable {
        var totalRows: Int
        var pageSize: Int
        var currentPage: Int
        var totalPages: Int
        
        init(totalRows: Int? = nil, pageSize: Int? = nil, currentPage:Int? = nil, totalPages:Int? = nil) {
            self.totalRows = totalRows ?? 0
            self.pageSize = pageSize ?? 0
            self.currentPage = currentPage ?? 0
            self.totalPages = totalPages ?? 0
        }
        private enum CodingKeys: String, CodingKey {
            case totalRows = "totalRows"
            case pageSize = "pageSize"
            case currentPage = "currentPage"
            case totalPages = "totalPages"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            totalRows = try container.decode(Int.self, forKey: .totalRows)
            pageSize = try container.decode(Int.self, forKey: .pageSize)
            currentPage = try container.decode(Int.self, forKey: .currentPage)
            totalPages = try container.decode(Int.self, forKey: .totalPages)
        }
        
    }
    struct resultsArr: Codable {
        var AuthToken: String
        var Expires: String
    }
    //    static let instance = Listing()
    
    //listing struct
    struct listingData: Codable {
        var D: listingResultsData
    }
    struct listingResultsData: Codable {
        var Results: [listingResults]
        //        var Pagination: newPagination?
        
    }
    
    //    struct newPagination: Codable {
    //           var TotalRows: Int
    //           var PageSize: Int
    //           var CurrentPage: Int
    //           var TotalPages: Int
    //    }
    struct listingResults: Codable {
        var Id: String
        var ResourceUri: String
        var StandardFields: standardFields
    }
    struct standardFields: Codable {
        
        var BedsTotal: String?
        var BathsFull: String?
        var BuildingAreaTotal: Float?
        let Latitude: Double?
        let Longitude: Double?
        
        var ListingId: String?
        var ListAgentName: String?
        var ListAgentStateLicense: String?
        var ListAgentEmail: String?
        var CoListAgentName: String?
        var MlsStatus: String?
        var ListOfficePhone: String?
        var ListOfficeFax: String?
        
        var UnparsedFirstLineAddress: String?
        var City: String?
        var PostalCode: String?
        var StateOrProvince: String?
        
        var UnparsedAddress: String?
        
        var CurrentPricePublic: Int?
        var ListPrice: Int?
        var PublicRemarks: String?
        
        var ListAgentURL: String?
        var ListOfficeName: String?
        
        var VirtualTours: [VirtualToursObjs]?
        struct VirtualToursObjs: Codable {
            var Uri: String?
        }
        var Videos: [VideosObjs]?
        struct VideosObjs: Codable {
            var ObjectHtml: String?
        }
        
        var Documents: [DocumentsAvailable]?
        struct DocumentsAvailable: Codable {
            var Id: String
            var ResourceId: String
            var Name: String
        }
        var Photos: [PhotoDictionary]?
        struct PhotoDictionary:Codable {
            var Id: String
            var Name: String
            var Uri640: String
            var Uri800: String
            var Uri1600: String
            
        }
        
        
        
        init(BathsFull: String? = nil, Latitude: Double? = nil, Longitude: Double? = nil, BedsTotal: String? = nil, ListingId: String? = nil, BuildingAreaTotal:Float? = nil,ListAgentName: String? = nil, CoListAgentName: String? = nil, MlsStatus: String? = nil, ListOfficePhone: String? = nil, UnparsedFirstLineAddress: String? = nil, City: String? = nil, PostalCode: String? = nil, StateOrProvince: String? = nil, UnparsedAddress: String? = nil, CurrentPricePublic: Int? = nil, ListPrice: Int? = nil, PublicRemarks: String? = nil, Photos:[PhotoDictionary]? = nil,Videos:[VideosObjs]? = nil, VirtualTours:[VirtualToursObjs]? = nil)
        {
            self.BathsFull = BathsFull ?? ""
            self.BedsTotal = BedsTotal ?? ""
            self.ListingId = ListingId ?? ""
            self.BuildingAreaTotal = BuildingAreaTotal ?? nil
            self.Latitude = Latitude ?? 0
            self.Longitude = Longitude ?? 0
            self.ListAgentName = ListAgentName ?? ""
            self.CoListAgentName = CoListAgentName ?? ""
            self.MlsStatus = MlsStatus ?? ""
            self.ListOfficePhone = ListOfficePhone ?? ""
            self.UnparsedFirstLineAddress = UnparsedFirstLineAddress ?? ""
            self.City = City ?? ""
            self.PostalCode = PostalCode ?? ""
            self.StateOrProvince = StateOrProvince ?? ""
            self.UnparsedAddress = UnparsedAddress ?? ""
            self.CurrentPricePublic = CurrentPricePublic ?? 0
            self.ListPrice = ListPrice ?? 0
            self.PublicRemarks = PublicRemarks ?? ""
            self.Photos = Photos ?? []
            self.Videos = Videos ?? []
            self.VirtualTours = VirtualTours ?? []
            self.Documents = Documents ?? []
            
        }
        private enum CodingKeys: String, CodingKey {
            case BathsFull = "BathsFull", BedsTotal = "BedsTotal", Latitude = "Latitude", Longitude = "Longitude", ListingId = "ListingId", BuildingAreaTotal = "BuildingAreaTotal", ListAgentName = "ListAgentName", CoListAgentName = "CoListAgentName", MlsStatus = "MlsStatus", ListOfficePhone = "ListOfficePhone", UnparsedFirstLineAddress = "UnparsedFirstLineAddress", City = "City", PostalCode = "PostalCode", StateOrProvince = "StateOrProvince", UnparsedAddress = "UnparsedAddress", CurrentPricePublic = "CurrentPricePublic", ListPrice = "ListPrice", PublicRemarks = "PublicRemarks", Photos = "Photos", Videos = "Videos", VirtualTours = "VirtualTours", Documents = "Documents"
            
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            Latitude = try container.decodeIfPresent(Double.self, forKey: .Latitude)
            Longitude = try container.decodeIfPresent(Double.self, forKey: .Longitude)
            ListingId = try container.decodeIfPresent(String.self, forKey: .ListingId)
            ListAgentName = try container.decodeIfPresent(String.self, forKey: .ListAgentName)
            MlsStatus = try container.decodeIfPresent(String.self, forKey: .MlsStatus)
            ListOfficePhone = try container.decodeIfPresent(String.self, forKey: .ListOfficePhone)
            UnparsedFirstLineAddress = try container.decodeIfPresent(String.self, forKey: .UnparsedFirstLineAddress)
            City = try container.decodeIfPresent(String.self, forKey: .City)
            PostalCode = try container.decodeIfPresent(String.self, forKey: .PostalCode)
            StateOrProvince = try container.decodeIfPresent(String.self, forKey: .StateOrProvince)
            UnparsedAddress = try container.decodeIfPresent(String.self, forKey: .UnparsedAddress)
            CurrentPricePublic = try container.decodeIfPresent(Int.self, forKey: .CurrentPricePublic)
            ListPrice = try container.decodeIfPresent(Int.self, forKey: .ListPrice)
            PublicRemarks = try container.decodeIfPresent(String.self, forKey: .PublicRemarks)
            Photos = try container.decodeIfPresent([PhotoDictionary].self, forKey: .Photos)
            Videos = try container.decodeIfPresent([VideosObjs].self, forKey: .Videos)
            VirtualTours = try container.decodeIfPresent([VirtualToursObjs].self, forKey: .VirtualTours)
            Documents = try container.decodeIfPresent([DocumentsAvailable].self, forKey: .Documents)
            
            
            if let value = try? container.decodeIfPresent(Int.self, forKey: .BathsFull) {
                BathsFull = String(value)
            } else {
                BathsFull = try container.decodeIfPresent(String.self, forKey: .BathsFull)
            }
            
            if let value = try? container.decodeIfPresent(Int.self, forKey: .BedsTotal) {
                BedsTotal = String(value)
            } else {
                BedsTotal = try container.decodeIfPresent(String.self, forKey: .BedsTotal)
            }
            
            if let value = try? container.decodeIfPresent(String.self, forKey: .BuildingAreaTotal) {
                BuildingAreaTotal = Float(value)
            } else {
                BuildingAreaTotal = try? container.decodeIfPresent(Float.self, forKey: .BuildingAreaTotal)
            }
            
            if let value = try? container.decodeIfPresent(String.self, forKey: .CoListAgentName) {
                CoListAgentName = String(value)
            } else {
                CoListAgentName = nil
            }
            
        }
    }
    
    
    //    var session:Session!
    static func fetchListing(_ completionHandler: @escaping (listingData) -> ())  {
        Service.shared.fetchAuthToken { (tokenResponse) in
            print("SIMPLE SOLD:\(tokenResponse.D.Results[0].AuthToken)")
            let authToken = tokenResponse.D.Results[0].AuthToken

            let agentSherwood = "\(MY_LISTINGS_SERVICE)\(authToken)_expandPhotos,Videos,VirtualTours,OpenHouses_filterMlsStatus Eq 'Closed'_limit25_orderby-ListPrice_pagination1"
            
            let SherwoodHighToLow = md5(sessionHash: agentSherwood)
            let sherwoodhl = "http://sparkapi.com/v1/my/listings?ApiSig=\(SherwoodHighToLow)&AuthToken=\(authToken)&_expand=Photos,Videos,VirtualTours,OpenHouses&_filter=MlsStatus Eq 'Closed'&_limit=25&_orderby=-ListPrice&_pagination=1"
            guard let encodedUrl = sherwoodhl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
            
            let newCallUrl = URL(string: encodedUrl)
            var request = URLRequest(url: newCallUrl!)
            request.httpMethod = "GET"
            request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
            request.addValue("SparkiOS", forHTTPHeaderField: "X-SparkApi-User-Agent")
            
            URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                guard let data = data else { return }
                if let error = error {
                    print(error)
                }

                do {
                    let newListing = try JSONDecoder().decode(listingData.self, from: data)
                    
                    var photosArray = [String]()
                    let theListing = newListing.D.Results
                    for aListing in (theListing) {
                        for aPhoto in aListing.StandardFields.Photos ?? [] {
                            photosArray.append(aPhoto.Uri800)
                        }
                        photosArray.removeAll()
                    }
                    DispatchQueue.main.async(execute: { () -> Void in
                        completionHandler(newListing)
                    })
                } catch let err {
                    print(err)
                }
//            }
//            newTask.resume()
            }
        
        .resume()
        }
    }
}

