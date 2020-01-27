//
//  ActiveListings.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 5/21/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

import UIKit
import Foundation
struct ActiveListings: Codable {
    
    static let shared = ActiveListings()
    
    struct responseData: Codable {
        var D: ResultsData
    }
    struct resultsArr: Codable {
        var AuthToken: String
        var Expires: String
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
    
    //    static let instance = Listing()
    
    
    //listing struct
    struct listingData: Codable {
        var D: listingResultsData
    }
    struct listingResultsData: Codable {
        var Results: [listingResults]
    }
    
    
    struct listingResults: Codable {
        var Id: String
        var ResourceUri: String
        var StandardFields: standardFields
        var CustomFields: customFields?
//        var lastCachedTimestamp: JSONNull?
        
        
//        init(Id: String? = "", ResourceUri: String? = "", StandardFields: standardFields?, CustomFields: customFields?) {
//            self.Id = Id ?? ""
//            self.ResourceUri = ResourceUri ?? ""
//            self.StandardFields = standardFields ?? ""
//            self.CustomFields = customFields ?? ""
//        }
//        private enum CodingKeys: String, CodingKey {
//            case Id = "Id"
//            case ResourceUri = "ResourceUri"
//            case StandardFields = "StandardFields"
//            case CustomFields = "CustomFields"
//        }
//        init(from decoder: Decoder) throws {
//                let container = try decoder.container(keyedBy: CodingKeys.self)
//                Id = try container.decode(String.self, forKey: .Id)
//                ResourceUri = try container.decode(String.self, forKey: .ResourceUri)
//
//            }
        
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
        
        
        
