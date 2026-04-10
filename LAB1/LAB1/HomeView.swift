//
//  HomeView.swift
//  LAB1
//
//  Created by zenanchang on 1/25/26.
//


//
//  homeView.swift
//  LAB1
//  Home Page As requested, the lab is divided into Part 1 and Part 2.
//  Created by zenanchang on 1/25/26.
//
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {

                Text("CSE 335 - Lab 1")
                    .font(.title)

                NavigationLink("Lab 1 - Part 1") {
                    Part1()   
                }

                NavigationLink("Lab 1 - Part 2") {
                       Part2()
                }
            }
            .padding()
        }
    }
}
