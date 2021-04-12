//
//  AddMovie.swift
//  Movies List App
//
//  Created by Ahmed Badry on 3/9/21.
//

import UIKit

class AddMovie: UIViewController {

    var p : myProtocol?
    @IBOutlet weak var addTitleTextField: UITextField!
    
    @IBOutlet weak var addImageTextField: UITextField!
    
    @IBOutlet weak var addReleaseYearTextField: UITextField!
    
    @IBOutlet weak var addGenreOneTextField: UITextField!
    
    @IBOutlet weak var addRatingTextField: UITextField!
    @IBOutlet weak var addGenreTwoTextField: UITextField!
    
    @IBOutlet weak var doneOutlet: UIButton!
    //    var modelClass = ModelMoviesClass()
//
//    var titleM :String = ""
//    var imageM = String()
//    var ratingM : Float = 0.0
//    var releaseYearM :Int = 0
//    var genreM = [String]()
    var dictAdd = Dictionary<String,Any>()
    var alert = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // doneOutlet.layer.cornerRadius = 25
         alert = UIAlertController(title:"Warning", message: "Are You sure ?", preferredStyle: .alert)
        let okAct = UIAlertAction(title: "Yes", style: .default) { [self] (UIAlertAction) in
            let numberRate =  Float(addRatingTextField.text!)
             let numberRelaese = Int(addReleaseYearTextField.text!)
             dictAdd["title"] = addTitleTextField.text!
             dictAdd["image"] = addImageTextField.text!
             dictAdd["rating"] = numberRate
             dictAdd["releaseYear"] = numberRelaese
             dictAdd["genre"] = [addGenreOneTextField.text!,addGenreTwoTextField.text!]
             p?.transferObject()

            
             self.navigationController?.popViewController(animated: true)
             addTitleTextField.text = ""
             addImageTextField.text = ""
             addRatingTextField.text = ""
              addReleaseYearTextField.text = ""
             addGenreOneTextField.text = ""
             addGenreTwoTextField.text = ""
        }
        let canAct = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAct)
        alert.addAction(canAct)
       
        
    }
    @IBAction func donetBtn(_ sender: Any) {
        self.present(alert, animated: true, completion: nil)
        
    }
    


}

