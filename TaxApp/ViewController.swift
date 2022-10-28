//
//  ViewController.swift
//  TaxApp
//
//  Created by H M on 2022/10/23.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //1.初期設定
    //    var totalButtonItem: UIBarButtonItem! // 追加ボタン
    var inputText = ""
    var beforeTax8: Double = 0.0
    var beforeRoundTax10: Double = 0.0
    //  オプショナルではないので、初期値を入れてあげる
    var taxArray: [Double] = []
    var userDefaults = UserDefaults.standard
    //2.紐付け
    @IBOutlet weak var priceText: UITextField!
    //    @IBAction func totalButton(_ sender: UIBarButtonItem) {
    //    }
    @IBOutlet weak var taxPriceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addPrice(_ sender: UIButton) {
        if taxPriceLabel.text != "" {
            if let tax = Double(taxPriceLabel.text!) {
                taxArray.append(tax) //TextFiebldで記入されたテキストを入れる
                userDefaults.set(taxArray, forKey: "add") //キー"add"で配列をUserDefaultsに保存
                taxPriceLabel.text = ""
            }
            tableView.reloadData()
        }
    }
    @IBAction func deleteTaxArrayButton(_ sender: Any) {
        //配列を空にする
        taxArray = []
        userDefaults.set(taxArray, forKey: "add")
        tableView.reloadData()
    }
    //segmentedhttps://qiita.com/rea_sna/items/7e472af2ce8d03831b55
    @IBOutlet weak var selectSegmentedControl: UISegmentedControl!
    @IBAction func tappedSegmentedControl(_ sender: UISegmentedControl) {
        if priceText.text != "" {
            switch sender.selectedSegmentIndex {
                //https://ios-docs.dSev/swiftui-part5/
            case 0:
                calc(num: 1.1)
            case 1:
                calc(num: 1.08)
            default:
                priceText.text = String(0)
            }
        }else {
            priceText.text = String(0)
        }
    }
    
    
    //3−2.viewDid
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        // ナビゲーションバー にボタンを追加
        //        self.navigationItem.rightBarButtonItem = totalButtonItem
        priceText.placeholder = "数字を入力"
        //まずはUserDefaultsからすでに入力されているpriceをtaxPriceに読み込む
        if userDefaults.object(forKey: "add") != nil{
        //                                              配列に入れるので[]
            taxArray = userDefaults.object(forKey: "add") as! [Double]
        }
        print(taxArray)
        tableView.reloadData()
    }
    
    //テキストフィールドに最初からフォーカスが表示される
    override func viewWillAppear(_ animated: Bool) {
        priceText.becomeFirstResponder()
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
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TaxPriceCell", for: indexPath)
        cell.textLabel?.text = String(taxArray[indexPath.row])
        print(String(taxArray[indexPath.row]))
        return cell
    }
    
    //4.関数
    //4-2.func
    //①アラート  決まり文句
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
    //②計算用
    func calc(num: Double) {
        if let unwrappedPriceText = priceText.text {
            //https://ios-docs.dSev/swiftui-part5/
            let price = Double(unwrappedPriceText)
            let tax = price! * (num)
            self.taxPriceLabel.text = String(tax)
            priceText.text = ""
        }else {
            priceText.text = String(0)
            priceText.text = ""
        }
    }
}
