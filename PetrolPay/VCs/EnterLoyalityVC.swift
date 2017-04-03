//
//  EnterLoyalityVC.swift
//  PetrolPay
//
//  Created by Виталий Волков on 12.03.17.
//  Copyright © 2017 Виталий Волков. All rights reserved.
//

import UIKit

class EnterLoyalityVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    let stations:[String] = ["lukoil", "rosneft"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {super.didReceiveMemoryWarning()}

}

extension EnterLoyalityVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //кол-во элементов для каждой из секций
        return stations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //надо вернуть объект для отображения n-ной ячейки таблицы
        let cell = tableView.dequeueReusableCell(withIdentifier: "gas_cell") as? GasTableViewCell
        cell?.createCell(label: stations[indexPath.row])
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //а это вызывается если юзер кликнул по какой-то ячейке
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //а здесь нао вернуть кол-во секций(для простой таблицы это 1)
        return 1
    }
}

