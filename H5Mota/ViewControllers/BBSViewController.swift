//
//  BBSViewController.swift
//  View Controller for BBS
//  Code for View Controller BBS.
//
//  Created by Arbitrary Mouse on 12/1/22.
//  ArbitraryMouse@outlook.com
//

import UIKit

class BBSViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //random text lists
    let titles = ["h5蓝海塔大赛","今天怎么没有新塔","水[经验+3]","大佬们，请教一下","lhjnb！！","《咕工智障》真的太好玩了"]
    let names = ["鹿间裕贵", "风曦流光", "qweasz687", "名字何意思", "艾之葵", "老黄鸡"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //override table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(#function) \(indexPath)")
    }

    // How many sections to render
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // How many rows to render for a given section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    // For a given section and row, what is the cell to render
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //cell
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "MainCell")
        
        //generate random text
        let titleText : String = "\(titles[Int.random(in: 0..<6)])"
        let detailText : String = "\(names[Int.random(in: 0..<6)])发表于\(Int.random(in: 1..<13))/\(Int.random(in: 1..<29))/202\(Int.random(in: 0..<3))"
        cell.textLabel?.text = titleText
        cell.detailTextLabel?.text = detailText
        
        //data persistance
        let documentFolderPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileUrl = documentFolderPath.appendingPathComponent("h5motaCache.txt")
        let data = "gameName = \(titleText); numberOfPeople = \(detailText)"

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
}

