//
//  ViewController.swift
//  SimpleLoader
//
//  Created by MAC01 on 21/03/18.
//  Copyright © 2018 Jayanta Gogoi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let btnShowLoader: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(red: CGFloat(172/255), green: CGFloat(24/255), blue: CGFloat(19/255), alpha: 1)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 4
        let attributedText = NSAttributedString(string: "Show Loader", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        btn.setAttributedTitle(attributedText, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Application Home Page"
 
        view.backgroundColor = UIColor(white: 0.95, alpha:1)
        
        view.addSubview(btnShowLoader)
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0(120)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": btnShowLoader]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(40)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": btnShowLoader]))
 
        view.addConstraint(NSLayoutConstraint(item: btnShowLoader, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: btnShowLoader, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 200))
    
        btnShowLoader.addTarget(self, action: #selector(testLoader), for: .touchUpInside)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func testLoader(){
        
        //self.showLoader() // Show loader with default text
        self.showLoader(title: "Loading please wait...") // show loader with custom title
        self.perform(#selector(afterDoneSomeOperationHideLoader), with: self, afterDelay: 10) // we presumed data arived after 10 seconds and fire hide loader
    }

    
    @objc func afterDoneSomeOperationHideLoader(){
        self.hideLoader()
    }

}

