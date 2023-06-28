//
//  ContentView.swift
//  CalculatorSwiftUI
//
//  Created by kaikim on 2023/06/28.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - 변수 선언
    
    //1번 숫자, 숫자를 이어서 담아지게 배열로 설정함, 123 + 456이 가능하도록
    @State var number: [String] = [""]
    
    //출력 및 결과값을 화면에 바로 보여주기위한 변수
    @State var displayLabel: String = ""
    
    // "+" ,"-", "*" 의 String을 받아서 calculationFunction을 올바르게 작동하기 위함
    @State var calculatorMethod: String = ""
    
    // number의 배열을 클로저에 담아서 reduce 고차함수로 더하기 + 진행
    @State var calculateFunction: ([Int]) -> Int = {$0.reduce(0) { $0 + $1}}
    
    // number의 배열을 클로저에 담아서 곱하기, 나누기 진행
    @State var calculateFunction2: ([Int]) -> Int = {
        var secondNumber = 1
        
        for i in $0 {
        secondNumber *= i
    }
        return secondNumber
    }
    
    
    // number가 배열이기 때문에 number[count]를 통해서 원하는 배열에 접근하기 위해서
    @State var count:Int = 0
  
    var body: some View {
        
        VStack(alignment: .center) {
            Spacer()
            
            Text("간단 계산기").font(.largeTitle).foregroundColor(.blue)
            
            TextField("숫자를 눌러주세요", text: $displayLabel)//Binding<String>때문에 $붙힘
                .textFieldStyle(.roundedBorder)
                .font(.largeTitle)
                .lineLimit(1)
                .minimumScaleFactor(0.1) //화면에서 넘쳐서 "내가쓴글이..."처럼 다 안담길때 필요함
            
            //MARK: - "모든 버튼 레이아웃 Hstack으로 묶음"
            HStack{
                Button {
                    inputNumber(index:"1")
                } label: {
                    Text("1")
                } .font(.largeTitle)
                    .padding()
                Button {
                    inputNumber(index:"2")
                } label: {
                    Text("2")
                } .font(.largeTitle)
                    .padding()
                Button {
                    inputNumber(index:"3")
                } label: {
                    Text("3")
                } .font(.largeTitle)
                    .padding()
                
            }
            HStack{
                Button {
                    inputNumber(index:"4")
                } label: {
                    Text("4")
                } .font(.largeTitle)
                    .padding()
                Button {
                    inputNumber(index:"5")
                } label: {
                    Text("5")
                } .font(.largeTitle)
                    .padding()
                Button {
                    inputNumber(index:"6")
                } label: {
                    Text("6")
                } .font(.largeTitle)
                    .padding()
                
            }
            HStack{
                Button {
                    inputNumber(index:"7")
                } label: {
                    Text("7")
                } .font(.largeTitle)
                    .padding()
                Button {
                    inputNumber(index:"8")
                } label: {
                    Text("8")
                    .padding()
                } .font(.largeTitle)
                Button {
                    inputNumber(index:"9")
                } label: {
                    Text("9")
                    .padding()
                } .font(.largeTitle)
        }
            Button {
                inputNumber(index:"0")
            } label: {
                Text("0")
                    .padding()
            } .font(.largeTitle)
            
            
            //MARK: - 계산 버튼 기능
            HStack{
                Button {
                    forNextValue()
                    calculatorMethod = "+"
                    calculateFunction = {$0.reduce(0) { $0 + $1}}
                } label: {
                    Text("+")
                }.padding()
                    .font(.largeTitle)
                Button {
                    forNextValue()
                    calculatorMethod = "-"
                    calculateFunction = {$0.reduce(0) { $0 > $1 ? $0 - $1 : $1 - $0}
                    }
                } label: {
                    Text("-")
                }.padding()
                    .font(.largeTitle)
                Button {
                    calculatorMethod = "*"
                    forNextValue()
                } label: {
                    Text("*")
                }.padding()
                    .font(.largeTitle)
                Button {
                    calculateFunction2 = { (numbers: [Int]) in
                      var divideNumber: Int = Int(number[0])!

                      for i in 1..<number.count {
                        divideNumber /= Int(number[i])!
                      }

                      return divideNumber
                    }
                    
                    calculatorMethod = "/"
                    
                    forNextValue()
                    

                } label: {
                    Text("/")
                }.padding()
                    .font(.largeTitle)
            }
            
            Button {
                calculate(method: calculatorMethod)
            } label: {
                Text("Calculate")
            }.padding()
                .font(.largeTitle)
            Button {
                reset()
            } label: {
                Text("Reset")
            }.padding()
                .font(.largeTitle)
        }
        .padding()
    }
    
    
    //MARK: - String배열을 Int배열로 바꿔주는 function.
    func convertStringArrayToIntArray(stringArray: [String]) -> [Int] {
        var intArray = [Int]()
        for string in stringArray {
            let int = Int(string) ?? 0
            intArray.append(int)
        }
        
        return intArray
    }
    
    
    //MARK: - calculate 버튼 Function
    func calculate(method:String) {
        //먼저 String배열을 Int배열로 바꾼것을 담아준다
        let beforeCalculation = convertStringArrayToIntArray(stringArray: number)
        var result = Int()
        //calculateFunction클로저에 beforeCalculation을 담아서 reduce 고차함수(+)를 result 담는다
        if method == "+" || method == "-" {
            result = calculateFunction(beforeCalculation)
            
        } else {
            result = calculateFunction2(beforeCalculation)
            
        }
        
        //결과를 화면에 보여주기 위함
        displayLabel = String(result)
        number[0] = String(result)
        number.removeSubrange(1...count)
        count = 0
        print(number)
    }
 
    
    //MARK: - 1~9 숫자를 끊임없이 선택했을때 이어지게 만들어주는,보여주는 기능
    func inputNumber(index:String){
        
            number[count] += index
            displayLabel += index
        
    }
    
    //MARK: - + 버튼을 눌르면, 새로운 배열이 만들어지고, 이어지게 되는 것을 초기화한다,
    func forNextValue(){
    count += 1 //number[count]
    
    //⭐️
    number.append("")
    // number는 ["1","" <-이게 추가된다]
    //처음에 number의 초기값은 [""] , 곧 1개 밖에 없었는데, number[1] = "" 하게 되면, number[1]이 없기 때문에 오류가 뜬다.
    // ⭐️문제 해결을 위해  number.append("")로 기본배열 추가 및 값을 넣어주었다.
    displayLabel = ""

    }
    
    
    func reset(){
        
        number.removeSubrange(0...count)
        // 리셋의 범위를 다 삭제해야한다. number[count]만큼의 배열이 있으니 count 만큼의 범위를 삭제
     
        number.append("")
        //삭제 해주면 결국 ⭐️와 같은 문제가 일어나기 때문에 새로운 기본배열을 추가 및 값을 넣어주었다
      
        displayLabel = ""
      
        count = 0
        //count를 0으로 초기화 해줘야 number[count] 올바르게 작동함
 

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
