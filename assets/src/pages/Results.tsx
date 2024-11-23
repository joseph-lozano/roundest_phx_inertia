import { Deferred, Head, usePoll } from "@inertiajs/react";
import type { Pokemon } from "../types";

type PokemonWithStats = Pokemon & {
  stats: { winRate: number; wins: number; losses: number };
};

export default function Results(props: { rankings: PokemonWithStats[] }) {
  usePoll(2000);
  return (
    <>
      <Head>
        <title>Roundest - Results</title>
      </Head>
      <div className="container mx-auto px-4 py-8 text-white">
        <div className="grid gap-4">
          <ResultsList rankings={props.rankings} />
        </div>
      </div>
    </>
  );
}

function ResultsList({ rankings }: { rankings: PokemonWithStats[] }) {
  console.log(rankings);
  return rankings.map((pokemon, index) => (
    <div
      key={pokemon.pokemonId}
      className="flex items-center gap-6 p-6 bg-gray-800/40 rounded-lg shadow hover:shadow-md transition-shadow"
    >
      <div className="text-2xl font-bold text-gray-400 w-8">#{index + 1}</div>

      <img
        src={`https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon.pokemonId}.png`}
        alt={pokemon.name}
        className="w-12 h-12"
      />

      <div className="flex-grow">
        <div className="text-gray-400 text-sm">#{pokemon.pokemonId}</div>
        <h2 className="text-xl font-semibold capitalize">{pokemon.name}</h2>
      </div>

      <div className="text-right">
        <div className="text-2xl font-bold text-purple-400">
          {(pokemon.stats.winRate * 100).toFixed(1)}%
        </div>
        <div className="text-sm text-gray-400">
          {pokemon.stats.wins}W - {pokemon.stats.losses}L
        </div>
      </div>
    </div>
  ));
}
