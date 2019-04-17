//
//  ViewController.swift
//  ItsAZooInThere
//
//  Created by Arthur  Jacobs on 4/16/19.
//  Copyright © 2019 Arthur Jacobs. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var myView: UIScrollView!
    @IBOutlet weak var myLabel: UILabel!
    
    var animals: [Animal] = []
    var audioSound: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Size ScrollView - Source: https://www.seemuapps.com/how-to-add-a-simple-scroll-view-in-the-storyboard-to-your-app
        myView.delegate = self
        myView.contentSize = CGSize(width: 1125, height: 500)
        
        //sound paths
        let dogSound = Bundle.main.path(forResource: "shiba", ofType: "m4a")!
        let sheepSound = Bundle.main.path(forResource: "sheep", ofType: "m4a")!
        let frogSound = Bundle.main.path(forResource: "frog", ofType: "m4a")!
        //create array
        let dog = Animal(name: "Shiba", species: "Dog", age: 3, image: UIImage(named: "shibaImg")!, soundPath: dogSound)
        let sheep = Animal(name: "XiYangYang", species: "Sheep", age: 7, image: UIImage(named: "xiyangyangImg")!, soundPath: sheepSound)
        let frog = Animal(name: "Frogger", species: "Frog", age: 2, image: UIImage(named: "frogImg")!, soundPath: frogSound)
        animals.append(contentsOf:[dog, sheep, frog])
        animals.shuffle()
        
        for (i, animal) in animals.enumerated(){
            
            let button = UIButton(type: .system)
            let xCor = (i) * (375)
            button.frame = CGRect(x: xCor, y: 350, width: 375, height: 167)
            button.setTitle(animal.name, for: UIControl.State.normal)
            button.titleLabel?.font =  UIFont(name: "Avenir", size: 20)
            
            //button.setTitleColor(UIColor(red: 142, green: 62, blue: 239, alpha: 1), for: .normal)
            //button.setTitleColor(UIColor(displayP3Red: 143, green: 62, blue: 239, alpha: 1), for: .normal)
            button.setTitleColor(UIColor.purple, for: .normal)
            button.tag = i
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: UIControl.Event.touchUpInside)
            myView.addSubview(button)
            //Source for UIImage: https://stackoverflow.com/questions/26569371/how-do-you-create-a-uiimage-view-programmatically-swift
            let imgView = UIImageView(image: animals[i].image)
            imgView.frame = CGRect(x: xCor + 104, y: 0, width: 167, height: 167)
            myView.addSubview(imgView)
            myLabel.textAlignment = .center
            myLabel.center.x = self.view.center.x
            myLabel.font = UIFont(name: "Avenir", size: 20)
        }
        

        // Do any additional setup after loading the view.
    }
    
    @objc func buttonTapped(_ sender : UIButton){
        
        //Source for sound: https://stackoverflow.com/questions/25736470/swift-how-to-play-sound-when-press-a-button
        
        let tag = sender.tag
        let animal = animals[tag]
        let url = URL(fileURLWithPath: animal.soundPath)
        do{
            audioSound = try AVAudioPlayer(contentsOf: url)
            audioSound?.play()
        }
        catch{
            print("error") //error msgs
        }
        
        let alert = UIAlertController(title: animal.name, message: "This is \(animal.name), a \(animal.species) of age \(animal.age)", preferredStyle: .alert)
        
        print(animal)
        
        //Source for alerts: https://learnappmaking.com/uialertcontroller-alerts-swift-how-to/
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default ))
        self.present(alert, animated: true)
        
    }
}

extension ViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var curPage = 0
        let scrollX = Int(scrollView.contentOffset.x)
        
        if scrollX > 187{
            if scrollX > 562{
                curPage = 2
            }
            else{
                curPage = 1
            }
        }
        
        let myAnimal = animals[curPage]
        myLabel.text = myAnimal.species
        let alph: CGFloat = CGFloat(abs((187.5 - Double(scrollX % 375)) / (375 / 2)))
        
        myLabel.alpha = alph
        
    }
}

