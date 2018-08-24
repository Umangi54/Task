//
//  displayViewController.swift
//  Task
//
//  Created by mahavir on 30/06/17.
//  Copyright © 2017 mobileFirst. All rights reserved.
//

import UIKit

class displayViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
   
    var arrResult:NSArray = NSArray()
    var dictMain:NSDictionary = NSDictionary()
    var dictGeo:NSDictionary = NSDictionary()
    var dictLoc:NSDictionary = NSDictionary()
    var lat:Double = Double()
    var long:Double = Double()
    var name:String = String()
    var strImage:UIImage = UIImage()
    
    @IBOutlet var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GetMethod()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSend(_ sender: UIButton)
    {
        let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        resultVC.arrResult = self.arrResult
        resultVC.lat = lat
        resultVC.long = long
        resultVC.name = name
        self.navigationController?.pushViewController(resultVC, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrResult.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tblView.dequeueReusableCell(withIdentifier: "cell") as! NewTableViewCell
        dictMain = arrResult.object(at: indexPath.row) as! NSDictionary
        name = (dictMain.value(forKey: "name") as? String)!
        cell.lblName.text = name
        
        dictGeo = dictMain.value(forKey: "geometry") as! NSDictionary
        dictLoc = dictGeo.value(forKey: "location") as! NSDictionary
        
        lat = (dictLoc.value(forKey: "lat")) as! Double
        long = (dictLoc.value(forKey: "lng")) as! Double
        cell.lblLat.text = ("\(lat),\(long)")
        
        let imageUrlString = dictMain.value(forKey: "icon") as! String
        let imageUrl:URL = URL(string: imageUrlString)!
        let imageData:NSData = NSData(contentsOf: imageUrl)!
        
        let image = UIImage(data: imageData as Data)
        cell.imgView.image = image
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        resultVC.arrResult = self.arrResult
        resultVC.lat = lat
        resultVC.long = long
        resultVC.name = name
        self.navigationController?.pushViewController(resultVC, animated: true)
        
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func GetMethod()
    {
        let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670,151.1957&radius=500&types=food&name=cruise&key=AIzaSyBIT1MU3f1YQRt9n8EFqfGqlodtHZQtVMo")
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if(error != nil)
            {
                print("error")
            }else
            {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as!NSDictionary
                    
                   // var arrResult:NSArray = NSArray()
                    self.arrResult = json.value(forKey: "results") as! NSArray
                     print(self.arrResult)
                    OperationQueue.main.addOperation({
                        
                        self.tblView.reloadData()
                    })
                    
                }catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
    }
  
}
