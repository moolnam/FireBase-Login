//
//  RegisterViewController.swift
//  FireBase Login
//
//  Created by KimJongHee on 2022/05/06.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        // 회원가입 버튼
        // 비밀번호 6자리 이하로 입력하면 로그인이 되지 않는다. 
        if let email = emailTextField.text, let password = passwordTextField.text {
            // 이메일과 패스워드가 입력된다면
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                // 파이어베이스 에 있는 createUser() 메소드를 가져온다
                if let e = error {
                    print(e.localizedDescription)
                    // 에러 메시지 현지화 설명
                } else {
                    // Navigate to the ChatViewController
                    self.performSegue(withIdentifier: "RegisterToCaht", sender: self)
                    // 에러가 아니라면 내가 가고자 하는 뷰로 아이덴티파이어를 보고 뷰가 전환된다.
                }
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

}
