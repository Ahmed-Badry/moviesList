//
//  CollectionViewController.swift
//  Movies List App
//
//  Created by Ahmed Badry on 3/16/21.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "cells"



class CollectionViewController: UICollectionViewController ,UICollectionViewDelegateFlowLayout {
    @IBOutlet var collectionGrid: UICollectionView!
    var arrayOfDictCV = [Dictionary<String,Any>]()
    let dataUrl = ("https://api.androidhive.info/json/movies.json")
    var arrayOfData = [DataModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

            self.collectionGrid.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
            ApiServices.instance.getDataFromApi(url: self.dataUrl) { [self] (data: [DataModel]?, error) in
                if let error = error{
                    print(error)
                }else{
                    guard let data = data else { return}
                    self.arrayOfData = data
                    print(arrayOfData)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
    }

   

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return arrayOfData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
    
        cell.labelCell.text =  arrayOfData [indexPath.row].title as! String
        
        cell.imageCell.sd_setImage(with: URL (string: arrayOfData [indexPath.row].image as! String), placeholderImage:UIImage(named: "placeholder.png"))
      
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize(width: 208, height: 215)
        return size
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsView = (self.storyboard?.instantiateViewController(identifier: "detVC"))! as MoviesDetails
        detailsView.dictDetail = arrayOfDictCV[indexPath.row]
        
        self.navigationController?.pushViewController(detailsView, animated: true)
    }


}





//        let request = URLRequest(url: url!)
//
//        let session = URLSession(configuration: URLSessionConfiguration.default)
//
//        let task = session.dataTask(with: request) { [self] (data, response, error) in
//
//            do{
//            let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Array<Dictionary<String,Any>>
//                arrayOfDictCV = json
//                DispatchQueue.main.async {
//                    self.collectionGrid.reloadData()
//                }
//
//            }catch {
//                print(error.localizedDescription)
//            }
//        }
//
//        task.resume()
