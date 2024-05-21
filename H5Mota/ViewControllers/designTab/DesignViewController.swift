//
//  DesignViewController.swift
//
//  Created by Arbitrary Mouse on 12/1/22.
//  ArbitraryMouse@outlook.com
//  This file is used to get the code for the design ViewController
//

import Foundation
import UIKit

//nothing important in this code

class DesignViewController: UIViewController, UIDocumentPickerDelegate{
    
    //nothing here in the code, a little bit code in the Download Web View Controller.
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func saveFileToPhone(url: URL) {
        let picker = UIDocumentPickerViewController(url: url, in: .exportToService)
        picker.delegate = self
        picker.modalPresentationStyle = .formSheet
        self.present(picker, animated: true)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        // 保存成功
        print("保存成功")
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
//        SWToast.showText(message: "PickerWasCancelled")
    }
    
    @IBAction func downloadButton(_ sender: UIButton) {
        let urlStr = "https://h5mota.com/games/template/H5mota_template.zip"
        let taskUrl = URL(string: urlStr)!
        print("文件下载url:\(taskUrl)")
        let request = URLRequest(url: taskUrl)
        let session = URLSession(configuration: .default)
        print("a")
        session.downloadTask(with: request) { [weak self] tempUrl, response, error in
            guard let self = self, let tempUrl = tempUrl, error == nil else {
                print("文件下载失败")
                return
            }
            print("文件下载完成\(tempUrl)")
            // 下载完成之后会自动删除temp中的文件，把文件移动到document中。
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            print("文件下载完成 documentsDirectory \(documentsDirectory)")
            // 建议使用的文件名，一般跟服务器端的文件名一致
            let destinationPath = documentsDirectory.appendingPathComponent(response?.suggestedFilename ?? "")
            // 如果存在同名的
            if FileManager.default.fileExists(atPath: destinationPath.path) {
                do {
                    try FileManager.default.removeItem(atPath: destinationPath.path)
                } catch _ {
                    
                }
            }
            print("文件下载 document下的可保存的url:\(destinationPath)")
            do {
                // 文件移动至document
                try FileManager.default.copyItem(atPath: tempUrl.path, toPath: destinationPath.path)
                // main
                DispatchQueue.main.async {
                    self.saveFileToPhone(url: destinationPath)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}



