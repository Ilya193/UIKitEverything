//
//  BottomSheetViewController.swift
//  SwEverything
//
//  Created by ilya on 07.07.2024.
//

import Foundation
import UIKit

class BottomSheetViewController: UIViewController, UINavigationControllerDelegate {
    
    private lazy var timer: Timer = {
        return Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(onTick), userInfo: nil, repeats: true)
    }()
    
    private let titleText = "Проверка никнейма.\nПожалуйста, подождите"
    
    var onClose: ((Bool) -> Void)?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = titleText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.alpha = 0
        label.textColor = .green
        return label
    }()
    
    private var counter = 1
    
    private var time = 0.0
    
    private var isEntry = false
    
    @objc private func onTick() {
        time += 0.5
        
        var generateText = ""
        
        for _ in 1...counter {
            generateText += "."
        }
        
        titleLabel.text = titleText + generateText
        
        counter = counter == 3 ? 1 : counter + 1
        
        if time > 1.0 {
            self.timer.invalidate()
            isEntry = true
            self.infoLabel.text = "Вы успешно вошли в аккаунт"
            UIView.transition(with: infoLabel, duration: 0.3, animations: {
                self.infoLabel.alpha = 1
            }, completion: { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.dismiss(animated: true)
                })
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RunLoop.current.add(timer, forMode: .common)
        
        view.addSubview(titleLabel)
        view.addSubview(infoLabel)
        
        [titleLabel, infoLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])

        self.view.backgroundColor = .white
        self.view.layer.cornerRadius = 10
        
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeGestureRecognizer.direction = .up
        self.view.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("2")
        self.timer.invalidate()
        onClose?(isEntry)
    }
    
    @objc private func handleSwipe() {
        self.dismiss(animated: true)
    }
    
    func close() {
        dismiss(animated: true)
    }
}
