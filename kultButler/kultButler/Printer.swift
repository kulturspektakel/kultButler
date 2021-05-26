//
//  Printer.swift
//  kultButler
//
//  Created by Valentin Langer on 26.05.21.
//

import Foundation
import CoreBluetooth

let printer = PrinterSDK.default()!

func connectPrinter() -> Bool {
    printer.scanPrinters(completion: { foundPrinter in
        print(foundPrinter?.name)
        printer.connectBT(foundPrinter)
    })
    sleep(10)
    print("Drucker verbunden")
    return true
}

func printOrder(bestellung: Bestellung) {
    printer.setFontSizeMultiple(1)
    printer.printText("Bestellung: " + bestellung.id)
    printer.setFontSizeMultiple(4)
    printer.printText("Bestellung: " + bestellung.inhalt)
}

func printTest(testText: String) {
    printer.setFontSizeMultiple(4)
    printer.printText(testText)
}

struct Bestellung {
    let id: String
    let inhalt: String
}

/*
let b1 = Bestellung(id: "50", inhalt: "Burger \nNix \nPommes")
printPrinter(bestellung: b1)*/
