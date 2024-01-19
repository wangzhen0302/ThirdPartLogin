//
//  ViewController.swift
//  ThirdPartLogin
//
//  Created by wangzhen0302 on 01/05/2024.
//  Copyright (c) 2024 wangzhen0302. All rights reserved.
//
import ThirdPartLogin
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    @IBAction func appleAuth(_ sender: Any) {
        ThirdPartLoginManager.shared.thirdPartAuth(type: .apple, vc: self) { info in
            
        }
    }
    
    @IBAction func googleAuth(_ sender: Any) {
       
        ThirdPartLoginManager.shared.thirdPartAuth(type: .google, vc: self) { info in
            
        }
    }
    
    @IBAction func facebookAuth(_ sender: Any) {
        ThirdPartLoginManager.shared.thirdPartAuth(type: .facebook, vc: self) { info in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }

}

