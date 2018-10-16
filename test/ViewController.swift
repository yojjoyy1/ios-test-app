//
//  ViewController.swift
//  test
//
//  Created by sinyilin on 2018/9/14.
//  Copyright © 2018年 sinyilin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCell
        cell.layer.cornerRadius = cell.bounds.size.height / 2
        cell.layer.masksToBounds = true
        cell.title.text = self.titleArr[indexPath.row]
        cell.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.7)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: self.collV.bounds.size.height * 0.2, left: 10, bottom: self.collV.bounds.size.height * 0.2, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 50
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("我點到:\(titleArr[indexPath.row])")
        let stroyboad = UIStoryboard(name: "Main", bundle: nil)
        switch indexPath.row
        {
        case 0:
            let vc = stroyboad.instantiateViewController(withIdentifier: "IntroductionViewController") as! IntroductionViewController
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            let vc = stroyboad.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            let vc = stroyboad.instantiateViewController(withIdentifier: "LookViewController") as! LookViewController
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 3:
            exit(0)
            break
        default:
            break
        }
    }
    @IBOutlet weak var collV: UICollectionView!
    var titleArr = ["人物介紹","出生地","看漫畫","退出"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collV.delegate = self
        collV.dataSource = self
        collV.backgroundColor = nil
        collV.isScrollEnabled = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(back))
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.red
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:my function
    @objc func back()
    {
        self.navigationController?.popViewController(animated: true)
    }


}

