//
//  StocksMenuBarApp.swift
//  StocksMenuBar
//
//  Created by Mohammad Azam on 4/24/22.
//

import SwiftUI

@main
struct StocksMenuBarApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView(vm: StockListViewModel())
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    
    private var stockListVM: StockListViewModel!
    
    @MainActor func applicationDidFinishLaunching(_ notification: Notification) {
        
        self.stockListVM = StockListViewModel()
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(systemSymbolName: "chart.line.uptrend.xyaxis.circle", accessibilityDescription: "Chart Line")
            statusButton.action = #selector(togglePopover)
        }
        
        self.popover = NSPopover()
        self.popover.contentSize = NSSize(width: 300, height: 300)
        self.popover.behavior = .transient
        self.popover.contentViewController = NSHostingController(rootView: ContentView(vm: self.stockListVM))
    }
    
    @objc func togglePopover() {
        
        Task {
            await self.stockListVM.populateStocks()
        }
        
        if let button = statusItem.button {
            if popover.isShown {
                self.popover.performClose(nil)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
        
    }
    
}
