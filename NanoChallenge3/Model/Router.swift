//
//  Router.swift
//  NanoChallenge3
//
//  Created by Muhammad Rasyad Caesarardhi on 10/07/24.
//

import SwiftUI

// class ini dibuat untuk melakukan direct routing ke page view tertentu
class Router: ObservableObject {
    @Published var path: [Destination] = []

//    untuk menambahkan page view yang bisa diroute langsung,
//      1. edit destination di bawah ini, tambahkan destination string baru seperti contoh di bawah
//      2. akan muncul error di file Routes/RouterView (langsung tambahkan di sana) ingin page apa yang ditampilkan jika enum String seperti SplashScreen ini dimunculkan
    enum Destination: String, Hashable {
        case Home, Calendar, StartJournaling, AnxietyJournal, PreparationJournaling, ReflectionJournaling
    }

    static let shared: Router = .init()

    // How to use:
    // cara pindah page
    // Router.shared.path.append(.SplashScreen)

    // cara kembali ke page sebelumnya
    // Router.shared.path.popLast()

    // cara kembali ke root home
    // Router.shared.path.removeAll()
}
