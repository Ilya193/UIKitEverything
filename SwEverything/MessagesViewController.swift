//
//  MessagesViewController.swift
//  SwEverything
//
//  Created by ilya on 07.07.2024.
//

import Foundation
import UIKit

class MessagesViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var coordinator: AppCoordinator?
    
    private let viewModel = MessagesViewModel()
    
    private lazy var messagesTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(MessageView.self, forCellReuseIdentifier: "MessageView")
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        title = "Ваши сообщения"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "power"), style: .plain, target: self, action: #selector(onTapAdd))
        
        view.addSubview(messagesTableView)
        
        messagesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messagesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            messagesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            messagesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            messagesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.messagesTableView.reloadData()
            }
        }
        
        viewModel.fetchPosts()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageView") as? MessageView {
            let item = viewModel.messages[indexPath.row]
            cell.configure(title: item.title, body: item.body)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc private func onTapAdd() {
        coordinator?.logout()
    }
}
