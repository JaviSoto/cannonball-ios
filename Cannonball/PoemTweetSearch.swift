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

import TwitterKit

private let TwitterAPISearchURL = "https://api.twitter.com/1.1/search/tweets.json"
private let TwitterAPISearchHTTPMethod = "GET"
private let PoemSearchQuery = "#cannonballapp AND pic.twitter.com AND (#adventure OR #romance OR #nature OR #mystery)"

private let PoemSearchParameters: Dictionary<String, String> =
    [  "q" : PoemSearchQuery,
        "count": "50"
    ]

extension TWTRAPIClient {
    // Search for poems on Twitter.
    func searchPoemTweets(completion: [TWTRTweet] -> ()) {
        Twitter.sharedInstance().logInGuestWithCompletion { guestSession, error in
            var error: NSError?
            if let request = self.URLRequestWithMethod(TwitterAPISearchHTTPMethod, URL: TwitterAPISearchURL, parameters: PoemSearchParameters, error: &error) {
                self.sendTwitterRequest(request) { response, data, error in
                    if error != nil {
                        println("Request failed with error: \(error)")
                        completion([])
                    } else {
                        let tweets = tweetsFromJSONData(data) ?? []

                        println("Retrieved \(countElements(tweets)) tweets")

                        completion(tweets)
                    }
                }
            }
            else {
                println("Error creating request: \(error)")
                completion([])
            }
        }
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
    let tweetDictionaries = tweetsDictionary["statuses"] as? [AnyObject]
    return tweetDictionaries.map { return TWTRTweet.tweetsWithJSONArray($0) as [TWTRTweet] } ?? []
}

private func tweetsFromJSONData(jsonData: NSData) -> [TWTRTweet]? {
    return JSONDictionaryFromData(jsonData).map { tweetsDictionary in
        return tweetsFromTwitterResponseDictionary(tweetsDictionary)
    }
}
