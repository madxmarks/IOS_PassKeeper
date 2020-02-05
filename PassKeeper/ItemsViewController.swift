//
//  ItemsViewController.swift
//  Swift iOS Navigation and Tab Bar
//
//  Created by Marks on 18/09/2019.
//  Copyright © 2019 Marks. All rights reserved.
//

import UIKit



class ItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var eightThousandersPeaks = [String]()
    var pathUrl:URL?
    var namyIndex: Int = 0
    var nameItem = ""
    lazy var superList = HugeLists()
    var categoryIndeks: Int = -1
    
    @IBAction func addnew(_ sender: UIButton) {
        
        performSegue(withIdentifier: "descripAdd", sender: self)
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
        if let x = UserDefaults.standard.object(forKey: "itemUser") as? String
        {
            nameItem = x
        }
            for iter in superList.arrlists
            {
                categoryIndeks += 1
                if(iter.name == nameItem)
                {
                for list in iter.lists
                {
                eightThousandersPeaks.append(list.name)
                }
                    break
                }
        }
        
        
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
    
    var indexToDesc: Int = 0
    var nameToDesc = ""
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.nameToDesc = eightThousandersPeaks[indexPath.row]
        self.indexToDesc = indexPath.row
        performSegue(withIdentifier: "descrip", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "descrip")
        {
            let vc = segue.destination as! DescriptionViewController
            vc.CategName = nameItem
            vc.ItemName = nameToDesc
            vc.indeks = indexToDesc
            vc.catInd = categoryIndeks
        }
        if (segue.identifier == "descripAdd")
        {
            let vc = segue.destination as! DescriptionViewController
            vc.CategName = nameItem
            vc.indeks = superList.arrlists[categoryIndeks].lists.count
            vc.catInd = categoryIndeks
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
