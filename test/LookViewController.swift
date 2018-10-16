//
//  LookViewController.swift
//  test
//
//  Created by sinyilin on 2018/10/16.
//  Copyright © 2018年 sinyilin. All rights reserved.
//

import UIKit

class LookViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var webv: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "看漫畫"
        self.automaticallyAdjustsScrollViewInsets = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        webv.frame.origin.y = (self.navigationController?.navigationBar.frame.origin.y)! + (self.navigationController?.navigationBar.frame.size.height)!
        webv.bounds = self.view.bounds
        webv.delegate = self
        //配合網頁大小加載到整個手機寬度
        webv.scalesPageToFit = true
        let url = URL(string: "https://www.cartoonmad.com/comic/1152.html")
        let request = URLRequest(url: url!)
        webv.loadRequest(request)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
