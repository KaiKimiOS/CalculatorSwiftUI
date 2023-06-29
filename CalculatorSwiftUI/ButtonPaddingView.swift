//
//  ResultView.swift
//  CalculatorSwiftUI
//
//  Created by kaikim on 2023/06/28.
//

import SwiftUI

struct ButtonPaddingView: View {
    var pressNumber: String //ContentView에 넘겨줄 변수 선언
    
    // ⭐️ .padding .font() 레이아웃을 기능을 위한 View임
    var body: some View {

        Text("\(pressNumber)")
            .padding()
            .font(.largeTitle)
            .foregroundColor(.blue)
 

    }
}

struct ButtonPaddingView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonPaddingView(pressNumber: "10") //ResultView_Previews에 미리보기 보여주기
    }
}
