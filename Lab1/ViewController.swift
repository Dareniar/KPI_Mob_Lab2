//
//  ViewController.swift
//  Lab1
//
//  Created by Danil Shchegol on 3/11/19.
//  Copyright © 2019 Danil Shchegol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultView: UIView!
    
    var advice: String = "Вы не выбрали ни одного критерия"
    
    var selectedColor: Int?
    var selectedPrice: Int?
    
    let colors = ["Черный", "Белый", "Желтый", "Красный", "Зеленый", "Синий"]
    let prices = ["До 30 грн. за цветок", "До 60 грн. за цветок", "Выше 60 грн. за цветок"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        button.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
    }
    
    @objc func okButtonTapped() {
        
        setupAdviceMessage()
        
        if let text = textField.text, text.count > 0 {
            if selectedColor != nil, selectedPrice != nil {
                advice = "\(text), советуем вам приобрести \(advice)"
            } else {
                advice = "\(text), \(advice)"
            }
        }
        
        resultLabel.text = advice
        resultView.isHidden = false
    }
    
    func setupAdviceMessage() {
        guard let color = selectedColor, let price = selectedPrice else {
            advice = "Вы не выбрали ни одного критерия"
            return
        }
        
        switch (color, price) {
        case (0, 0): advice = "Черный одуван"
        case (1, 0): advice = "Белая ромашка"
        case (2, 0): advice = "Желтый одуван"
        case (3, 0): advice = "Красный мак"
        case (4, 0): advice = "Зеленый лемонграсс"
        case (5, 0): advice = "Синий колокольчик"
        case (0, 1): advice = "Черный тюльпан"
        case (1, 1): advice = "Белый тюльпан"
        case (2, 1): advice = "Желтый тюльпан"
        case (3, 1): advice = "Красный тюльпан"
        case (4, 1): advice = "Зеленый тюльпан"
        case (5, 1): advice = "Синий тюльпан"
        case (0, 2): advice = "Черная роза"
        case (1, 2): advice = "Белая роза"
        case (2, 2): advice = "Желтая роза"
        case (3, 2): advice = "Красная роза"
        case (4, 2): advice = "Зеленая роза"
        case (5, 2): advice = "Синяя роза"
        default:     advice = "Вы не выбрали ни одного критерия"
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return colors.count
        } else {
            return prices.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Выберите цвет"
        } else {
            return "Выберите ценовую категорию"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell.textLabel?.text = indexPath.section == 0 ? colors[indexPath.row] : prices[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        for cell in tableView.visibleCells {
            if tableView.indexPath(for: cell)?.section == indexPath.section {
                cell.accessoryType = .none
            }
        }
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        if indexPath.section == 0 {
            if selectedColor == indexPath.row {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
                selectedColor = nil
            } else {
                selectedColor = indexPath.row
            }
        } else {
            if selectedPrice == indexPath.row {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
                selectedPrice = nil
            } else {
                selectedPrice = indexPath.row
            }
        }
    }
}
