//
// Copyright (C) 2014 Twitter, Inc. and other contributors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//         http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation

// TODO: Delete. Just stubs to make the project compile before we import TwitterKit
struct TWTRTweet {

}
struct TWTRAPIClient {

}

private let TwitterAPISearchURL = "https://api.twitter.com/1.1/search/tweets.json"
private let TwitterAPISearchHTTPMethod = "GET"
private let PoemSearchQuery = "#cannonballapp AND pic.twitter.com AND (#adventure OR #romance OR #nature OR #mystery)"

private let PoemSearchParameters: Dictionary<String, String> =
    [  "q" : PoemSearchQuery,
        "count": "50"
    ]

extension TWTRAPIClient {
    // Search for poems on Twitter.
    func searchPoemTweets(completion: [TWTRTweet]? -> ()) {
        completion(nil)
    }
}

private func JSONDictionaryFromData(JSONData: NSData) -> [String: AnyObject]? {
    var JSONError: NSError?
    if let JSONDictionary = NSJSONSerialization.JSONObjectWithData(JSONData, options: .allZeros, error: &JSONError) as? [String: AnyObject] {
        return JSONDictionary
    } else {
        println("Error parsing JSON Dictionary: \(JSONError!)")
        return nil
    }
}

private func tweetsFromTwitterResponseDictionary(tweetsDictionary: [String: AnyObject]) -> [TWTRTweet] {
    return []
}

private func tweetsFromJSONData(jsonData: NSData) -> [TWTRTweet]? {
    return JSONDictionaryFromData(jsonData).map { tweetsDictionary in
        return tweetsFromTwitterResponseDictionary(tweetsDictionary)
    }
}
