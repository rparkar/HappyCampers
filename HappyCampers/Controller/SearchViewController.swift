//
//  SearchViewController.swift
//  HappyCampers
//
//  Created by Rehan Parkar on 2018-04-08.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: WhiteBorderTextField!
    
    //variables
    public private (set) var searchedText: String? = nil
    var imageURLArray = [String]()
    var imageArray = [UIImage]()
    var displayImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //customised placeholder text
        searchTextField.attributedPlaceholder = placeholder
        
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func userEnteredText(_ sender: Any) {

        initData()

        retrieveURL(searchText: searchedText!) { (success) in
            
            
            if success {
                self.retrieveImageFromURL(completionHandler: { (success) in
                    
                    if success {
                        
                        self.collectionView.reloadData()
                    }
                    
                })

            } else {
                
            }
            //print(self.imageURLArray.count)
        }
        
       
    }

    
    func initData() {
        
        searchedText = searchTextField.text
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchImageCell", for: indexPath) as? SearchImageCell else { return UICollectionViewCell()
        }
        
        let imageAtIndex = imageArray[indexPath.row]
        cell.imageCell.image = imageAtIndex
        DataService.instance.setImage(displayImage: imageAtIndex)
        
        return cell
    }
    


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //tido
        let image1 = imageArray[indexPath.row]
        performSegue(withIdentifier: "detailViewController", sender: image1)
    }
    
    
    func retrieveURL(searchText: String, completionHandler: @escaping CompletionHandler) {

        imageURLArray = []
        Alamofire.request(getFlickrURL(apiKey: API_KEY, searchText: searchText)).responseJSON { (response) in
            
            guard let json = response.result.value as? Dictionary<String,AnyObject> else {return}
            
            let dictPhoto = json["photos"] as! Dictionary<String, AnyObject>
            let photoDictArray = dictPhoto["photo"] as! [Dictionary<String, AnyObject>]
            

            for photo in photoDictArray {
                
                let postURL = "https://farm\(photo["farm"]!).staticflickr.com/\(photo["server"]!)/\(photo["id"]!)_\(photo["secret"]!)_h_d.jpg"
                let title = "\(photo["title"]!)"
                
//                DataService.instance.setData(displayImage: UIImage(), photoTitle: title, photographerName: "Rehan Parkar", photoDescription: "photo description")
                
                DataService.instance.setData(photoTitle: title, photographerName: "RehanParkar", photoDescription: "photo description")
                
                
                self.imageURLArray.append(postURL)
             //   print(self.imageURLArray)
          
                
            }
            
            completionHandler(true)
            
        }
       // print("\(imageURLArray)")
        
    }
    
    func retrieveImageFromURL(completionHandler: @escaping CompletionHandler) {
        
        imageArray = []
        
        for url in imageURLArray {
            
            Alamofire.request(url).responseImage { (response) in
                
                guard let image = response.result.value else { return}
                self.imageArray.append(image)
                
                
                if self.imageArray.count == self.imageURLArray.count {
                    completionHandler(true)
                }
                
                
            }
        }
        
    }

}

extension SearchViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let desination = segue.destination as? DetailViewController else { return}
        //if nil
        desination.image1 =  DataService.instance.displayImage!
        desination.photoTitleLabel.text = DataService.instance.photoTitle
    }
    
}
