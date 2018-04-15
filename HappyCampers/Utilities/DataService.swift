//
//  DataService.swift
//  HappyCampers
//
//  Created by Rehan Parkar on 2018-04-12.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit

class DataService {
    
    static let instance = DataService()
    
    public private (set) var photographerName = ""
    public private (set) var displayImage: UIImage? = nil
    public private (set) var photoTitle = ""
    public private (set) var photoDescription = ""
    //user location:

    func setData(photoTitle:String, photographerName: String, photoDescription: String) {
        
       // self.displayImage = displayImage
        self.photoTitle = photoTitle
        self.photographerName = photographerName
        self.photoDescription = photoDescription
    }
    
    func setImage(displayImage: UIImage) {
        self.displayImage = displayImage
    }

    
    
}
