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

import UIKit

import Fabric
import Crashlytics
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        Fabric.with([Crashlytics(), Twitter()])

        if Twitter.sharedInstance().session() == nil {
            showSignInController()
        }

        return true
    }

    func showSignInController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signInViewController: AnyObject! = storyboard.instantiateViewControllerWithIdentifier("SignInViewController")
        self.window?.rootViewController = signInViewController as? UIViewController
    }

}
