//
//  DescriptionViewController.swift
//  Swift iOS Navigation and Tab Bar
//
//  Created by Marks on 18/09/2019.
//  Copyright © 2019 Marks. All rights reserved.
//

import UIKit





class DescriptionViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate {
    var eightThousandersPeaks = [String]()
    lazy var superList = HugeLists()
    var CategName = ""
    var ItemName = ""
    var indeks = Int()
     var pathUrl:URL?
    var catInd: Int = 0
    var numberOfRows = 4
     let descData: [String] = ["name","password","email","other"]
    
    
    @IBAction func Delete(_ sender: UIButton) {
        print(catInd)
        print(indeks)
        superList.arrlists[catInd].lists.remove(at: indeks)
        saveCustomTypeWithCodable()
         performSegue(withIdentifier: "DescBack", sender: self)
    }
  
    @IBAction func Save(_ sender: UIButton) {
        print(indeks)
        let addlist = List(name: "", descript: [])
        superList.arrlists[catInd].lists.append(addlist)
        superList.arrlists[catInd].lists[indeks].name = DescName.text!
        self.reloadInputViews()
        var i=0;
        while i<numberOfRows {
            if(allCellsText[i] != nil)
            {
                if(i<eightThousandersPeaks.count)
                {
                    
            superList.arrlists[catInd].lists[indeks].descript[i] = allCellsText[i]!
                }
                else{
                    superList.arrlists[catInd].lists[indeks].descript.append(allCellsText[i]!)
                }
            }
            else
            {
                if(i<eightThousandersPeaks.count)
                {
                if(superList.arrlists[catInd].lists[indeks].descript[i].isEmpty)
                {
                superList.arrlists[catInd].lists[indeks].descript.append(" ")
                }
                }
                else
                {
                    superList.arrlists[catInd].lists[indeks].descript.append(" ")
                }
            }
            i += 1
        }
        
        saveCustomTypeWithCodable()
        performSegue(withIdentifier: "DescBack", sender: self)
    }
    
    @IBOutlet weak var DescName: UITextField!
    
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
        ShowArr()
        
    }
    
  
    
    func ShowArr()
    {
        for iter in superList.arrlists
        {
            if(iter.name == CategName)
            {
                for list in iter.lists
                {
                    if (list.name == ItemName)
                    {
                        DescName.text = list.name
                        for desc in list.descript
                        {
                            eightThousandersPeaks.append(desc)
                        }
                        break
                    }
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
    
    func saveCustomTypeWithCodable() {
        if let pathUrl = pathUrl {
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(superList)
                let jsonString = String(data: jsonData, encoding: .utf8)
            //    print(jsonString!)
                try jsonString?.write(to: pathUrl, atomically: true, encoding: .utf8)
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
        return descData.count;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {textField.resignFirstResponder()
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Trick to get static variable in Swift
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! CellField
        cell.textLab?.delegate = self
        
                 if (indexPath.row<eightThousandersPeaks.count)
        {
        cell.textLab?.text = eightThousandersPeaks[indexPath.row]
        }
        else
        {
                    cell.textLab?.text = ""
        }
            cell.textLab?.placeholder = descData[indexPath.row]
        cell.textLab?.autocorrectionType = UITextAutocorrectionType.no
        cell.textLab?.autocapitalizationType = UITextAutocapitalizationType.none
        cell.textLab?.adjustsFontSizeToFitWidth = true;
        return cell
        
        
    }
    
     var allCellsText = [String?](repeating: nil, count:4)
    func textFieldDidEndEditing(_ textField: UITextField) {
        let indexOf = descData.index(of:textField.placeholder!)
        print(indexOf ?? 0)
        if(textField.placeholder! == descData[indexOf!]){
            if( indexOf! <= (allCellsText.count - 1)){
                allCellsText.remove(at: indexOf!)
            }
            allCellsText.insert(textField.text!, at: indexOf!)
            print(allCellsText)
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
