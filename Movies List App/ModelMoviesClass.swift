//
//  ModelMoviesClass.swift
//  Movies List App
//
//  Created by Ahmed Badry on 3/8/21.
//

import Foundation
class ModelMoviesClass {
    var title :String = ""
    var image = String()
    var rating: Float = 0.0
    var releaseYear :Int = 0
    var genre = [String]()
    
    init() {
        
    }
    init(title: String, image: String, rating: Float ,releaseYear: Int,genre :[String]) {
        self.title = title
        self.image = image
        self.rating = rating
        self.releaseYear = releaseYear
        self.genre = genre
    }
}
