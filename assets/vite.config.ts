import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import tailwindcss from "@tailwindcss/vite";

export default defineConfig(({ isSsrBuild }) => ({
  plugins: [react(), tailwindcss()],
  server: {
    port: 5173,
    strictPort: true,
  },
  ssr: {
    target: "node",
    noExternal: true,
  },
  build: {
    minify: false,
    outDir: isSsrBuild ? "../priv" : "../priv/static/assets",
    emptyOutDir: false,
    ssrEmitAssets: false,
    rollupOptions: {
      input: {
        ...(isSsrBuild ? { ssr: "./src/ssr.tsx" } : { main: "./src/main.tsx" }),
      },
      output: {
        entryFileNames: "[name].js",
        assetFileNames: "[name][extname]",
        ...(isSsrBuild
          ? {
              format: "cjs",
              manualChunks: () => "ssr.js", // Prevent code splitting in SSR build
            }
          : {}),
      },
    },
  },
}));
