//
//  ContentView.swift
//  SwiftUITest
//
//  Created by Alexei Jovmir on 6/12/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        HStack {
            VStack {
                TextField("0.0", text: $viewModel.stringValueInput)
                    .fixedSize()
                    .keyboardType(.decimalPad)
                Button {
                    viewModel.convert()
                } label: {
                    Text("Convert")
                }
                Text(viewModel.stringValueResult)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(.green)
            VStack {
                Image(viewModel.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
//                    .foregroundStyle(.tint)
                    .padding()
                Slider(
                    value: $viewModel.sliderValue,
                    in: 0...100
                ).allowsHitTesting(false)
                    .padding()

            }.padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(.red)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
//        .background(.yellow)
        .padding()
    }
    


}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}


public class ViewModel: ObservableObject {
    @Published var stringValueResult: String = ""
    @Published var stringValueInput: String = ""
    @Published var sliderValue: Double = 50.0
    @Published var imageName: String = "20dollars"

    enum ConversionType {
        case metersToFeet
        case feetToMeters
    }
    
    public func convert() {
        if let double = Double(stringValueInput) {
            let feet = convert(length: double, type: .metersToFeet)
            stringValueResult = String(feet)
            
            if double > 0, double <= 4 {
                imageName = "visa"
                sliderValue = calculatePercentage(input: double, minValue: 0, maxValue: 4) ?? 0.0
            } else if double > 4, double < 10 {
                imageName = "20dollars"
                sliderValue = calculatePercentage(input: double, minValue: 4, maxValue: 10) ?? 0.0
            }
        }
      
    }

   private func convert(length: Double, type: ConversionType) -> Double {
        switch type {
        case .metersToFeet:
            return length * 3.28084
        case .feetToMeters:
            return length / 3.28084
        }
    }
    
    private func calculatePercentage(input: Double, minValue: Double, maxValue: Double) -> Double? {
        // Ensure that the minValue is less than maxValue to avoid division by zero
        guard minValue < maxValue else {
            return nil
        }

        // Ensure that the input is within the specified range
        guard input >= minValue && input <= maxValue else {
            return nil
        }

        // Calculate the percentage
        let percentage = ((input - minValue) / (maxValue - minValue)) * 100.0

        return percentage
    }


}

