//
//  ResponseDaumImageSearch.swift
//  FunJCam
//
//  Created by boxjeon on 2018. 4. 29..
//  Copyright © 2018년 the42apps. All rights reserved.
//

class ResponseDaumImageSearch: Decodable {
    
    var searchedImages: [SearchedImageByDaum]
    var totalCount: Int
    var totalPageCount: Int
    var hasMore: Bool
    
    private enum CodingKeys: String, CodingKey {
        case documents
        case meta
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.searchedImages = try values.decodeIfPresent([SearchedImageByDaum].self, forKey: .documents) ?? []
        let metadata = try values.decodeIfPresent(Metadata.self, forKey: .meta) ?? Metadata()
        self.totalCount = metadata.total_count
        self.totalPageCount = metadata.pageable_count
        self.hasMore = !metadata.is_end
    }
}

private class Metadata: Decodable {
    
    var total_count: Int = 0
    var pageable_count: Int = 0
    var is_end: Bool = true
}
