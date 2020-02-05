//
//  TempViewController.swift
//  Swift iOS Navigation and Tab Bar
//
//  Created by Marks on 18/09/2019.
//  Copyright © 2019 Marks. All rights reserved.
//

import UIKit

class TempViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var eightThousandersPeaks = [String]()
    var pathUrl:URL?
    
    lazy var list1 = List(name: "stackOverFlow", descript: ["Kukuruzka","ksda49492","Tor@gmail.com","LoveCats"])
    lazy var list2 = List(name: "Geeks", descript: ["Geek","ch69ek", "Sanya@mail.ru","DelegatnyLos"])
    lazy var list3 = List(name: "cinimacity", descript: ["Ciniman","che89k", "Opasny@gmail.com", "godzilla"])
    lazy var Tablist = Lists(name: "Internet pass", lists: [list1, list2, list3])
    lazy var list4 = List(name: "Iphone", descript: ["Nick","che09811k", "nik@gmail.com"])
    lazy var list5 = List(name: "LapTop", descript: ["NickLapt","chejkfo239fs9", "nik@gmail.com"])
    lazy var Tablist2 = Lists(name: "Devices pass", lists: [list4, list5])
    lazy var superList = HugeLists(arrlists: [Tablist, Tablist2])
    
    
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
        performSegue(withIdentifier: "TempThis", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "TempThis")
        {
            let vc = segue.destination as! AddViewController
            vc.CatName = nameCaty
            vc.Tablist = superList.arrlists[inde]
            vc.indyx = -1
        }
    }

}
