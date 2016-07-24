//
//  SearchedImage.swift
//  funjcam
//
//  Created by gurren-l on 2016. 7. 19..
//  Copyright © 2016년 boxjeon. All rights reserved.
//

import ObjectMapper

class SearchedImage: Mappable {
    var thumbnailLink: String?
    var link: String?
    var width: Int?
    var height: Int?
    var byteSize: Int?
    
    var contextLink: String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        thumbnailLink   <- map["image.thumbnailLink"]
        link            <- map["link"]
        width           <- map["image.width"]
        height          <- map["image.height"]
        byteSize        <- map["image.byteSize"]
        contextLink     <- map["image.contextLink"]
    }
}
