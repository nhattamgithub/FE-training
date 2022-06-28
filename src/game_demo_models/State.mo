import Text "mo:base/Text";
import TrieMap "mo:base/TrieMap";

import Types "Types";

module {
  private type Map<K,V> = TrieMap.TrieMap<K,V>;
  public type State = {
    users : Map<Text,Types.User>;
    inventories : Map<Text,Types.Inventory>;
    characters : Map<Text,Types.Character>;
    characterClasses : Map<Text,Types.CharacterClass>;
    gears : Map<Text,Types.Gear>;
    gearClasses : Map<Text,Types.GearClass>;
    gearRarities : Map<Text, Types.GearRarity>;
    substats : Map<Text, Types.Substat>;
    materials : Map<Text, Types.Material>;
    quests : Map<Text, Types.Quest>;
    events : Map<Text, Types.Event>;
    items : Map<Text, Types.Item>;
    lossDetails : Map<Text, Types.LossDetail>;
    gainDetails : Map<Text, Types.GainDetail>;
  };

  public func empty() : State {
    {
      users = TrieMap.TrieMap<Text,Types.User>(Text.equal,Text.hash);
      inventories = TrieMap.TrieMap<Text,Types.Inventory>(Text.equal, Text.hash);
      characters = TrieMap.TrieMap<Text,Types.Character>(Text.equal,Text.hash);
      characterClasses = TrieMap.TrieMap<Text,Types.CharacterClass>(Text.equal,Text.hash);
      gears = TrieMap.TrieMap<Text,Types.Gear>(Text.equal,Text.hash);
      gearClasses = TrieMap.TrieMap<Text,Types.GearClass>(Text.equal,Text.hash);
      gearRarities = TrieMap.TrieMap<Text, Types.GearRarity>(Text.equal, Text.hash);
      substats = TrieMap.TrieMap<Text, Types.Substat>(Text.equal, Text.hash);
      materials = TrieMap.TrieMap<Text, Types.Material>(Text.equal, Text.hash);
      quests = TrieMap.TrieMap<Text, Types.Quest>(Text.equal, Text.hash);
      events = TrieMap.TrieMap<Text, Types.Event>(Text.equal, Text.hash);
      items = TrieMap.TrieMap<Text, Types.Item>(Text.equal, Text.hash);
      lossDetails = TrieMap.TrieMap<Text, Types.LossDetail>(Text.equal, Text.hash);
      gainDetails = TrieMap.TrieMap<Text, Types.GainDetail>(Text.equal, Text.hash);
    };
  };
};