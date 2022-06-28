import Random "mo:base/Random";
import Float "mo:base/Float";
import Nat8 "mo:base/Nat8";
import UUID "mo:uuid/UUID";
import AsyncSource "mo:uuid/async/SourceV4";

module GeneralUtils {
  public func createUUID() : async Text {
    var ae = AsyncSource.Source();
    let id = await ae.new();
    UUID.toText(id);
  };
}