import type { Principal } from '@dfinity/principal';
export interface Character {
  'maxHp' : bigint,
  'intelligent' : bigint,
  'currentStamina' : bigint,
  'currentHp' : bigint,
  'gearIds' : [] | [Array<string>],
  'luck' : bigint,
  'name' : string,
  'uuid' : [] | [bigint],
  'classId' : [] | [bigint],
  'level' : bigint,
  'currentMana' : bigint,
  'materialIds' : [] | [Array<string>],
  'strength' : bigint,
  'maxStamina' : bigint,
  'currentMorale' : bigint,
  'lvlUpExp' : bigint,
  'currentExp' : bigint,
  'maxMana' : bigint,
  'vitality' : bigint,
  'maxMorale' : bigint,
}
export interface CharacterClass {
  'specialAbility' : string,
  'name' : string,
  'uuid' : [] | [bigint],
  'baseHp' : bigint,
  'description' : string,
  'baseStamina' : bigint,
  'baseMorale' : bigint,
  'baseMana' : bigint,
}
export type Error = { 'AlreadyExisting' : null } |
  { 'NotFound' : null } |
  { 'NotAuthorized' : null };
export type Response = { 'ok' : string } |
  { 'err' : Error };
export type Response_1 = { 'ok' : Array<[string, Character]> } |
  { 'err' : Error };
export type Response_2 = { 'ok' : Array<[string, CharacterClass]> } |
  { 'err' : Error };
export interface _SERVICE {
  'createCharacter' : (arg_0: string, arg_1: string) => Promise<Response>,
  'createCharacterClass' : (arg_0: CharacterClass) => Promise<Response>,
  'listCharacterClasses' : () => Promise<Response_2>,
  'listCharacters' : () => Promise<Response_1>,
  'updateCharacter' : (
      arg_0: bigint,
      arg_1: bigint,
      arg_2: bigint,
      arg_3: bigint,
      arg_4: bigint,
    ) => Promise<Response>,
}
