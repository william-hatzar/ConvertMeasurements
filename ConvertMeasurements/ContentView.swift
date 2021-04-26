import SwiftUI

struct ContentView: View {
    @State private var inputNumber = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 0

    let inputUnits = ["Millimeters", "Centimeters", "Meters", "Kilometers"]
    let outputUnits = ["Inches", "Feet", "Yards", "Miles"]

    //  Convert the user’s input to a single base unit (millimeters).
    var metricConversion: Double {
        let metric = Double(inputNumber) ?? 0

        switch inputUnit {
        case 0:
            return metric
        case 1:
            return metric * 10
        case 2:
            return metric * 1000
        case 3:
            return metric * 1_000_000
        default:
            return 0
        }
    }

    //  Convert base unit into relevant imperial measurement.
    var imperialConversion: Measurement<UnitLength> {
        let imperial = metricConversion
        let distance = Measurement(value: imperial, unit: UnitLength.millimeters)
        let inches = distance.converted(to: UnitLength.inches)
        let feet = distance.converted(to: UnitLength.feet)
        let yards = distance.converted(to: UnitLength.yards)
        let miles = distance.converted(to: UnitLength.miles)

        switch outputUnit {
        case 0:
            return inches
        case 1:
            return feet
        case 2:
            return yards
        case 3:
            return miles
        default:
            return distance
        }
    }

    var body: some View {
        NavigationView {

            Form {
                Section(header: Text("Metric Number")) {
                    TextField("Input Number Here", text: $inputNumber)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("Imperial Number")) {
                    Text("\(imperialConversion.description)")
                }

                Section(header: Text("Select Input Unit")) {
                    Picker("Input", selection: $inputUnit) {

                        //  Use a ForEach to count through all the options in the the array, converting each one into a text view.
                        ForEach(0 ..< inputUnits.count) {
                            Text("\(self.inputUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Select Output Unit")) {
                    Picker("Input", selection: $outputUnit) {

                        //  Use a ForEach to count through all the options in the array, converting each one into a text view.
                        ForEach(0 ..< outputUnits.count) {
                            Text("\(self.outputUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Measurement Converter", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
