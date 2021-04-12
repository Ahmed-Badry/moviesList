//
//  ViewController.swift
//  Movies List App
//
//  Created by Ahmed Badry on 3/8/21.
//

import UIKit
import SDWebImage
import Reachability
import Alamofire
import SwiftyJSON
import CoreData

let reachability = try! Reachability()
var appDelegete :AppDelegate?
var managedContext :NSManagedObjectContext?
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate ,myProtocol  {
    
    static var TAGS:Int = 0
    var addVC = AddMovie()
   var collecVC = CollectionViewController()
    var arrayOfDictTest = [Dictionary<String, Any>]()
    @IBOutlet weak var moviesTableView: UITableView!
    
    
   
    
    var  appDelegete:AppDelegate?
    var managedContext:NSManagedObjectContext?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Reachabilty
        
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            }else{
                print("Reachable via cellular")
            }
        }
        reachability.whenUnreachable = { [self] _ in
            print("Not Reachable")
            self.showAlert ()
            
        }
        
        do{
            try reachability.startNotifier()
        } catch {
            print("unable to start notifier")
        }
        
        
        
        moviesTableView.dataSource = self
        moviesTableView.delegate = self

       self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "add (2)"), style:.done, target: self, action:#selector(addMovie))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "camera"), style:.done, target: self, action:#selector(goToCollect))
        
       addVC = self.storyboard?.instantiateViewController(withIdentifier: "addVC") as! AddMovie
        collecVC = self.storyboard?.instantiateViewController(identifier: "collecVC") as! CollectionViewController
        

        appDelegete = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegete!.persistentContainer.viewContext
    
        let defaults = UserDefaults.standard

        ViewController.TAGS = defaults.integer(forKey: "tag")
        
        if ViewController.TAGS == 0 {
            // AlamoFire
            let url = ("https://api.androidhive.info/json/movies.json")
            Alamofire.request(url,method: .get).responseJSON { [self] (response) in
                if let responseValue = response.result.value as? Array<Dictionary<String,Any>> {
                    self.arrayOfDictTest = responseValue
                    self.moviesTableView.reloadData()
                }
            }
            ViewController.TAGS = ViewController.TAGS + 1
            defaults.setValue(ViewController.TAGS, forKey: "tag")
        }
            
         
    }
   
    
    
    
    func showAlert (){
        let alert = UIAlertController.init(title: "No Internet", message: "This App Requires wifi / internet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "default action"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {

        // fetch data
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MyMovies")
        
        do{
        let movies = try managedContext?.fetch(fetchRequest)
            
            if let result = movies {
                if result.count > 0 {
                    var movieResult :NSManagedObject?
                    for i in 0..<result.count {
                        movieResult = result[i] as! NSManagedObject
                        
                    }
                    arrayOfDictTest = movieResult!.value(forKey: "movies") as! Array<Dictionary<String,Any>>

                    moviesTableView.reloadData()
                    
                }
            }
        }catch let error as NSError{
            print("error on fetching data \(error)")
        }
    }
    
    
    @objc func addMovie(){
        addVC.p = self
        self.navigationController?.pushViewController(addVC, animated: true)
    }
  
   
   
    @IBAction func goToCollect(_ sender: Any) {
        self.navigationController?.pushViewController(collecVC, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfDictTest.count
    }
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell

        cell.layer.borderWidth = 0.3
         

        var dictTest = Dictionary<String,Any>()
        dictTest = arrayOfDictTest[indexPath.row]
        cell.moviesNameCell.text = dictTest["title"] as! String
       
        
        
        if dictTest["image"] as! String == "titanic" {
            cell.moviesImageCell.image = UIImage.init(named:dictTest["image"] as! String )
        }else if dictTest["image"] as! String == "honestthief"{
            cell.moviesImageCell.image = UIImage.init(named:dictTest["image"] as! String )
        }else if dictTest["image"] as! String == "wonderwomen"{
            cell.moviesImageCell.image = UIImage.init(named:dictTest["image"] as! String )
        }
        else{
            cell.moviesImageCell.sd_setImage(with: URL (string: dictTest["image"] as! String), placeholderImage:UIImage(named: "placeholder.png"))
        }
        return cell

    }
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    


    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let detailsView = (self.storyboard?.instantiateViewController(identifier: "detVC"))! as MoviesDetails
            detailsView.dictDetail = arrayOfDictTest[indexPath.row]
            self.navigationController?.pushViewController(detailsView, animated: true)
    }
    
   
    // Override to support editing the table view.
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            arrayOfDictTest.remove(at: indexPath.row)
            
            let entity = NSEntityDescription.entity(forEntityName: "MyMovies", in: managedContext!)

            let movie = NSManagedObject(entity: entity!, insertInto: managedContext)

                movie.setValue(arrayOfDictTest, forKey: "movies")


            do {
                try managedContext!.save()
                print("Data Saved !!!!!!!")
            }catch let error as NSError {
                print("error on saving \(error)")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
           
        }
    }
   
    
    
    
    
    func transferObject() {
        arrayOfDictTest.append(addVC.dictAdd)
        
        //save data
       let entity = NSEntityDescription.entity(forEntityName: "MyMovies", in: managedContext!)
       
       let movie = NSManagedObject(entity: entity!, insertInto: managedContext)
   
       movie.setValue(arrayOfDictTest, forKey: "movies")
        moviesTableView.reloadData()

       do {
           try managedContext!.save()
           print("Data Saved !!!!!!!")
       }catch let error as NSError {
           print("error on saving \(error)")
       }
    }
    


}


//// get Data by URL Session
//
//         let url = URL(string:"https://api.androidhive.info/json/movies.json")
//
//        let request = URLRequest(url: url!)
//
//        let session = URLSession(configuration: URLSessionConfiguration.default)
//
//        let task = session.dataTask(with: request) { [self] (data, response, error) in
//            do{
//                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Array<Dictionary<String,Any>>
//
//                arrayOfDictTest = json
//
//                DispatchQueue.main.async {
//                    self.moviesTableView.reloadData()
//                }
//
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//
//        task.resume()
