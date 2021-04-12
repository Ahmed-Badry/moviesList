//
//  MoviesDetails.swift
//  Movies List App
//
//  Created by Ahmed Badry on 3/8/21.
//

import UIKit

class MoviesDetails: UIViewController {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var ratingMovie: UILabel!
    @IBOutlet weak var releaseMovie: UILabel!
    @IBOutlet weak var genreMovie: UILabel!
  
    var movieImg :String = ""
    var movieName :String = ""
    var movieGenre = [String]()
    var movieRating :Float = 0.0
    var moviereleaseYear :Int = 0
    var movieGen :String = ""

    var myMovDet = ModelMoviesClass()
    var dictDetail = Dictionary<String,Any>()
    var arrayOfDataDetail = [DataModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        movieName = dictDetail["title"] as! String
        titleMovie.text = movieName
        if dictDetail["image"] as! String == "titanic"{
            imageMovie.image =  UIImage.init(named: dictDetail["image"] as! String)
        } else if dictDetail["image"] as! String == "honestthief" {
            imageMovie.image = UIImage.init(named: dictDetail["image"] as! String)
        }else if dictDetail["image"] as! String == "wonderwomen" {
            imageMovie.image = UIImage.init(named: dictDetail["image"] as! String)
        }
        else{
            movieImg = dictDetail["image"] as! String
            let url = URL(string: movieImg)
            imageMovie.sd_setImage(with: URL (string: dictDetail["image"] as! String), placeholderImage:UIImage(named: "placeholder.png"))
        }
        
        
         
        ratingMovie.text = (dictDetail["rating"] as! NSNumber).stringValue
        
        releaseMovie.text = (dictDetail["releaseYear"] as! NSNumber).stringValue
        
        movieGenre = dictDetail["genre"] as! [String]
        genreMovie.text = movieGenre.joined(separator: ",")
        

        
    }
    

}
