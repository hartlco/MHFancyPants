//
//  ViewController.swift
//  MHFancyPantsSwiftExample
//
//  Created by Martin Hartl on 26/07/14.
//  Copyright (c) 2014 Martin Hartl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet weak var ibView1: UIView!
    @IBOutlet weak var ibView2: UIView!
    @IBOutlet weak var ibLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ibView1.backgroundColor = MHFancyPants.colorForKey("view1BackgroundColor")
        self.ibView2.backgroundColor = MHFancyPants.colorForKey("view2BackGroundColor")
        
        self.ibLabel.text = MHFancyPants.stringForKey("text")
        
        println(NSStringFromUIEdgeInsets(MHFancyPants.edgeInsetsForKey("uiedgetest")))
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(MHFancyPants.timeIntervalForKey("view1AnimationDuration"), animations: {
            self.ibView1.frame = MHFancyPants.rectForKey("view1Frame")
            self.ibView2.center = MHFancyPants.pointForKey("view2Center")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

