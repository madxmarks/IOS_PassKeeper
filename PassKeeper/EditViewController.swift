//
//  EditViewController.swift
//  Swift iOS Navigation and Tab Bar
//
//  Created by Marks on 17/09/2019.
//  Copyright © 2019 Marks. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var eightThousandersPeaks = [String]()
    var pathUrl:URL?
    lazy var superList = HugeLists()
    
    @IBAction func ButBackEdit(_ sender: UIButton) {
        saveCustomTypeWithCodable()
    }
    
    
    let Data = UserDefaults.standard.object(forKey: "MyName") as? String
    func getPath() -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        //return documentDirectory.appendingPathComponent("test.plist")
        return documentDirectory!.appendingPathComponent(Data! + ".json")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pathUrl = getPath() // Path as an URL
        // Do any additional setup after loading the view, typically from a nib.
        loadCustomTypeWithCodable()
        for cat in superList.arrlists
        {
        eightThousandersPeaks.append(cat.name)
        }
    }
    
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
    
    func loadCustomTypeWithCodable() {
        if let pathUrl = pathUrl {
            do {
                let jsonFileContents = try String(contentsOf: pathUrl, encoding: .utf8)
                superList = try JSONDecoder().decode(HugeLists.self, from: jsonFileContents.data(using: .utf8)!)
            } catch let error {
                print("Encoding error: ", error)
            }
        }
    }
    
    func saveCustomTypeWithCodable() {
        if let pathUrl = pathUrl {
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(superList)
                let jsonString = String(data: jsonData, encoding: .utf8)
              //  print(jsonString!)
                try jsonString?.write(to: pathUrl, atomically: true, encoding: .utf8)
            } catch let error {
                print("Encoding error: ", error)
            }
        }
    }
    
    var nameCaty = ""
    var inde: Int = 0
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get data from model
        self.nameCaty = eightThousandersPeaks[indexPath.row]
        self.inde =  indexPath.row
        performSegue(withIdentifier: "EditThis", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "EditThis")
        {
            let vc = segue.destination as! AddViewController
            vc.CatName = nameCaty
            vc.Tablist = superList.arrlists[inde]
            vc.indyx = inde
        }
    }
    
    @IBAction func myUnwindAction(_ segue: UIStoryboardSegue)
    {
        
    }
    
    // delete
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            eightThousandersPeaks.remove(at: indexPath.row)
            superList.arrlists.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

    
    
}
