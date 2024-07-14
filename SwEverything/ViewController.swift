//
//  ViewController.swift
//  SwEverything
//
//  Created by ilya on 30.06.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    weak var coordinator: AppCoordinator?
    
    private var bottomSheetController: BottomSheetViewController?
    
    private let buttonSignIn: UIButton = {
        let buttonSignIn = UIButton(type: .system)
        buttonSignIn.backgroundColor = .systemBlue
        buttonSignIn.setTitle("Войти", for: .normal)
        buttonSignIn.layer.cornerRadius = 8
        buttonSignIn.layer.masksToBounds = true
        buttonSignIn.tintColor = .white
        buttonSignIn.configuration = .tinted()
        buttonSignIn.addTarget(self, action: #selector(onClickButtonSignIn), for: .touchUpInside)
        return buttonSignIn
    }()
    
    private let nameSignIn: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите никнейм"
        textField.borderStyle = .none
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setup()
        title = "Авторизация"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        onClickButtonSignIn()
        return true
    }
    
    private func setup() {
        view.addSubview(buttonSignIn)
        view.addSubview(nameSignIn)

        nameSignIn.delegate = self
        
        buttonSignIn.translatesAutoresizingMaskIntoConstraints = false
        nameSignIn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonSignIn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            buttonSignIn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            buttonSignIn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            nameSignIn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameSignIn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            nameSignIn.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameSignIn.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    private func onClose(_ isEntry: Bool) {
        bottomSheetController = nil
        if isEntry {
            coordinator?.navigateToMesssagesScreen()
        }
    }
    
    @objc private func onClickButtonSignIn() {
        guard (nameSignIn.text != nil) && (nameSignIn.text?.isEmpty == false) else {
            return
        }
        
        bottomSheetController = BottomSheetViewController()
        if let sheet = bottomSheetController?.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        if let sheet = bottomSheetController {
            sheet.onClose = self.onClose
            present(sheet, animated: true)
        }
    }
}
