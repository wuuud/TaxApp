//
//  ViewController.swift
//  TaxApp
//
//  Created by H M on 2022/10/23.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //1.初期設定
    var totalButtonItem: UIBarButtonItem! // 追加ボタン
    var inputText = ""
    var beforeTax8: Double = 0.0
    var beforeRoundTax10: Double = 0.0
    //  オプショナルではないので、初期値を入れてあげる
    var taxArray: [String] = []
    //2.紐付け
    @IBOutlet weak var priceText: UITextField!
    @IBAction func totalButton(_ sender: UIBarButtonItem) {
    }
    @IBOutlet weak var taxPriceLabel: UILabel!
    @IBOutlet weak var TableView: UITableView!
    @IBAction func addPrice(_ sender: UIButton) {
        if taxPriceLabel.text != "" {
            let userDefaults = UserDefaults.standard //そのままだと長いので変数にいれる
            taxArray.append(taxPriceLabel.text!) //TextFiebldで記入されたテキストを入れる
            userDefaults.set(taxArray, forKey: "add") //キー"add"で配列をUserDefaultsに保存
        }
    }
    
    //segmentedhttps://qiita.com/rea_sna/items/7e472af2ce8d03831b55
    
    
    @IBAction func selectSegmentedControl(_ sender: UISegmentedControl) {
    }
    @IBAction func tappedSegmentedControl(_ sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0:
        //https://ios-docs.dSev/swiftui-part5/
        if let unwrappedTaxPriceLabel = taxPriceLabel.text {
            let price8 = Double(unwrappedTaxPriceLabel)
            let tax8 = price8! * 1.08
            self.taxPriceLabel.text = String(tax8)
            print(taxArray[0])
        } else {
            priceText.text = String(0)
            print("選択されたもの：nil")
        }
        
    case 1:
        print("選択されたもの：10%")
        //            let bPriceText = Double(priceText.text!)
        //            let bPriceText2 = bPriceText! * 1.1
        //                Text("価格：\(inputText)")
        //            var beforeRoundTax10 = (Double(priceText.text) ?? 0) * 1.1
        self.taxPriceLabel.text = String(beforeRoundTax10)
    default:
        print("選択されたもの：8%")
    }
}


//3−2.viewDid
override func viewDidLoad() {
    super.viewDidLoad()
    //        totalButtonItem = UIBarButtonItem(title: "合計", style: .done, target: self, action: #selector(totalButtonPressed(_:)))
    // ナビゲーションバー にボタンを追加
    self.navigationItem.rightBarButtonItem = totalButtonItem
    priceText.placeholder = "数字を入力"
    //まずはUserDefaultsからすでに入力されているpriceをtaxPriceに読み込む
    let userDefaults = UserDefaults.standard
    if userDefaults.object(forKey: "add") != nil{
        taxArray = userDefaults.object(forKey: "add") as! [String]
    }
}

//3-3.tableview用 https://www.sejuku.net/blog/36626
func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
}
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return taxArray.count
}
//何を表示するか
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // セルのオブジェクトを作成
    // "TaxPriceCell" の部分はStoryboardでセルに設定したIdentifierを指定しています。
    let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TaxPriceCell", for: indexPath)
    // namesから該当する行の文字列を取得してセルに設定します。
    // indexPath.rowで何行目かがわかります。
    cell.textLabel?.text = taxArray[indexPath.row]
    return cell
}

//4.関数
//4-1.Action
//4-2.func
//①アラート  決まり文句
func showAlert(message: String) {
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
    alert.addAction(close)
    present(alert, animated: true, completion: nil)
}
}
