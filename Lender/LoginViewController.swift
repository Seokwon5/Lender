//
//  LoginViewController.swift
//  Lender
//
//  Created by 이석원 on 2022/10/17.
//

import UIKit

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setKakaoLoginButton()
    }
    
    func setKakaoLoginButton() {
        let kakaoButton = UIButton()
        kakaoButton.setImage(UIImage(named: "kakao_login_medium_narrow.png"), for: .normal)
        kakaoButton.addTarget(self, action: #selector(kakaoSignInButtonPress), for: .touchUpInside)

        view.addSubview(kakaoButton)
        // AutoLayout
        kakaoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            kakaoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            kakaoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            kakaoButton.widthAnchor.constraint(equalToConstant: 200),
            kakaoButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    @objc
    func kakaoSignInButtonPress() {
        //카카오톡 설치 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            //카카오톡 로그인. api 호출 결과를 클로저로 전달.
            loginWithApp()
        } else {
            //카카오톡이 깔려있지 않을 경우에는 웹 브라우저로 카카오톡 로그인
            loginWithWeb()
        }
    }
}

extension LoginViewController {
    
    //카카오톡 앱으로 로그인
    func loginWithApp() {
        UserApi.shared.loginWithKakaoTalk {(_, error) in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoTalk() success." )
                
                UserApi.shared.me {(user, error) in
                    if let error = error {
                        print(error)
                    } else {
                        self.presentToMain()
                    }
                }
            }
            
        }
    }
    
    
    func loginWithWeb() {
        UserApi.shared.loginWithKakaoAccount {(_, error) in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoAccount() success.")
                
                UserApi.shared.me {(user, error) in
                    if let error = error {
                        print(error)
                    } else {
                        self.presentToMain()
                    }
                }
            }
        }
    }
    
    //화면 전환 함수
    func presentToMain() {
        let nextVC = TabBarController()
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: true)
    }
    
}
