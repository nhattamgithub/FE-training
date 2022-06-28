import { game_demo } from "../../declarations/game_demo";

document.querySelector("form").addEventListener("submit", async (e) => {
  e.preventDefault();
  const button = e.target.querySelector("button");
  const data = () => {
    const name = document.getElementById("name").value.toString();
    const sa = document.getElementById("sa").value.toString();
    const desc = document.getElementById("desc").value.toString();
    const basemana = document.getElementById("basemana").value;
    const basehp = document.getElementById("basehp").value;
    const basemorale = document.getElementById("basemorale").value;
    const basestamina = document.getElementById("basestamina").value;
    return {
      uuid:[""],
      name:name,
      specialAbility:sa,
      description:desc,
      baseMana:parseInt(basemana),
      baseStamina:parseInt(basestamina),
      baseMorale:parseInt(basemorale),
      baseHp:parseInt(basehp)
    }
  }
  console.log(data());

  button.setAttribute("disabled", true);

  // Interact with foo actor, calling the createCharacterClass method
  const createCharacterClass = await game_demo.createCharacterClass(data());
  console.log(createCharacterClass);
  button.removeAttribute("disabled");
  return false;
});
