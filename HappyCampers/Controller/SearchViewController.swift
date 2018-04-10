//
//  SearchViewController.swift
//  HappyCampers
//
//  Created by Rehan Parkar on 2018-04-08.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: WhiteBorderTextField!
    
    //variables
    public private (set) var searchedText: String? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //customised placeholder text
        searchTextField.attributedPlaceholder = placeholder
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func userEnteredText(_ sender: Any) {
        
        print("user stopped typing")
        initData()
        retrieveURL(searchText: searchedText!) { (success) in
            
            if success {
                print("recived URL")
            } else {
                
            }
        }
    }

    
    func initData() {
        
        searchedText = searchTextField.text
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchImageCell", for: indexPath) as? SearchImageCell else { return UICollectionViewCell()
        }
        
        return cell
    }
    


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "detailViewController", sender: self)
    }
    
    func retrieveURL(searchText: String, completionHandler: @escaping CompletionHandler){
        
        Alamofire.request(getFlickrURL(apiKey: API_KEY, searchText: searchText)).responseJSON { (response) in
            
            print("we are here")
        }
        
    }

}
