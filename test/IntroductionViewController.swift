//
//  IntroductionViewController.swift
//  test
//
//  Created by sinyilin on 2018/9/17.
//  Copyright © 2018年 sinyilin. All rights reserved.
//

import UIKit
import MBProgressHUD
class IntroductionViewController: UIViewController,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tablev: UITableView!
    @IBOutlet weak var scrollV: UIScrollView!
    let imgStr = ["魯夫","索隆","娜美"]
    @IBOutlet weak var tableV: UITableView!
    var progressView:UIActivityIndicatorView!
    var actView:UIView!
    var dicArr:NSArray!
    var count = 0
    var vcpage = 0
    var contentKey:String!
    var hud:MBProgressHUD!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "人物介紹"
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.tintColor = UIColor.red
        pageControl.addTarget(self, action: #selector(pageChanged(sender:)), for: .valueChanged)
        let window = UIApplication.shared.windows.last
        
        hud = MBProgressHUD(frame: (window?.bounds)!)
        window?.addSubview(hud)
        CustomHud().ShowHUD(hud: self.hud, message: "讀取中")
        DispatchQueue.global().async {
            GetGoogleSheetAPi().googleAPi { (i, arr) in
                self.count = i
                self.dicArr = arr
                self.pageControl.numberOfPages = i
                DispatchQueue.main.async {
                    switch self.vcpage
                    {
                    case 0:
                        self.contentKey = "value"
                        break
                    case 1:
                        self.contentKey = "value2"
                        break
                    case 2:
                        self.contentKey = "value3"
                        break
                    default:
                        break
                    }
                    CustomHud().HiddenHUD(hud: self.hud)
                    let dic = arr[0] as! NSDictionary
                    self.title = dic[self.contentKey] as? String
                    self.tableV.reloadData()
                }
                print("刷新 i:\(i),arr:\(arr)")
            }
        }
        tableV.delegate = self
        tableV.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollV.delegate = self
        scrollV.isPagingEnabled = true
        scrollV.alwaysBounceVertical = false
        scrollV.bounces = true
        scrollV.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.scrollV.frame.size.height)
        scrollV.frame.origin.y = (self.navigationController?.navigationBar.frame.size.height)!
        scrollV.contentSize = CGSize(width: Int(self.scrollV.bounds.size.width) * imgStr.count, height: Int(self.scrollV.frame.size.height))
        for i in 0...imgStr.count-1
        {
            let img = UIImageView(frame: CGRect(x: Int(self.scrollV.bounds.size.width) * i, y: 0, width: Int(self.scrollV.bounds.size.width), height: Int(self.scrollV.bounds.size.height)))
            scrollV.addSubview(img)
            //            print("img:\(imgStr[i])")
            img.image = UIImage(named: imgStr[i]+".jpeg")
            img.contentMode = .scaleToFill
            if i == (imgStr.count - 1)
            {
                self.scrollV.addSubview(self.pageControl)
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear scrollV:\(self.scrollV.frame)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK:TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TbvCell", for: indexPath) as! TbvCell
        let dic = dicArr[indexPath.row] as! NSDictionary
        cell.title.text = (dic["key"] as? String)! + ":"
        cell.content.text = dic[contentKey] as? String
        return cell
    }
    //MARK:ScrollView
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
         let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = page
        vcpage = page
        switch self.vcpage
        {
        case 0:
            self.contentKey = "value"
            break
        case 1:
            self.contentKey = "value2"
            break
        case 2:
            self.contentKey = "value3"
            break
        default:
            break
        }
        let dic = self.dicArr[0] as! NSDictionary
        self.title = dic[self.contentKey] as? String
        self.tableV.reloadData()
    }
    //MARK:pageControl
    // 點擊點點換頁
    @objc func pageChanged(sender: UIPageControl)
    {
        // 依照目前圓點在的頁數算出位置
        var frame = scrollV.frame
        frame.origin.x =
            frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        
        self.vcpage = Int(frame.origin.x / self.view.frame.size.width)
        switch self.vcpage
        {
        case 0:
            self.contentKey = "value"
            break
        case 1:
            self.contentKey = "value2"
            break
        case 2:
            self.contentKey = "value3"
            break
        default:
            break
        }
        let dic = self.dicArr[0] as! NSDictionary
        self.title = dic[self.contentKey] as? String
        self.tableV.reloadData()
        
        // 再將 UIScrollView 滑動到該點
        scrollV.scrollRectToVisible(frame, animated:true)
    }

}
