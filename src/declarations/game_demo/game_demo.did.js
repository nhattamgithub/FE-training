export const idlFactory = ({ IDL }) => {
  const Character = IDL.Record({
    'maxHp' : IDL.Int,
    'status' : IDL.Opt(IDL.Text),
    'intelligent' : IDL.Int,
    'currentStamina' : IDL.Int,
    'currentHp' : IDL.Int,
    'gearIds' : IDL.Opt(IDL.Vec(IDL.Text)),
    'luck' : IDL.Int,
    'name' : IDL.Text,
    'uuid' : IDL.Text,
    'classId' : IDL.Opt(IDL.Text),
    'level' : IDL.Int,
    'experience' : IDL.Int,
    'currentMana' : IDL.Int,
    'strength' : IDL.Opt(IDL.Int),
    'maxStamina' : IDL.Int,
    'currentMorale' : IDL.Int,
    'maxMana' : IDL.Int,
    'vitality' : IDL.Int,
    'maxMorale' : IDL.Int,
  });
  const Error = IDL.Variant({
    'AlreadyExisting' : IDL.Null,
    'NotFound' : IDL.Null,
    'NotAuthorized' : IDL.Null,
  });
  const Response = IDL.Variant({ 'ok' : IDL.Text, 'err' : Error });
  const CharacterClass = IDL.Record({
    'specialAbility' : IDL.Text,
    'name' : IDL.Text,
    'uuid' : IDL.Opt(IDL.Text),
    'baseHp' : IDL.Int,
    'description' : IDL.Text,
    'baseStamina' : IDL.Int,
    'baseMorale' : IDL.Int,
    'baseMana' : IDL.Int,
  });
  const Response_1 = IDL.Variant({
    'ok' : IDL.Vec(IDL.Tuple(IDL.Text, CharacterClass)),
    'err' : Error,
  });
  return IDL.Service({
    'createCharacter' : IDL.Func([IDL.Text, Character], [Response], []),
    'createCharacterClass' : IDL.Func([CharacterClass], [Response], []),
    'listCharacterClasses' : IDL.Func([], [Response_1], ['query']),
    'updateCharacter' : IDL.Func([Character], [Response], []),
  });
};
export const init = ({ IDL }) => { return []; };
