//
//  Printer.swift
//  kultButler
//
//  Created by Valentin Langer on 26.05.21.
//

import Foundation
import CoreBluetooth


func connectPrinter() {
    let printer = PrinterSDK.default()!
    printer.scanPrinters(completion: { foundPrinter in
        print(foundPrinter?.name)
        printer.stopScanPrinters()
        printer.connectBT(foundPrinter!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0){
            print("Start Test")
            printer.printText("Test")
        }
    })
}

