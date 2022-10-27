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
import FirebaseAuth
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {
    
    private lazy var setGoogleLoginButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "google_login@2x.png"), for: .normal)
        button.addTarget(self, action: #selector(googleSignInButtonPress), for: .touchUpInside)
        return button
    }()
    
    private lazy var setKakaoLoginButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "kakao_login_medium_narrow.png"), for: .normal )
        button.addTarget(self, action: #selector(kakaoSignInButtonPress), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser?.uid != nil {
            print("auto login success")
            let nextVC = TabBarController()
            nextVC.modalPresentationStyle = .overFullScreen
            self.present(nextVC, animated: true, completion: nil)
        }else {
            print("auto login failed")
        }
    }
    
    @objc
    func googleSignInButtonPress() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {return}
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            guard error == nil else { return }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { _ , _ in
                
            }
        }
    }
    
    @objc
    func kakaoSignInButtonPress() {
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { _, error in
                if let error = error {
                    print(error)
                    self.kakaoLogin()
                } else {
                    print("토큰 유효성 체크 성공")
                    self.kakaoLogin()
                }
            }
        } else {
            print("토큰 없음.")
           kakaoLogin()
        }
            
    }
    
    private func kakaoLogin() {
        
        //카카오톡 설치 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            //카카오톡 로그인. api 호출 결과를 클로저로 전달.
            print("앱에 카카오톡 있음")
            self.loginWithApp()
        } else {
            //카카오톡이 깔려있지 않을 경우에는 웹 브라우저로 카카오톡 로그인
            print("앱에 카카오톡이 없으므로 웹으로 로그인")
            self.loginWithWeb()
            
        }
    }
}

private extension LoginViewController {
    func setupViews() {
        [setGoogleLoginButton, setKakaoLoginButton].forEach { view.addSubview($0)}
        
        setGoogleLoginButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        setKakaoLoginButton.snp.makeConstraints {
            $0.top.equalTo(setGoogleLoginButton.snp.bottom).offset(20.0)
            $0.centerX.equalToSuperview()
        }
    }
}




extension LoginViewController {
    
    //카카오톡 앱으로 로그인
    func loginWithApp() {
        UserApi.shared.loginWithKakaoTalk { oauthToken, error in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoTalk() success." )
                if let token = oauthToken {
                    print("DEBUG: 카카오톡 토큰 \(token)")
                    self.loginFirebase()
                }
            }
        }
    }
    
    
    
    func loginWithWeb() {
        UserApi.shared.loginWithKakaoAccount { oauthToken, error in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoTalk() success." )
                if let token = oauthToken {
                    print("DEBUG: 카카오톡 토큰 \(token)")
                    self.loginFirebase()
                }
            }
        }
    }
    
    private func loginFirebase() {
        UserApi.shared.me() { user, error in
            if let error = error {
                print("카카오톡 사용자 정보 가져오기 에러 \(error.localizedDescription)")
                
            }else {
                print("카카오톡 사용자 정보 가져오기 성공")
                
                //파이어베이스 유저생성
                Auth.auth().signIn(withEmail: (user?.kakaoAccount?.email)!, password: "\(String(describing: user?.id))") { result, error in
                    if let error = error{
                        print("파이어베이스 사용자 생성 실패")
                        self.presentToMain()
                    }else {
                        print("파이어베이스 사용자 생성 성공")
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
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
}
    
 
    



