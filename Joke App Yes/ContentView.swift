//
//  ContentView.swift
//  Joke App Yes
//
//  Created by James on 29/6/24.
//

import SwiftUI

struct Joke {
    var setup: String
    var punchline: String
}

struct ContentView: View {
    var jokes = [
        Joke(setup: "Why couldn't the Little Tristan get on the bus", punchline: "Because he had a level 10 gyatt"),
        Joke(setup: "Why couldn't Little Tristan get any girls", punchline: "He was too short"),
        Joke(setup: "What is Little Tristan favourite present from his aunt", punchline: "Screws"),
        Joke(setup: "What is the difference between Tristan and a large pizza", punchline: "One can feed a family"),
        Joke(setup: "Dad, can you put my shoes on?", punchline: "I don’t think they'll fit me")
    ]
    
    @State private var currentJokeIndex = 0
    @State private var showPunchline = false
    @State private var likedJokes = Set<Int>()
    
    // State to track whether each joke's like and dislike button is clicked
    @State private var liked = false
    @State private var disliked = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text(jokes[currentJokeIndex].setup)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top, geometry.safeAreaInsets.top + 20)
                        .frame(maxWidth: .infinity)
                    
                    Button(action: {
                        withAnimation {
                            showPunchline.toggle()
                        }
                    }) {
                        Text(showPunchline ? "Quick! Hide your gyatt!" : "Urm what the sigma?")
                            .padding()
                            .frame(maxWidth: 250)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .font(.headline)
                            .shadow(radius: 5)
                    }
                    
                    if showPunchline {
                        Text(jokes[currentJokeIndex].punchline)
                            .font(.title3)
                            .padding()
                            .transition(.slide)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            handleLike()
                        }) {
                            Image(systemName: likedJokes.contains(currentJokeIndex) ? "hand.thumbsup.fill" : "hand.thumbsup")
                                .font(.title)
                                .foregroundColor(liked ? .green : .primary)
                                .padding()
                                .background(liked ? Color.green.opacity(0.2) : Color.clear)
                                .cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .onTapGesture {
                            liked.toggle()
                        }
                        
                        Button(action: {
                            handleDislike()
                        }) {
                            Image(systemName: likedJokes.contains(currentJokeIndex) ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                                .font(.title)
                                .foregroundColor(disliked ? .red : .primary)
                                .padding()
                                .background(disliked ? Color.red.opacity(0.2) : Color.clear)
                                .cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .onTapGesture {
                            disliked.toggle()
                        }
                        
                        Button(action: {
                            showNextJoke()
                        }) {
                            Image(systemName: "arrow.forward")
                                .font(.title)
                                .foregroundColor(.blue)
                                .padding()
                        }
                    }
                    .padding(.bottom, geometry.safeAreaInsets.bottom + 20)
                }
                .padding(.horizontal)
            }
        }
    }
    
    private func handleLike() {
        if likedJokes.contains(currentJokeIndex) {
            likedJokes.remove(currentJokeIndex)
        } else {
            likedJokes.insert(currentJokeIndex)
            // Add your reward logic here (e.g., increment a score, show a reward message)
            print("You liked this joke! 🎉")
        }
    }
    
    private func handleDislike() {
        if likedJokes.contains(currentJokeIndex) {
            likedJokes.remove(currentJokeIndex)
            print("You disliked this joke! 😞")
        } else {
            likedJokes.insert(currentJokeIndex)
        }
    }
    
    private func showNextJoke() {
        withAnimation {
            currentJokeIndex = (currentJokeIndex + 1) % jokes.count
            showPunchline = false
            liked = false
            disliked = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
