//
//  DebounceTextField.swift
//  WhichBin
//
//  Created by Shane Whitehead on 22/4/2025.
//

import SwiftUI
import Combine

struct DebounceTextField: View {

    @State var publisher = PassthroughSubject<String, Never>()

    @State var label: String
    @Binding var value: String
    var valueChanged: ((_ value: String) -> Void)?

    @State var debounceSeconds = 1.110

    init(_ label: String, text: Binding<String>, valueChange: ((_ value: String) -> Void)?) {
        self.label = label
        self._value = text
        self.valueChanged = valueChange
    }

    var body: some View {
        TextField(label, text: $value,  axis: .vertical)
            .disableAutocorrection(true)
            .onChange(of: value, { oldValue, newValue in
                publisher.send(newValue)
            })
            .onReceive(
                publisher.debounce(
                    for: .seconds(debounceSeconds),
                    scheduler: DispatchQueue.main
                )
            ) { value in
                if let valueChanged = valueChanged {
                    valueChanged(value)
                }
            }
    }
}
