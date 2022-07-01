module {
  public type Error = {
    #NotFound;
    #AlreadyExisting;
    #NotAuthorized;
  };

  public type User = {
    uid : Text;
    name : Text;
    password : Text;
    inventoryId : Text;
  };

  public type Inventory = {
    uuid : Text;
    name : Text;
    size : Int;
  };

  //--------------------- Character ---------------------//
  public type Character = {
    uuid : ?Int;
    name : Text;
    level : Int;
    currentExp : Int;
    lvlUpExp : Int;
    currentMana : Int;
    maxMana : Int;
    currentStamina : Int;
    maxStamina : Int;
    currentMorale : Int;
    maxMorale : Int;
    currentHp : Int;
    maxHp : Int;
    strength : Int;
    luck : Int;
    intelligent : Int;
    vitality : Int;
    classId : ?Int;
    gearIds : ?[Text];
    materialIds : ?[Text];
  };

  public type CharacterClass = {
    uuid : ?Int;
    name : Text;
    specialAbility : Text;
    description : Text;
    // characterIds : [Text]; 
    baseMana : Int;
    baseStamina : Int;
    baseMorale : Int;
    baseHp : Int;
  };

  //--------------------- Gear ---------------------//
  public type Gear = {
    uuid : Text;
    name : Text;
    description : Text;
    image : Text;
  };

  public type GearClass = {
    uuid : Text;
    name : Text;
    description : Text;
    mainStat : Int;
    gearIds : ?[Text];
  };

  public type GearRarity = {
    uuid : Text;
    name : Text;
    description : Text;
    boxColor : Text;  
    gearIds : ?[Text];
  };

  //--------------------- Substat ---------------------//
  public type Substat = {
    uuid : Text;
    substat : Int;
    description : Text;
    gearIds : ?[Text];
  };

  //--------------------- Material ---------------------//
  public type Material = {
    uuid : Text;
    name : Text;
    description : Text;
    gearIds : ?[Text];
  };  

  //--------------------- Quest ---------------------//
  public type Quest = {
    uuid : Text;
    name : Text;
    description : Text;
    image : Text;
    gearIds : ?[Text];
  };

  //--------------------- Event ---------------------//
  public type Event = {
    uuid : Text;
    description : Text;
    currentLocation : Text;
    destination : Text;
    requireItemIds : ?[Text];
    imagesLinks : Text;
    questIds : ?[Text];
    lossDetailIds : ?[Text];
    gainDetailIds : ?[Text];
  };

  //--------------------- Item ---------------------//
  public type Item = {
    uuid : Text;
    name : Text;
    description : Text;
  };  

  //--------------------- Loss Detail ---------------------//
  public type LossDetail = {
    uuid : Text;
    description : Text;
    lossStat : Int;
  };

  //--------------------- Gain Detail ---------------------//
  public type GainDetail = {
    uuid : Text;
    description : Text;
    gainStat : Int;
  };
}