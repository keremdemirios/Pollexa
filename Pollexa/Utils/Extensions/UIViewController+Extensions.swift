//
//  UIViewController+Extensions.swift
//  Pollexa
//
//  Created by Kerem Demir on 27.05.2024.
//

import UIKit

extension UIViewController {
    
    // MARK: Alert View
    func showAlert(title: String = "Warning", message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default) { _ in
            completion?()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Close", style: .cancel))
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.present(alert, animated: true)
        }
    }
    
    func showDeleteAlert(title: String = "Silme İşlemi", message: String = "Silmek istediğinizden emin misiniz?", completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "İptal", style: .cancel) { _ in
            completion(false)
        }
        
        let deleteAction = UIAlertAction(title: "Sil", style: .destructive) { _ in
            completion(true)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Hide Keyboard When Tapped Around
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


