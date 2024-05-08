//
//  ContentView.swift
//  SwiftUIWidget
//
//  Created by 이중엽 on 4/29/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var text: String = ""
    @State private var legacyText: String = "legacy"
    @State private var isPresented = false
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("SwiftUI 텍스트필드", text: $text, axis: .vertical)
                .font(.title)
                .padding()
                .border(Color.black)
                .lineLimit(1...4)
                .accessibilityIdentifier("emailTextField")
                .accessibilityLabel("이메일 가입란")
            LegacyTextField(text: $legacyText)
                .frame(height: 50)
                .accessibilityIdentifier("passwordTextField")
            Button("버튼 클릭") {
                isPresented = true
            }
            .accessibilityIdentifier("loginButton")
            Text(legacyText)
        }
        .padding()
        .sheet(isPresented: $isPresented, content: {
            LegacyViewController()
        })
    }
}

struct ContentDetailView: View {
    var body: some View {
        Text("Test")
    }
}

// UIViewRepresentable: UIView -> SwiftUI View에 랩핑하기 위해
struct LegacyTextField: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextField {
        let view = UITextField()
        view.borderStyle = .bezel
        view.keyboardType = .numberPad
        view.tintColor = .red
        view.font = .boldSystemFont(ofSize: 20)
        view.placeholder = "UIKit 텍스트필드"
        view.textAlignment = .center
        view.text = text
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
    
    }
    
    // option
    // makeCoordinator 안에 써야하는 코드들이 많아서 반환 Void 대신 클래스 생성
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    class Coordinator:NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
            // $ 데이터를 참조, ._ 데이터를 직접 넣어줌
        }
        
        // 특성상 마지막 한글자 출력이 느리게 반응함
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            text = textField.text ?? ""
            return true
        }
    }
}

#Preview {
    ContentView()
}
