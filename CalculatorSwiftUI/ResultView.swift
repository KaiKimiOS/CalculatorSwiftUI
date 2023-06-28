//
//  ResultView.swift
//  CalculatorSwiftUI
//
//  Created by kaikim on 2023/06/28.
//

import SwiftUI

struct ResultView: View {
    var result: String
    
    var body: some View {
        Text(result)

    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(result: "10")
    }
}
