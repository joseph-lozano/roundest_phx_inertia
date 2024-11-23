import { useForm } from "@inertiajs/react";
import type { Flash, Pokemon } from "../types";

export default function Home({
  firstPokemon,
  secondPokemon,
  flash,
}: {
  firstPokemon: Pokemon;
  secondPokemon: Pokemon;
  flash: Flash;
}) {
  const { post } = useForm();

  return (
    <div className="flex flex-col items-center">
      <div className="relative h-4 w-full">
        {flash.info && (
          <div className="absolute bg-purple-300 text-black font-bold w-full text-center py-2">
            {flash.info}
          </div>
        )}
        {flash.error && (
          <div className="absolute bg-red-300 text-black font-bold w-full text-center py-2">
            {flash.error}
          </div>
        )}
      </div>
      <div className="flex flex-col lg:flex-row justify-center gap-16 items-center min-h-[80vh]">
        <div key={firstPokemon.id} className="flex flex-col items-center gap-4">
          <img
            src={`https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${firstPokemon.pokemonId}.png`}
            className="w-64 h-64"
          />
          <div className="text-center">
            <span className="text-gray-500 text-lg">
              #{firstPokemon.pokemonId}
            </span>
            <h2 className="text-2xl font-bold capitalize">
              {firstPokemon.name}
            </h2>
            <form
              className="mt-4"
              onSubmit={(e) => {
                e.preventDefault();
                post(
                  `/vote/${firstPokemon.pokemonId}/${secondPokemon.pokemonId}`,
                );
              }}
            >
              <button className="px-8 py-3 bg-purple-500 text-white rounded-lg text-lg font-semibold hover:bg-purple-600 transition-colors">
                Vote
              </button>
            </form>
          </div>
        </div>
        <div
          key={secondPokemon.id}
          className="flex flex-col items-center gap-4"
        >
          <img
            src={`https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${secondPokemon.pokemonId}.png`}
            className="w-64 h-64"
          />
          <div className="text-center">
            <span className="text-gray-500 text-lg">
              #{secondPokemon.pokemonId}
            </span>
            <h2 className="text-2xl font-bold capitalize">
              {secondPokemon.name}
            </h2>
            <form
              className="mt-4"
              onSubmit={(e) => {
                e.preventDefault();
                post(
                  `/vote/${secondPokemon.pokemonId}/${firstPokemon.pokemonId}`,
                );
              }}
            >
              <button className="px-8 py-3 bg-purple-500 text-white rounded-lg text-lg font-semibold hover:bg-purple-600 transition-colors">
                Vote
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>
  );
}
