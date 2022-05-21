import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank { //creates a new canister
  stable var currentValue: Float = 300; //now orthogonally persisted variable
  // currentValue := 300; //changes currentValue
  Debug.print(debug_show(currentValue));

  stable var startTime = Time.now();
  startTime := Time.now();
  Debug.print(debug_show(startTime));

  let id = 3290424253; //cannot change this later on
  // Debug.print(debug_show(id));

  public func topUp(amount: Float) {
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  public func withdraw(amount: Float) {
    let tempValue: Float = currentValue - amount;
    if (tempValue >= 0) {
    currentValue -= amount;
    Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Invalid withdraw");
    }
  };

  public query func checkBalance(): async Float {
    return currentValue; //read only operation
  };
  
  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS / 1000000000; //time elapsded convered from nanoseconds to seconds
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
    startTime := currentTime;
  };
}