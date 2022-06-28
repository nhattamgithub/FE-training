import type { Principal } from '@dfinity/principal';
export interface Character {
  'maxHp' : bigint,
  'status' : [] | [string],
  'intelligent' : bigint,
  'currentStamina' : bigint,
  'currentHp' : bigint,
  'gearIds' : [] | [Array<string>],
  'luck' : bigint,
  'name' : string,
  'uuid' : string,
  'classId' : [] | [string],
  'level' : bigint,
  'experience' : bigint,
  'currentMana' : bigint,
  'strength' : [] | [bigint],
  'maxStamina' : bigint,
  'currentMorale' : bigint,
  'maxMana' : bigint,
  'vitality' : bigint,
  'maxMorale' : bigint,
}
export interface CharacterClass {
  'specialAbility' : string,
  'name' : string,
  'uuid' : [] | [string],
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
export type Response_1 = { 'ok' : Array<[string, CharacterClass]> } |
  { 'err' : Error };
export interface _SERVICE {
  'createCharacter' : (arg_0: string, arg_1: Character) => Promise<Response>,
  'createCharacterClass' : (arg_0: CharacterClass) => Promise<Response>,
  'listCharacterClasses' : () => Promise<Response_1>,
  'updateCharacter' : (arg_0: Character) => Promise<Response>,
}
