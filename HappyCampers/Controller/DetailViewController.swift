//
//  DetailViewController.swift
//  HappyCampers
//
//  Created by Rehan Parkar on 2018-04-08.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //outlets
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var photoDescriptionLabel: UILabel!
    @IBOutlet weak var shotByLabel: UILabel!
    @IBOutlet weak var photoTitleLabel: UILabel!
    
    //variables
    var image1 = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()

    }

    func setUpView() {
        selectedImage.image = image1
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
