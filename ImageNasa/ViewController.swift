//
//  ViewController.swift
//  ImageNasa
//
//  Created by Alejandro Noriega Montalban on 8/25/20.
//  Copyright © 2020 Alejandro Noriega Montalban. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var dates: [Date] = []
    private let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupFormatter()
        setDays()
    }

    // MARK: - Setup

    private func setupFormatter() {
        formatter.dateStyle = .medium
        formatter.locale = Locale.current
    }

    private func setDays() {
        for i in 0...100 {
            dates.append(Date(timeIntervalSinceNow: -84_600 * Double(i)))
        }

        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue",
            let controller = segue.destination as? DetailViewController {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                controller.selectedDate = dates[indexPath.row]
            }
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "mycell")
        cell.textLabel?.text  = formatter.string(from: dates[indexPath.row])
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "detailSegue", sender: self)
    }

}
