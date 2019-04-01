//
//  DownloadTaskViewController.swift
//  DemoCoreLocation
//
//  Created by SHILEI CUI on 3/29/19.
//  Copyright © 2019 scui5. All rights reserved.
//

import UIKit


let urlStr = "https://www.hq.nasa.gov/alsj/a17/A17_FlightPlan.pdf"

class DownloadTaskViewController: UIViewController, URLSessionDownloadDelegate, UIDocumentInteractionControllerDelegate {

    var downloadTask : URLSessionDownloadTask!
    var session : URLSession!
    
    var documentInteractionController: UIDocumentInteractionController!
    var pdfURL : URL!
    
    @IBOutlet weak var progView: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let config = URLSessionConfiguration.background(withIdentifier: "com.testing")
        session = URLSession(configuration: config, delegate: self as! URLSessionDelegate, delegateQueue: OperationQueue.main)
        progView.setProgress(0, animated: true)
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        //Using fileManager to move file to another location.
        print(location)
        guard let url = downloadTask.originalRequest?.url else { return }
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        print(destinationURL)
        // delete original copy
        try? FileManager.default.removeItem(at: destinationURL)
        // copy from temp to Document
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            self.pdfURL = destinationURL
            let controller = UIDocumentInteractionController.init(url: self.pdfURL)
            controller.delegate = self
            controller.presentPreview(animated: true)
        } catch let error {
            print("Copy Error: \(error.localizedDescription)")
        }
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let value = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        progView.setProgress(value, animated: true)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        //print(error?.localizedDescription)
    }
    
    @IBAction func downloadBtn(_ sender: UIButton) {
        if downloadTask == nil{
            let url = URL(string: urlStr)
            downloadTask = session.downloadTask(with: url!)
            //resume() is very important
            downloadTask.resume()
        }
    }
    
    @IBAction func pauseBtn(_ sender: UIButton) {
        if downloadTask != nil {
            downloadTask.suspend()
        }
    }
    
    @IBAction func resumeBtn(_ sender: UIButton) {
        if downloadTask != nil{
            downloadTask.resume()
        }
    }
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        if downloadTask != nil {
            downloadTask.cancel()
            progView.setProgress(0, animated: true)
        }
    }

}
