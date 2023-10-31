import UIKit

func delayAfter(_ howTime: Double, execute: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + howTime, execute: execute)
}

func deferDelayAfter(execute: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: execute)
}