        init(BathsFull: String? = nil, Latitude: Double? = nil, Longitude: Double? = nil, BedsTotal: String? = nil, ListingId: String? = nil, BuildingAreaTotal:Float? = nil,ListAgentName: String? = nil, CoListAgentName: String? = nil, MlsStatus: String? = nil, ListOfficePhone: String? = nil, UnparsedFirstLineAddress: String? = nil, City: String? = nil, PostalCode: String? = nil, StateOrProvince: String? = nil, UnparsedAddress: String? = nil, CurrentPricePublic: Int? = nil, ListPrice: Int? = nil, PublicRemarks: String? = nil, Photos:[PhotoDictionary]? = nil, Videos:[VideosObjs]? = nil, VirtualTours:[VirtualToursObjs]? = nil, Documents:[DocumentsAvailable]? = nil)
        {
            self.BathsFull = BathsFull ?? ""
            self.BedsTotal = BedsTotal ?? ""
            self.ListingId = ListingId ?? ""
            self.BuildingAreaTotal = BuildingAreaTotal ?? nil
            self.Latitude = Latitude!
            self.Longitude = Longitude!
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
            Latitude = try? container.decodeIfPresent(Double.self, forKey: .Latitude)
            Longitude = try? container.decodeIfPresent(Double.self, forKey: .Longitude)
            ListingId = try? container.decodeIfPresent(String.self, forKey: .ListingId)
            ListAgentName = try? container.decodeIfPresent(String.self, forKey: .ListAgentName)
            MlsStatus = try? container.decodeIfPresent(String.self, forKey: .MlsStatus)
            ListOfficePhone = try? container.decodeIfPresent(String.self, forKey: .ListOfficePhone)
            UnparsedFirstLineAddress = try? container.decodeIfPresent(String.self, forKey: .UnparsedFirstLineAddress)
            City = try? container.decodeIfPresent(String.self, forKey: .City)
            PostalCode = try? container.decodeIfPresent(String.self, forKey: .PostalCode)
            StateOrProvince = try? container.decodeIfPresent(String.self, forKey: .StateOrProvince)
            UnparsedAddress = try? container.decodeIfPresent(String.self, forKey: .UnparsedAddress)
            CurrentPricePublic = try? container.decodeIfPresent(Int.self, forKey: .CurrentPricePublic)
            ListPrice = try? container.decodeIfPresent(Int.self, forKey: .ListPrice)
            PublicRemarks = try? container.decodeIfPresent(String.self, forKey: .PublicRemarks)
            Photos = try? container.decodeIfPresent([PhotoDictionary].self, forKey: .Photos)
            Videos = try? container.decodeIfPresent([VideosObjs].self, forKey: .Videos)
            VirtualTours = try? container.decodeIfPresent([VirtualToursObjs].self, forKey: .VirtualTours)
            Documents = try? container.decodeIfPresent([DocumentsAvailable].self, forKey: .Documents)
            
            //            if let value = try? container.decodeIfPresent(Double.self, forKey: .Latitude) {
            //                Latitude = String(value)
            //            } else {
            //                Latitude = try container.decodeIfPresent(String.self, forKey: .Latitude)
            //            }
            
            if let value = try? container.decodeIfPresent(Int.self, forKey: .BathsFull) {
                BathsFull = String(value)
            } else {
                BathsFull = try container.decodeIfPresent(String.self, forKey: .BathsFull)
            }
            
            //            guard let BathsFull:NSNull = try? container.decode(NSNull.self, forKey: .BathsFull) else { return }
            
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
    
    struct customFields: Codable {
//        var CustomFieldsObjs: [customFields]?
        struct Main:Codable {
            var listingLocationAndPropertyInfo: [ListingLocationAndPropertyInfo]?
            struct ListingLocationAndPropertyInfo: Codable {
                var entryDate: String?
                var listingPrice: Int?
                var listPriceSqFt: Double?
                var propertySubType: String?
                var street: String?
                var streetName2: String?
                var suffix: String?
                var county2: String?
                var city2: String?
                var stateProvince2: String?
                var zipCode: String?
                var apnTaxID: String?
                var masterArea: String?
                var area2: String?
                var subdivisionTractCode: String?
                var country2: String?
                
                enum CodingKeys: String, CodingKey {
                    case entryDate
                    case listingPrice
                    case listPriceSqFt
                    case propertySubType
                    case street
                    case streetName2
                    case suffix
                    case county2
                    case city2
                    case stateProvince2
                    case zipCode
                    case apnTaxID
                    case masterArea
                    case area2
                    case subdivisionTractCode
                    case country2
                }
            }
            var generalPropertyInformation: [GeneralPropertyInformation]?
            // MARK: - GeneralPropertyInformation
            struct GeneralPropertyInformation: Codable {
                var bedrooms: Int?
                var lotAcres2: Double?
                var bathsFull: Int?
                var baths34: Int?
                var baths12: Int?
                var baths14: Int?
                var approxSqFt: Int?
                var bathsTotal: Int?
                var lotSqFt: Int?
                var zoning2: String?
                var yearBuilt2: Int?
                var constructionStatus: String?
                var commonWalls: String?
                
                enum CodingKeys: String, CodingKey {
                    case bedrooms
                    case lotAcres2
                    case bathsFull
                    case baths34
                    case baths12
                    case baths14
                    case approxSqFt
                    case bathsTotal
                    case lotSqFt
                    case zoning2
                    case yearBuilt2
                    case constructionStatus
                    case commonWalls
                }
            }
            //            var remarksMisc: [RemarksMisc]?
            //            var listingInfo: [ListingInfo]?
            //            var propertyInfo: [PropertyInfo]?
            //            var statusChangeInfo: [StatusChangeInfo]?
            //            var landLeaseType: [LandLeaseType]?
            //            var specialConditions: [SpecialCondition]?
            //            var terms: [Term]?
            //            var bedroomFeatures: [BedroomFeature]?
            //            var possession: [Possession]?
            //            var buildersInformation: [BuildersInformation]?
            //            var lotDescription: [LotDescription]?
            //            var lotLocation: [LotLocation]?
            //            var schools: [School]?
            //            var viewType: [ViewType]?
            //            var frontOfHouseFaces: [FrontOfHouseFace]?
            //            var propertyCondition: [PropertyCondition]?
            //            var disclosures: [Disclosure]?
            //            var communityFeatures: [CommunityFeature]?
            //            var buildingStyle: [BuildingStyle]?
            //            var laundryLocations: [LaundryLocation]?
            //            var sprinklers: [Sprinkler]?
            //            var fencing: [Fencing]?
            //            var levels: [Level]?
            //            var entryLocation: [EntryLocation]?
            //            var appliances: [Appliance]?
            //            var cookingAppliances: [CookingAppliance]?
            //            var roofing: [Roofing]?
            //            var kitchenFeatures: [KitchenFeature]?
            //            var bathroomFeatures: [BathroomFeature]?
            //            var eatingAreas: [EatingArea]?
            //            var exteriorConstruction: [ExteriorConstruction]?
            //            var securitySafety: [SecuritySafety]?
            //            var foundation: [Foundation]?
            //            var flooring: [Flooring]?
            //            var coolingType: [CoolingType]?
            //            var sewer: [Sewer]?
            //            var water: [Water]?
            //            var heatingType: [HeatingType]?
            //            var hoaInformation: [HOAInformation]?
            //            var rooms: [Room]?
            //            var interiorFeatures: [InteriorFeature]?
            //            var tvServices: [TVService]?
            //            var windows: [Window]?
            //            var patioFeatures: [PatioFeature]?
            //            var waterHeaterFeature: [WaterHeaterFeature]?
            //            var greenEnergyEfficient: [GreenEnergyEfficient]?
            //            var parkingSpacesInformation: [ParkingSpacesInformation]?
            //            var parkingType: [ParkingType]?
            //            var parkingFeatures: [ParkingFeature]?
            //            var hoa1Frequency: [HOA1Frequency]?
            //            var associationAmenities: [AssociationAmenity]?
            //            var associationPetRules: [AssociationPetRule]?
        }
        
        
    }
    //    var session:Session!
    static func fetchListing(_ completionHandler: @escaping (listingData) -> Swift.Void)   {
        Service.shared.fetchAuthToken { (tokenResponse) in
            print("SIMPLE:\(tokenResponse.D.Results[0].AuthToken)")
            let authToken = tokenResponse.D.Results[0].AuthToken
            let agentSherwood = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/my/listingsAuthToken\(authToken)_expandPhotos,Videos,VirtualTours,OpenHouses_filterMlsStatus Eq 'Pending' Or MlsStatus Eq 'Active'_orderby-ListPrice_pagination1"
            
            let SherwoodHighToLow = md5(sessionHash: agentSherwood)
            
            let sherwoodhl = "http://sparkapi.com/v1/my/listings?ApiSig=\(SherwoodHighToLow)&AuthToken=\(authToken)&_expand=Photos,Videos,VirtualTours,OpenHouses&_filter=MlsStatus Eq 'Pending' Or MlsStatus Eq 'Active'&_orderby=-ListPrice&_pagination=1"
            
            guard let newSherwoodUrl = sherwoodhl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
            
            let newCallUrl = URL(string:newSherwoodUrl)
            var request = URLRequest(url: newCallUrl!)
            request.httpMethod = "GET"
            request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
            request.addValue("SparkiOS", forHTTPHeaderField: "X-SparkApi-User-Agent")
            
            URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                guard let data = data else { return }
                if let error = error {
                    print(error)
                }
                
                do { let newListing = try JSONDecoder().decode(listingData.self, from: data)
                   
                    var photosArray = [String]()
                    let theListing = newListing.D.Results
                    for aListing in (theListing) {
                        for aPhoto in aListing.StandardFields.Photos ?? [] {
                            photosArray.append(aPhoto.Uri800)
                        }
                        //photosArray.removeAll()
                    }
                    DispatchQueue.main.async(execute: { () -> Void in
                        completionHandler(newListing)
                    })
                } catch let err {
                    print(err)
                }
            }
            .resume()
        }
    }
}


