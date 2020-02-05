//
//  ViewController.swift
//  Swift iOS Navigation and Tab Bar
//
//  Created by Marks on 14/09/2019.
//  Copyright © 2019 Marks. All rights reserved.
//


import UIKit

struct Constants {
    static let firstButton = 1
}


struct Logi: Codable {
    var NickName = [String]()
    var Pass = [String]()
}

class FirstViewController: UIViewController {
    
var secondViewController: SecondViewController?
    
    @IBOutlet weak var OldName: UITextField!
    @IBOutlet weak var OldPass: UITextField!
    
    @IBOutlet weak var NewLog: UITextField!
    @IBOutlet weak var NewPass: UITextField!
    
    @IBAction func NewLog(_ sender: UIButton) {
         pathUrlData = getPathData()// Path as an URL
    UserDefaults.standard.set(NewLog.text, forKey: "MyName")
        loadCustomTypeWithCodable()
        login2.NickName.append(NewLog.text!)
        login2.Pass.append(NewPass.text!)
           saveCustomTypeWithCodable()
        saveCustomTypeWithCodableData()
        loadCustomTypeWithCodableData()
     performSegue(withIdentifier: "name", sender: self)
     
    }
    
    lazy var login2 = Logi()
 //   lazy var superList = HugeLists()
    lazy var list1 = List(name: "stackOverFlow", descript: ["Kukuruzka","ksda49492","Tor@gmail.com","LoveCats"])
    lazy var list2 = List(name: "Geeks", descript: ["Geek","ch69ek", "Sanya@mail.ru","DelegatnyLos"])
    lazy var list3 = List(name: "cinimacity", descript: ["Ciniman","che89k", "Opasny@gmail.com", "godzilla"])
    lazy var Tablist = Lists(name: "Internet pass", lists: [list1, list2, list3])
    lazy var list4 = List(name: "Iphone", descript: ["Nick","che09811k", "nik@gmail.com"])
    lazy var list5 = List(name: "LapTop", descript: ["NickLapt","chejkfo239fs9", "nik@gmail.com"])
    lazy var Tablist2 = Lists(name: "Devices pass", lists: [list4, list5])
    lazy var superList = HugeLists()

    override func viewDidLoad() {
        super.viewDidLoad()
            pathUrl = getPath()
        print(pathUrl?.absoluteString as Any)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var pathUrl:URL?
    var pathUrlData:URL?
    
   
    
    func getPath() -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        //return documentDirectory.appendingPathComponent("test.plist")
        return documentDirectory!.appendingPathComponent("testLog.json")
    }
    func getPathData() -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        //return documentDirectory.appendingPathComponent("test.plist")
        let Data = OldName.text ?? NewLog.text
        return documentDirectory!.appendingPathComponent(Data! + ".json")
    }

    func loadCustomTypeWithCodable() {
        if let pathUrl = pathUrl {
            do {
                let jsonFileContents = try String(contentsOf: pathUrl, encoding: .utf8)
                login2 = try JSONDecoder().decode(Logi.self, from: jsonFileContents.data(using: .utf8)!)
            } catch let error {
                print("Encoding error: ", error)
            }
        }
    }
    
    func saveCustomTypeWithCodable() {
        if let pathUrl = pathUrl {
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(login2)
                let jsonString = String(data: jsonData, encoding: .utf8)
                //    print(jsonString!)
                try jsonString?.write(to: pathUrl, atomically: true, encoding: .utf8)
            } catch let error {
                print("Encoding error: ", error)
            }
        }
    }
    
    
    func loadCustomTypeWithCodableData() {
        if let pathUrlData = pathUrlData {
            do {
                let jsonFileContents = try String(contentsOf: pathUrlData, encoding: .utf8)
                superList = try JSONDecoder().decode(HugeLists.self, from: jsonFileContents.data(using: .utf8)!)
            } catch let error {
                print("Encoding error loadData: ", error)
            }
        }
    }
    
    func saveCustomTypeWithCodableData() {
        if let pathUrlData = pathUrlData {
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(superList)
                let jsonString = String(data: jsonData, encoding: .utf8)
                print(jsonString!)
                try jsonString?.write(to: pathUrlData, atomically: true, encoding: .utf8)
            } catch let error {
                print("Encoding error saveData: ", error)
            }
        }
    }
    
    @IBAction func switchViews(_ sender: UIButton){
       
        loadCustomTypeWithCodable()
        if ((login2.NickName.index(where: {$0 == OldName.text}) != nil))
       {
        let LogInd = login2.NickName.index(where: {$0 == OldName.text})
        if (OldName.text! == login2.NickName[LogInd!] && OldPass.text! == login2.Pass[LogInd!])
        {
        pathUrlData = getPathData()// Path as an URL
        UserDefaults.standard.set(OldName.text, forKey: "MyName")
        loadCustomTypeWithCodableData()
        saveCustomTypeWithCodableData()
        performSegue(withIdentifier: "name", sender: self)
        }
        else
        {
            let alert = UIAlertController(title: "Information", message: "wrong login or password",  preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Close",  style: .default, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
        }
       else
       {
        let alert = UIAlertController(title: "Information", message: "wrong login or password",  preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Close",  style: .default, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SecondViewController
        vc.NickName = OldName.text!
    }
    */
    
    
    
    
    
    let name = "123"
    let pass = "123"
    
    func switchToViewController(_ toVC: UIViewController?) {
        if (toVC != nil) {
            
        }
    }
}

