import Error "mo:base/Error";
import Result "mo:base/Result";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";
import Option "mo:base/Option";
import Array "mo:base/Array";

import State "../game_demo_models/State";
import Types "../game_demo_models/Types";
import GeneralUtils "./utils/general";

actor {
  var state : State.State = State.empty();
  private stable var users : [(Text,Types.User)] = [];
  private stable var inventories : [(Text,Types.Inventory)] = [];
  private stable var characters : [(Text,Types.Character)] = [];
  private stable var characterClasses : [(Text,Types.CharacterClass)] = [];

  system func preupgrade() {
    Debug.print("Begin preupgrade");
    users := Iter.toArray(state.users.entries());
    inventories := Iter.toArray(state.inventories.entries());
    characters := Iter.toArray(state.characters.entries());
    characterClasses := Iter.toArray(state.characterClasses.entries());
  };

  system func postupgrade() {
    Debug.print("Begin postupgrade");
    for ((k, v) in Iter.fromArray(users)) {
      state.users.put(k, v);
    };
    for ((k, v) in Iter.fromArray(inventories)) {
      state.inventories.put(k, v);
    };
    for ((k, v) in Iter.fromArray(characters)) {
      state.characters.put(k, v);
    };
    for ((k, v) in Iter.fromArray(characterClasses)) {
      state.characterClasses.put(k, v);
    };
  };

  type Response<Ok> = Result.Result<Ok, Types.Error>;

  // Character Class
  public shared({caller}) func createCharacterClass(characterClass : Types.CharacterClass) : async Response<Text> {
    let uuid = await GeneralUtils.createUUID();
    let readCharacterClass = state.characterClasses.get(uuid); 
    switch (readCharacterClass) {
      case (?V) { #err(#AlreadyExisting); };
      case null {
        let newCharacterClass : Types.CharacterClass = {
          uuid = ?uuid;
          name = characterClass.name;
          specialAbility = characterClass.specialAbility;
          description = characterClass.description;
          baseMana = characterClass.baseMana;
          baseHp = characterClass.baseHp;
          baseMorale = characterClass.baseMorale;
          baseStamina = characterClass.baseStamina;
        };
        let createdCharacterClass = state.characterClasses.put(uuid, newCharacterClass);
        #ok("Success");
      };
    };
  };

  public shared query({caller}) func listCharacterClasses() : async Response<[(Text, Types.CharacterClass)]> {
    var list : [(Text, Types.CharacterClass)] = [];
    if(Principal.toText(caller) == "2vxsx-fae") {
      throw Error.reject("NotAuthorized");  //isNotAuthorized
    };

    for((K,V) in state.characterClasses.entries()) {
      list := Array.append<(Text, Types.CharacterClass)>(list, [(K, V)]);
    };
    #ok((list));
  };

  // Character
  public shared({caller}) func createCharacter(characterClassId : Text, character : Types.Character) : async Response<Text> {
    let uuid = await GeneralUtils.createUUID();
    let readCharacterClass = state.characterClasses.get(characterClassId);
    let readCharacter = state.characters.get(uuid);
    switch (readCharacter) {
      case (?V) { #err(#AlreadyExisting); };
      case (null) {
        switch (readCharacterClass) {
          case null { #err(#NotFound) };
          case (?characterClass) {
            let newCharacter : Types.Character = {
              uuid = uuid;
              name = character.name;
              level = 1;
              experience = 0;
              status : ?Text = Option.get(null, ?"");
              strength : ?Int = Option.get(null, ?0);
              currentMana = characterClass.baseMana;
              maxMana = characterClass.baseMana;
              currentStamina = characterClass.baseStamina;
              maxStamina = characterClass.baseStamina;
              currentMorale = characterClass.baseMorale;
              maxMorale = characterClass.baseMorale;
              currentHp = characterClass.baseHp;
              maxHp = characterClass.baseHp;
              luck = 0;
              intelligent = 0;
              vitality = 0;
              classId = characterClass.uuid;
              gearIds : ?[Text] = Option.get(null, ?[]);
            };
            let createdCharacter = state.characters.put(uuid, newCharacter);
            #ok("Success");
          };
        };
      };
    };
  };

  public shared({caller}) func updateCharacter(character : Types.Character) : async Response<Text> {
    let readCharacter = state.characters.get(character.uuid);
    switch (readCharacter) {
      case null {
        #err(#NotFound);
      };
      case (?character) {
        let newCharacter : Types.Character = {
          uuid = character.uuid;
          name = character.name;
          level = character.level;
          experience = character.experience;
          status = character.status;
          strength = character.strength;
          currentMana = character.currentMana;
          maxMana = character.maxMana;
          currentStamina = character.currentStamina;
          maxStamina = character.maxStamina;
          currentMorale = character.currentMorale;
          maxMorale = character.maxMorale;
          currentHp = character.currentHp;
          maxHp = character.maxHp;
          luck = character.luck;
          intelligent = character.intelligent;
          vitality = character.vitality;
          classId = ?character.uuid;
          gearIds = character.gearIds;
        };
        let updatedCharacter = state.characters.replace(character.uuid, newCharacter);
        #ok("Success");
      };
    };
  };
};
