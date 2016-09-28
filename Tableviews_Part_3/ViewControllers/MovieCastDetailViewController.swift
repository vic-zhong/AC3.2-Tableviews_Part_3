//
//  MovieCastDetailViewController.swift
//  Tableviews_Part_3
//
//  Created by Louis Tur on 9/27/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class MovieCastDetailViewController: UIViewController {
    internal var selectedActors: [Actor]!
    @IBOutlet weak var castListLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var actorList: String = ""
        for actor in selectedActors {
            actorList.append("- \(actor.firstName) \(actor.lastName)\n")
        }
        self.castListLabel.text = actorList
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
