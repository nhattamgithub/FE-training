import Error "mo:base/Error";
import Result "mo:base/Result";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";
import Option "mo:base/Option";
import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Int "mo:base/Int";

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

  // Game
  // Character Class
  public shared({caller}) func createCharacterClass(characterClass : Types.CharacterClass) : async Response<Text> {
    // if(Principal.toText(caller) == "2vxsx-fae") {
    //   return #err(#NotAuthorized);//isNotAuthorized
    // };
    // let uuid : Text = await GeneralUtils.createUUID();
    let uuid = state.characterClasses.size() + 1;
    let readCharacterClass = state.characterClasses.get(Nat.toText(uuid)); 
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
        let createdCharacterClass = state.characterClasses.put(Nat.toText(uuid), newCharacterClass);
        #ok("Success");
      };
    };
  };

  public shared query({caller}) func listCharacterClasses() : async Response<[(Text, Types.CharacterClass)]> {
    var list : [(Text, Types.CharacterClass)] = [];
    // if(Principal.toText(caller) == "2vxsx-fae") {
    //   return #err(#NotAuthorized);//isNotAuthorized
    // };

    for((K,V) in state.characterClasses.entries()) {
      list := Array.append<(Text, Types.CharacterClass)>(list, [(K, V)]);
    };
    #ok((list));
  };

  // Character
  public shared({caller}) func createCharacter(characterClassId : Text, characterName : Text) : async Response<Text> {
    // if(Principal.toText(caller) == "2vxsx-fae") {
    //   return #err(#NotAuthorized);//isNotAuthorized
    // };
    // let uuid : Text = await GeneralUtils.createUUID();
    let uuid = state.characters.size() + 1;
    let readCharacterClass = state.characterClasses.get(characterClassId);
    let readCharacter = state.characters.get(Nat.toText(uuid));
    switch (readCharacter) {
      case (?V) { #err(#AlreadyExisting); };
      case (null) {
        switch (readCharacterClass) {
          case null { #err(#NotFound) };
          case (?characterClass) {
            let newCharacter : Types.Character = {
              uuid = ?uuid;
              name = characterName;
              level = 1;
              currentExp = 0;
              lvlUpExp = 100;
              currentMana = characterClass.baseMana;
              maxMana = characterClass.baseMana;
              currentStamina = characterClass.baseStamina;
              maxStamina = characterClass.baseStamina;
              currentMorale = characterClass.baseMorale;
              maxMorale = characterClass.baseMorale;
              currentHp = characterClass.baseHp;
              maxHp = characterClass.baseHp;
              strength = 6;
              luck = 0;
              intelligent = 0;
              vitality = 0;
              classId = characterClass.uuid;
              gearIds : ?[Text] = Option.get(null, ?[]);
              materialIds : ?[Text] = Option.get(null, ?[]);
            };
            let createdCharacter = state.characters.put(Nat.toText(uuid), newCharacter);
            #ok("Success");
          };
        };
      };
    };
  };

  public shared query({caller}) func listCharacters() : async Response<[(Text, Types.Character)]> {
    var list : [(Text, Types.Character)] = [];
    // if(Principal.toText(caller) == "2vxsx-fae") {
    //   return #err(#NotAuthorized);//isNotAuthorized
    // };

    for((K,V) in state.characters.entries()) {
      list := Array.append<(Text, Types.Character)>(list, [(K, V)]);
    };
    #ok((list));
  };
  
  public shared({caller}) func updateCharacter(characterId : Int, manaLoss : Int, staminaLoss : Int, hpLoss : Int, moraleLoss : Int) : async Response<Text> {
    // if(Principal.toText(caller) == "2vxsx-fae") {
    //   return #err(#NotAuthorized);//isNotAuthorized
    // };
    let readCharacter = state.characters.get(Int.toText(characterId));
    switch (readCharacter) {
      case null {
        #err(#NotFound);
      };
      case (?character) {
        let newCharacter : Types.Character = {
          uuid = ?characterId;
          name = character.name;
          level = character.level;
          currentExp = character.currentExp;
          lvlUpExp = character.lvlUpExp;
          currentMana = character.currentMana - manaLoss;
          maxMana = character.maxMana;
          currentStamina = character.currentStamina - staminaLoss;
          maxStamina = character.maxStamina;
          currentMorale = character.currentMorale - moraleLoss;
          maxMorale = character.maxMorale;
          currentHp = character.currentHp - hpLoss;
          maxHp = character.maxHp;
          strength = character.strength;
          luck = character.luck;
          intelligent = character.intelligent;
          vitality = character.vitality;
          classId = character.classId;
          gearIds = character.gearIds;
          materialIds = character.materialIds;
        };
        let updatedCharacter = state.characters.replace(Int.toText(characterId), newCharacter);
        #ok("Success");
      };
    };
  };
};
