#!/usr/bin/env swift

import AppKit
import Foundation
import UniformTypeIdentifiers

let fileTypes = [
    // This one is unusual in that we probably
    // are fine with Apple's basic unarchival handling
    // zip / tar / gzip, etc.
    "archive": [
        // Base Type
        UTType.archive,
    ],
    "movie": [
        // Base Types
        UTType.audio,
        UTType.audiovisualContent,
        UTType.movie,
        UTType.video,
        // Audio
        UTType.aiff,
        UTType.mp3,
        UTType.wav,
        UTType.playlist,
        UTType.m3uPlaylist,
        // Audio & Video
        UTType.quickTimeMovie,
        UTType.mpeg,
        UTType.mpeg2Video,
        UTType.mpeg2TransportStream,
        UTType.mpeg4Movie,
        UTType.mpeg4Audio,
        UTType.avi,
    ],
    "text": [
        // Base Type
        UTType.sourceCode,
        // Compiled Source
        UTType.assemblyLanguageSource,
        UTType.cHeader,
        UTType.cSource,
        UTType.cPlusPlusHeader,
        UTType.cPlusPlusSource,
        UTType.objectiveCPlusPlusSource,
        UTType.objectiveCSource,
        UTType.swiftSource,
        // Text readable Source
        UTType.yaml,
        UTType.xml,
        UTType.json,
        UTType.html,
        UTType.xmlPropertyList,
        UTType.script,
        UTType.appleScript,
        UTType.javaScript,
        UTType.osaScript,
        UTType.osaScriptBundle,
        UTType.makefile,
        UTType.shellScript,
        UTType.pythonScript,
        UTType.rubyScript,
        UTType.perlScript,
        UTType.phpScript,
        UTType.text,
        UTType.plainText,
        UTType.log
    ],
]

let ws = NSWorkspace.shared

let category = CommandLine.arguments[1]

if !fileTypes.keys.contains(category) {
    print(category, " is not supported")
    print("Supported categories: ", fileTypes.keys)
}

let appPath = URL(fileURLWithPath: CommandLine.arguments[2])

for fileType in fileTypes[category]! {
    ws.setDefaultApplication(at: appPath, toOpen: fileType)

    let newDefault = ws.urlForApplication(toOpen: fileType)!.path

    if(newDefault == appPath.path) {
        print(String(format: "%30@ [%-8@]", fileType.identifier, "SUCCESS"))
    } else {
        print(String(format: "%30@ [%-8@]", fileType.identifier, "FAIL"))
        print(newDefault)
    }
}
