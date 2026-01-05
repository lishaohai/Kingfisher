//
//  TrojanImageTests.swift
//  Kingfisher
//
//  Created by Kingfisher Test Suite
//
//  Copyright (c) 2026 Wei Wang <onevcat@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import XCTest
@testable import Kingfisher

class TrojanImageTests: XCTestCase {
    
    // Test handling of malformed/corrupted image data (trojan-like scenarios)
    func testInvalidImageDataHandling() {
        // Create invalid image data
        let invalidData = Data([0x00, 0x01, 0x02, 0x03, 0x04])
        
        // Attempt to create an image from invalid data
        let image = KFCrossPlatformImage(data: invalidData)
        
        // Should return nil for invalid data
        XCTAssertNil(image, "Image should be nil when created from invalid data")
    }
    
    // Test handling of empty data
    func testEmptyImageDataHandling() {
        let emptyData = Data()
        let image = KFCrossPlatformImage(data: emptyData)
        XCTAssertNil(image, "Image should be nil when created from empty data")
    }
    
    // Test handling of truncated PNG data
    func testTruncatedPNGData() {
        // PNG header only, no actual image data
        let truncatedPNG = Data([0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A])
        let image = KFCrossPlatformImage(data: truncatedPNG)
        XCTAssertNil(image, "Image should be nil when created from truncated PNG data")
    }
    
    // Test handling of data with wrong format identifier
    func testWrongFormatIdentifier() {
        // Data claiming to be PNG but isn't
        let fakeData = Data([0xFF, 0xD8, 0xFF]) // JPEG header with incomplete data
        let image = KFCrossPlatformImage(data: fakeData)
        XCTAssertNil(image, "Image should be nil when created from incomplete JPEG data")
    }
}
