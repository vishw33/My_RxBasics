//
//  ViewController.swift
//  Rx-Basics
//
//  Created by Admin on 3/20/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Foundation
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var mButton: UIButton!
    var b = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mButton.rx.tap.subscribe(onNext:{self.changeBack()})
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func changeBack()
    {
        if b
        {
            self.view.backgroundColor = .red
            b = !b
        }
        else
        {
            self.view.backgroundColor = .yellow
            b = !b
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

