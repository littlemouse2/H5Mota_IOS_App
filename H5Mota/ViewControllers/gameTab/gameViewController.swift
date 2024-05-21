//
//  gameViewController.swift
//  H5Mota
//
//  Code for the collection view view controller.
//
//  Created by Arbitrary Mouse on 12/1/22.
//  ArbitraryMouse@outlook.com
//

import Foundation
import UIKit

let reuseIdentifier = "Cell"

class gameViewController: UICollectionViewController {
    //rows and columns
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    //rows and columns
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    //override return method
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
        //Generate random text lists
        let gameNameList = ["咕工智障","斯莉英雄传","龙之传奇","魔方世界6","难酬","我为仙帝","夜花吟","万宁魔塔"]
        let cell = collectionView.dequeueReusableCell (withReuseIdentifier: reuseIdentifier, for: indexPath) as! gameCollectionViewCell
        //Generate random text for each cell
        cell.gameName.text = "\(gameNameList[Int.random(in: 0..<8)])"
        cell.numberOfPeople.text = "\(Int.random(in: 0..<19999))"
        cell.winPeople.text = "\(Int.random(in: 0..<2999))"
        //data persistance
        let documentFolderPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileUrl = documentFolderPath.appendingPathComponent("h5motaCache.txt")
        let data = "gameName = \(cell.gameName.text!); numberOfPeople = \(cell.numberOfPeople.text!); winPeople = \(cell.winPeople.text!)"

        //encode the data
        let encoder = JSONEncoder()
        
        do {
            let Preparedata = try encoder.encode(data)
            let string = String(data: Preparedata, encoding: .utf8)!
            
            try string.write(to: fileUrl, atomically: true, encoding: .utf8)
        } catch {
            print("error \(error)")
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}



