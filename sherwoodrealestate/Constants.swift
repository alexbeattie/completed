//
//  Constants.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 5/23/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

import Foundation


//var listing: Listing?
let BASE_URL = "https://http://sparkapi.com/v1/"
let GET_URL = "http://sparkapi.com/v1/"
let MY_LISTINGS_PASS = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/my/listingsAuthToken"
let MY_LISTINGS_PASS_PHOTOS = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/my/listingsAuthToken_expand=Photos"
let ALL_LISTINGS = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/listingsAuthToken"
let MY_LISTINGS_PASS_SORT = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/my/listingsAuthToken_orderby-ListPrice"

let JORDAN_ID = "20160917171113923841000000"
let JORDSAN_MLS_ID = "C159094153"
let MY_LISTINGS_SERVICE = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/my/listingsAuthToken"

let NICKIKARENID = "20160917171150811658000000"
let SHERWOODID = "20160622112753445171000000"
//\(NICKIKARENID)
//\(JORDAN_ID)
//let SORT_URL = URL(String:"http://sparkapi.com/v1/my/listings?AuthToken=\(authToken)&_filter=Not+MlsStatus+Eq++'Sold'&_orderby=-ListPrice&ApiSig=\(apiSig)")
// 20160917171150811658000000 nk
// 20160917171113923841000000 jordan

// let agentAvailableStringHighToLow = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/listingsAuthToken\(authToken)_expandPhotos,Videos,VirtualTours_filterListAgentId Eq '20160917171150811658000000' And MlsStatus Ne 'Sold' And PropertyClass Ne 'Rental'_limit25_orderby-ListPrice_pagination1"

// let agentSoldHighToLow = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/listingsAuthToken\(authToken)_expandPhotos,Videos,VirtualTours_filterListAgentId Eq '20160917171150811658000000' And MlsStatus Eq 'Sold' And PropertyClass Ne 'Rental'_limit25_orderby-ListPrice_pagination1"

//let agentAvailableStringHighToLowSig = self.md5(agentAvailableStringHighToLow)
//let agentSoldHighToLowSig = self.md5(agentSoldHighToLow)
//
//let space = "%20"
//let quote = "%27"
//let comma = "%2C"
//
//
//let availableHighToLow = "http://sparkapi.com/v1/listings?ApiSig=\(agentAvailableStringHighToLowSig)&AuthToken=\(authToken)&_expand=Photos\(comma)Videos\(comma)VirtualTours&_filter=ListAgentId\(space)Eq\(space)\(quote)20160917171150811658000000\(quote)\(space)And\(space)MlsStatus\(space)Ne\(space)\(quote)Sold\(quote)\(space)And\(space)PropertyClass\(space)Ne\(space)\(quote)Rental\(quote)&_limit=25&_orderby=-ListPrice&_pagination=1"
//
//
//let soldHighToLow = "http://sparkapi.com/v1/listings?ApiSig=\(agentSoldHighToLowSig)&AuthToken=\(authToken)&_expand=Photos\(comma)Videos\(comma)VirtualTours&_filter=ListAgentId\(space)Eq\(space)\(quote)20160917171150811658000000\(quote)\(space)And\(space)MlsStatus\(space)Eq\(space)\(quote)Sold\(quote)\(space)And\(space)PropertyClass\(space)Ne\(space)\(quote)Rental\(quote)&_limit=25&_orderby=-ListPrice&_pagination=1"

