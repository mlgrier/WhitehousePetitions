//
//  ViewController.swift
//  WhitehousePetitions
//
//  Created by Marco Grier on 4/28/17.
//  Copyright © 2017 mlgrier. All rights reserved.
//

import UIKit


class ViewController: UITableViewController {
    
    
    var petitions = [[String: String]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //this uses Swifty JSON
        
        let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        
        if let url = URL(string: urlString) {
            
            if let data = try? Data(contentsOf: url) {
            
                let json = JSON(data: data)
                
                if json["metadata"]["responseInfo"]["status"].intValue == 200 {
                
                    //we're ok to parse
                    
                    parse(json: json)
                }
            }
        }
        
    }
    
    func parse(json: JSON) {
    
        for result in json["results"].arrayValue {
        
            let title = result["title"].stringValue
            let body = result["body"].stringValue
            let sigs = result["signatureCount"].stringValue
            let obj = ["title" : title, "body" : body, "sigs" : sigs]
            
            petitions.append(obj)
        }
        
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return petitions.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "Title goes here"
        cell.detailTextLabel?.text = "Subtitle goes here"
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

