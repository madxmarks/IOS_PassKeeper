//
//  AddViewController.swift
//  Swift iOS Navigation and Tab Bar
//
//  Created by Marks on 17/09/2019.
//  Copyright © 2019 Marks. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    var pathUrl:URL?
    lazy var superList = HugeLists()
    
    @IBOutlet weak var AddCategor: UITextField!
    
    var CatName = ""
    var indyx: Int = -1
    
    let Data = UserDefaults.standard.object(forKey: "MyName") as? String
    func getPath() -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        //return documentDirectory.appendingPathComponent("test.plist")
        return documentDirectory!.appendingPathComponent(Data! + ".json")
    }
    
    
    var Tablist = Lists(name: "", lists: [])
    
    @IBAction func ButSave(_ sender: UIButton) {
        if ((AddCategor.text) != nil)
        {
            print(AddCategor.text as Any)
            Tablist.name = AddCategor.text!
            if indyx == -1
            {
                superList.arrlists.append(Tablist)
            }
            else
            {
                print (indyx)
                print (superList.arrlists.count)
                print(superList)
                superList.arrlists.insert(Tablist, at: indyx)
                superList.arrlists.remove(at: indyx+1)
                print(superList)
            }
            saveCustomTypeWithCodable()
              print(superList)
            loadCustomTypeWithCodable()
              print(superList)
        }
        if(indyx == -1)
        {
        performSegue(withIdentifier: "SaveMain", sender: self)
    }
        else
        {
            performSegue(withIdentifier: "SaveEdit", sender: self)
        }
    }
    
    @IBAction func myUnwindAction(_ segue: UIStoryboardSegue)
    {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AddCategor.text = CatName
        pathUrl = getPath() // Path as an URL
        // Do any additional setup after loading the view.
        loadCustomTypeWithCodable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
             //   print(jsonString!)
                try jsonString?.write(to: pathUrl, atomically: true, encoding: .utf8)
            } catch let error {
                print("Encoding error: ", error)
            }
        }
    }
    
    

}

