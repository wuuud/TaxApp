//
//  TotalViewController.swift
//  TaxApp
//
//  Created by H M on 2022/10/24.
//

import UIKit

class TotalViewController: UIViewController {
    //1.初期設定
    var backButtonItem: UIBarButtonItem! // 追加ボタン
    var taxArray: [String] = []
    //2.紐付け
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBAction func shareButton(_ sender: UIButton) {
    }
    //3.override
    override func viewDidLoad() {
        super.viewDidLoad()
        // ナビゲーションバー に戻るボタンを追加
        self.navigationItem.leftBarButtonItem = backButtonItem
        //まずはUserDefaultsからすでに入力されているpriceをtaxPriceに読み込む
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: "add") != nil{
            let taxArray = userDefaults.object(forKey: "add") as! [String]
//            var total = taxArray.reduce(0, +)
//            totalPriceLabel.text = String(total)
        } else {
            print("数値に変換できません")
        }
    }
    //4-2.func
    
    //    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    //        }
    //    */
    
}
