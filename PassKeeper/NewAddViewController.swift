//
//  NewAddViewController.swift
//  Swift iOS Navigation and Tab Bar
//
//  Created by Marks on 22/09/2019.
//  Copyright © 2019 Marks. All rights reserved.
//

import UIKit

class NewAddViewController: UIViewController {
    var CatName = ""
    var indyx: Int = -1
    var eightThousandersPeaks = [String]()
    var pathUrl:URL?
     lazy var superList = HugeLists()
    var Tablist = Lists(name: "", lists: [])
      let Data1 = UserDefaults.standard.object(forKey: "MyName") as? String
    
    @IBOutlet weak var AddCategor: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
 
    pathUrl = getPath() // Path as an URL
        loadCustomTypeWithCodable()
        AddCategor.text = CatName
        // Do any additional setup after loading the view.
    }
  
    @IBAction func ButtonSave(_ sender: UIButton) {
        if ((AddCategor.text) != nil)
        {
            loadCustomTypeWithCodable()
            print(AddCategor.text as Any)
            Tablist.name = AddCategor.text!
            if indyx == -1
            {
                superList.arrlists.append(Tablist)
            }
            else
            {
                superList.arrlists.insert(Tablist, at: indyx)
                superList.arrlists.remove(at: indyx+1)
            }
            saveCustomTypeWithCodable()
        }
        
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
    
  
    func getPath() -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return documentDirectory!.appendingPathComponent(Data1! + ".json")
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
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
