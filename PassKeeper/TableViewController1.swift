//
//  TableViewController1.swift
//  Swift iOS Navigation and Tab Bar
//
//  Created by Marks on 17/09/2019.
//  Copyright © 2019 Marks. All rights reserved.
//

import UIKit

struct HugeLists: Codable {
    var arrlists = [Lists]()
}

struct Lists: Codable {
    var name = String()
    var lists = [List]()
}

struct List: Codable {
    var name = String()
    var descript = [String]()
}


class TableViewController1: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var eightThousandersPeaks = [String]()
    
    var pathUrl:URL?
    let Data = UserDefaults.standard.object(forKey: "MyName") as? String
    func getPath() -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        //return documentDirectory.appendingPathComponent("test.plist")
        return documentDirectory!.appendingPathComponent(Data! + ".json")
    }
    
    /*

    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
         pathUrl = getPath() // Path as an URL
        // Do any additional setup after loading the view, typically from a nib.
        
      //  eightThousandersPeaks += [list1.name, list2.name, list3.name]
    //   saveCustomTypeWithCodable()
    loadCustomTypeWithCodable()
        for iter in TestBigList.arrlists
        {
            eightThousandersPeaks.append(iter.name)
        }
    }
    
    lazy var TestBigList = HugeLists()
    
    func loadCustomTypeWithCodable() {
        if let pathUrl = pathUrl {
            do {
                let jsonFileContents = try String(contentsOf: pathUrl, encoding: .utf8)
                TestBigList = try JSONDecoder().decode(HugeLists.self, from: jsonFileContents.data(using: .utf8)!)
            } catch let error {
                print("Encoding error: ", error)
            }
        }
    }
    
    /*
    func saveCustomTypeWithCodable() {
        if let pathUrl = pathUrl {
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(BigList)
                let jsonString = String(data: jsonData, encoding: .utf8)
                print(jsonString!)
                try jsonString?.write(to: pathUrl, atomically: true, encoding: .utf8)
            } catch let error {
                print("Encoding error: ", error)
            }
        }
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return eightThousandersPeaks.count;
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Trick to get static variable in Swift
        
        struct staticVariable { static var tableIdentifier = "TableIdentifier1" }
        
        var cell:UITableViewCell? = tableView.dequeueReusableCell(
            withIdentifier: staticVariable.tableIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: staticVariable.tableIdentifier)
        }
        
        cell?.textLabel?.text = eightThousandersPeaks[indexPath.row]
        return cell!
    }
    
   
    
    var indexCat = Int()
    var nameCat = ""
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get data from model
        self.nameCat = eightThousandersPeaks[indexPath.row]
        self.indexCat = indexPath.row
        UserDefaults.standard.set(nameCat, forKey: "itemUser")
        performSegue(withIdentifier: "item", sender: self)
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "item")
        {
        let vc = segue.destination as! ItemsViewController
        vc.namyIndex = indexCat
        vc.nameItem = nameCat
        vc.superList = TestBigList
        }
    }
    */

    
}


