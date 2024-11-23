import { Link } from "@inertiajs/react";

export default function Layout({ children }: { children: React.ReactNode }) {
  return (
    <>
      <header className="py-4 px-8">
        <div className="flex items-center justify-between">
          <div className="flex items-baseline">
            <Link href="/" className="font-bold text-3xl">
              round<span className="text-purple-300">est</span>
              <span className="text-gray-400 font-extralight pl-2 text-2xl">
                (Phoenix Inertia)
              </span>
            </Link>
          </div>
          <nav className="flex flex-row items-center gap-8">
            <Link prefetch href="/results" className="hover:underline text-lg">
              Results
            </Link>
          </nav>
        </div>
      </header>
      <main className="flex-1">{children}</main>
    </>
  );
}
