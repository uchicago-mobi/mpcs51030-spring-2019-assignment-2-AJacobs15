//
//  Animal.swift
//  ItsAZooInThere
//
//  Created by Arthur  Jacobs on 4/16/19.
//  Copyright © 2019 Arthur Jacobs. All rights reserved.
//

import UIKit

class Animal{
    let name: String
    let species: String
    let age: Int
    let image: UIImage
    let soundPath: String
    
    init (name: String, species: String, age: Int, image: UIImage, soundPath: String){
        self.name = name
        self.species = species
        self.age = age
        self.image = image
        self.soundPath = soundPath
    }
}

extension Animal: CustomStringConvertible {
    var description: String {
        return "Animal: name = (\(self.name), species = \(self.species), age = \(self.age))"
    }
}

