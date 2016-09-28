//
//  MovieCastDetailViewController.swift
//  Tableviews_Part_3
//
//  Created by Victor Zhong on 9/28/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class MovieCastDetailViewController: UIViewController {

	internal var selectedMovie: Movie!
	
	@IBOutlet weak var castTitleLabel: UILabel!
	@IBOutlet weak var castListLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.updateViews(for: selectedMovie)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
	
	internal func updateViews(for movie: Movie) {
		self.castTitleLabel.text = "Cast List of " + movie.title.capitalized + ":"
		var cast = ""
		for actor in movie.cast {
		cast.append(actor.firstName + " " + actor.lastName + "\n")
		}
		self.castListLabel.text = cast
		self.title = movie.title
	}
}
