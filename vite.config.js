import { nodeResolve } from "@rollup/plugin-node-resolve";
import react from "@vitejs/plugin-react";
import { nodePolyfills } from 'vite-plugin-node-polyfills';

export default {
  build: {
    outDir: "./dist",
  },
  plugins: [
    react(),
    nodeResolve(),
    nodePolyfills({
      include: ['buffer']
    }),
  ],
  server: {
    watch: {
      // ignore parts of _build that don't include output JS
      ignored: [
        "**/_opam/**",
        "**/_build/**/node_modules/**",
        "**/_build/**/*.cmi",
        "**/_build/**/*.cmj",
        "**/_build/**/*.cmt",
        "**/_build/**/*.ml",
        "**/_build/**/*.mli",
        "**/_build/**/.*",
        "**/_build/**/_*", // ignore internal build directories starting with _
        // don't ignore these specific JS files
        "!**/_build/default/src/output/src/**/*.js"
      ],
    },
  },
};
