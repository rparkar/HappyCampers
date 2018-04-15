//
//  Constants.swift
//  HappyCampers
//
//  Created by Rehan Parkar on 2018-04-08.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit

typealias CompletionHandler = (_ success: Bool) -> ()

let placeholder = NSAttributedString(string: "Enter a search term...", attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) , NSAttributedStringKey.font: UIFont(name: "Avenir-Light", size: 17.0)!])


let API_KEY = "548335eec518c65ada3111b3f1bcb4bd"


func getFlickrURL(apiKey: String, searchText: String) -> String {
    
    return "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(API_KEY)&text=\(searchText)&per_page=5&format=json&nojsoncallback=1"
    
}


