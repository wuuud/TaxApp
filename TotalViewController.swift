//
//  TotalViewController.swift
//  TaxApp
//
//  Created by H M on 2022/10/24.
//

import UIKit

class TotalViewController: UIViewController {
    //1.初期設定
var backButton: UIBarButtonItem! // 戻るボタン
    var taxArray: [Double] = []
    //2.紐付け
    //戻るボタン
    //①トップ画面に戻る
    @IBAction func backButton(_ sender: Any) {
        //前の画面に遷移
        dismiss(animated: false, completion: nil)
    }
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBAction func shareButton(_ sender: UIButton) {
    }
    //3.override
    override func viewDidLoad() {
        super.viewDidLoad()
        // ナビゲーションバー に戻るボタンを追加
  self.navigationItem.leftBarButtonItem = backButton
        //まずはUserDefaultsからすでに入力されているpriceをtaxPriceに読み込む
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: "add") != nil{
            taxArray = userDefaults.object(forKey: "add") as! [Double]
            let total = Int(taxArray.reduce(0, +))
                        totalPriceLabel.text = String(total)
        } else {
            print("数値に変換できません")
        }
    }

    //    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    //        }
    //    */
    
}
