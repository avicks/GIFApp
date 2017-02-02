//
//  GifViewModel.swift
//  GIFApp
//
//  Created by Alex Vickers on 1/31/17.
//  Copyright © 2017 skciva. All rights reserved.
//

import Foundation

protocol GifProtocol {
   var gifURL : URL { get }
}

final class GifViewModel : GifProtocol {
   
   //MARK: - Private properties
   private var gif: Gif!
   
   //MARK: - Public properties
   var gifURL : URL {
      return gif.gifUrl
   }
   
   //MARK: - Initialization
   init(gif: Gif) {
      self.gif = gif
   }
   
}
