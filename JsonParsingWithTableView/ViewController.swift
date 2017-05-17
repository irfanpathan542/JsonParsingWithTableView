//
//  ViewController.swift
//  JsonParsingWithTableView
//
//  Created by iFlame on 5/17/17.
//  Copyright © 2017 iFlame. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    //MARK: Table view Outlet
    @IBOutlet var myTable: UITableView!
    
    //MARK: Create Empty Array To Store Json Data
     var arrData = [String]()
     override func viewDidLoad() {
        super.viewDidLoad()
        myTable.delegate = self
        myTable.dataSource = self
        // Call Json Passing Function
        fetchData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Json Fetch Data Methods
    func fetchData(){
        let url = URL(string :"http://ip.jsontest.com/")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print("Error found like \(error!)")
            }else if data != nil && response != nil {
                do{
                    let myJson = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
                    if ((myJson?.count)! >= 1) {
                        let value = myJson?["ip"]
                        self.arrData.append(value as! String)
                        self.myTable.reloadData()
                    }
                   
                   }catch{
                    print("Error")
                }
                          }
            
        }
        task.resume()
         }
    //MARK: TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = arrData[indexPath.row]
        return cell
    }

  }
