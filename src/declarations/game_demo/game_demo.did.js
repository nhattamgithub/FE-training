export const idlFactory = ({ IDL }) => {
  const Error = IDL.Variant({
    'AlreadyExisting' : IDL.Null,
    'NotFound' : IDL.Null,
    'NotAuthorized' : IDL.Null,
  });
  const Response = IDL.Variant({ 'ok' : IDL.Text, 'err' : Error });
  const CharacterClass = IDL.Record({
    'specialAbility' : IDL.Text,
    'name' : IDL.Text,
    'uuid' : IDL.Opt(IDL.Int),
    'baseHp' : IDL.Int,
    'description' : IDL.Text,
    'baseStamina' : IDL.Int,
    'baseMorale' : IDL.Int,
    'baseMana' : IDL.Int,
  });
  const Response_2 = IDL.Variant({
    'ok' : IDL.Vec(IDL.Tuple(IDL.Text, CharacterClass)),
    'err' : Error,
  });
  const Character = IDL.Record({
    'maxHp' : IDL.Int,
    'intelligent' : IDL.Int,
    'currentStamina' : IDL.Int,
    'currentHp' : IDL.Int,
    'gearIds' : IDL.Opt(IDL.Vec(IDL.Text)),
    'luck' : IDL.Int,
    'name' : IDL.Text,
    'uuid' : IDL.Opt(IDL.Int),
    'classId' : IDL.Opt(IDL.Int),
    'level' : IDL.Int,
    'currentMana' : IDL.Int,
    'materialIds' : IDL.Opt(IDL.Vec(IDL.Text)),
    'strength' : IDL.Int,
    'maxStamina' : IDL.Int,
    'currentMorale' : IDL.Int,
    'lvlUpExp' : IDL.Int,
    'currentExp' : IDL.Int,
    'maxMana' : IDL.Int,
    'vitality' : IDL.Int,
    'maxMorale' : IDL.Int,
  });
  const Response_1 = IDL.Variant({
    'ok' : IDL.Vec(IDL.Tuple(IDL.Text, Character)),
    'err' : Error,
  });
  return IDL.Service({
    'createCharacter' : IDL.Func([IDL.Text, IDL.Text], [Response], []),
    'createCharacterClass' : IDL.Func([CharacterClass], [Response], []),
    'listCharacterClasses' : IDL.Func([], [Response_2], ['query']),
    'listCharacters' : IDL.Func([], [Response_1], ['query']),
    'updateCharacter' : IDL.Func(
        [IDL.Int, IDL.Int, IDL.Int, IDL.Int, IDL.Int],
        [Response],
        [],
      ),
  });
};
export const init = ({ IDL }) => { return []; };
