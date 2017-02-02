//
//  Gif.swift
//  GIFApp
//
//  Created by Alex Vickers on 1/31/17.
//  Copyright © 2017 skciva. All rights reserved.
//

import Foundation
import ObjectMapper

struct Gif {
   var id: String!
   var gifUrl: URL!
   var height : Float!
   var width : Float!
}

extension Gif: Mappable {
   // MARK: JSON
   init?(map: Map) {
      mapping(map: map)
   }
   
   mutating func mapping(map: Map) {
      id <- map[GiphyConstants.Properties.id]
      gifUrl <- (map[GiphyConstants.Properties.gifURL], URLTransform())
      height <- (map[GiphyConstants.Properties.height], FloatTransform())
      width <- (map[GiphyConstants.Properties.width], FloatTransform())
   }

}
