//
//  SettingViewController.swift
//  My-Timer
//
//  Created by yukimasa ikeda on 2019/07/20.
//  Copyright © 2019 yukimasa. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // UIPickerViewに表示するでデータをArrayで作成
    let settingArray : [Int] = [10, 20, 30, 40, 50, 60]
    
    // UIPickerViewに表示するでデータ(分)をArrayで作成
    let settingArray2 : [Int] = [0, 1, 2, 3]
    
    // 設定値を覚えるキーを設定
    let settingKey = "timer_value"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // timerSettingPickerのデリゲートとデータソースの通知先を指定
        timerSettingPicker.delegate = self
        timerSettingPicker.dataSource = self
        
        // UserDefaultsの取得
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: settingKey)
        let timerValue2 = settings.integer(forKey: "minuets") / 60
        
        // Pickerの選択を合わせる
        for row in 0..<settingArray.count {
            if settingArray[row] == timerValue {
                timerSettingPicker.selectRow(row, inComponent: 1, animated: true)
            }
        }
        
        for row in 0..<settingArray2.count {
            if settingArray2[row] == timerValue2 {
                timerSettingPicker.selectRow(row, inComponent: 0, animated: true)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var timerSettingPicker: UIPickerView!
    
    @IBAction func decisionButtonAction(_ sender: Any) {
        // 前の画面に戻る
        _ = navigationController?.popViewController(animated: true)
    }
    
    // UIPickerViewの列数を設定
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // UIPickerViewの行数を設定
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return settingArray2.count
        } else {
            return settingArray.count
        }
    }
    
    // UIPickerViewの表示する内容を設定
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return String(settingArray2[row])
        } else {
            return String(settingArray[row])
        }
    }
    
    // picker選択時に実行
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // UserDefaultsの設定
        let settings = UserDefaults.standard
        if component == 0 {
            settings.setValue(settingArray2[row] * 60, forKey: "minuets")
        } else {
            settings.setValue(settingArray[row], forKey: settingKey)
        }
        settings.synchronize()
    }
    
}
