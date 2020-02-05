//
//  SecondViewController.swift
//  Swift iOS Navigation and Tab Bar
//
//  Created by Marks on 17/09/2019.
//  Copyright © 2019 Marks. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var Name: UILabel!
    var NickName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let x = UserDefaults.standard.object(forKey: "MyName") as? String
        {
            NickName = x
        }
        
        Name.text = "Hi, " + NickName + " !"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func myUnwindAction(_ segue: UIStoryboardSegue)
    {
        
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
