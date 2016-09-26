//
//  MovieDetailViewController.swift
//  Tableviews_Part_3
//
//  Created by Louis Tur on 9/26/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var summaryFullTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
