//
//  ContentView.swift
//  SwiftUITest
//
//  Created by Alexei Jovmir on 6/12/23.
//

import TokamakShim
import Foundation

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        HStack {
            VStack {
                Text("centimeter to inches")
                TextField("0.0", text: $viewModel.stringValueInput)
//                    .fixedSize()
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
                    .frame(width: 133, height: 100)
                Slider(
                    value: $viewModel.sliderValue,
                    in: 0...100
                )

//                .allowsHitTesting(false)
                .frame(width: 133)
                if !viewModel.stringValueInput.isEmpty {
                    Text("\(viewModel.stringValueInput)cm relative to image above")
                }

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
    @Published var imageName: String = "20dollars.jpeg"

    enum ConversionType {
        case cmToInches
        case feetToMeters
    }
    
    public func convert() {
        if let double = Double(stringValueInput) {
            let feet = convert(length: double, type: .cmToInches)
            stringValueResult = String(feet) + " feet"
            
            if double > 0, double <= 8.56 {
                imageName = "visa.png"
                sliderValue = calculatePercentage(input: double, minValue: 0, maxValue: 8.56) ?? 0.0
            } else if double > 8.56, double < 15.6 {
                imageName = "20dollars.jpeg"
                sliderValue = calculatePercentage(input: double, minValue: 8.56, maxValue: 15.6) ?? 0.0
            }
        }
      
    }

   private func convert(length: Double, type: ConversionType) -> Double {
        switch type {
        case .cmToInches:
            return length * 0.393701
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

