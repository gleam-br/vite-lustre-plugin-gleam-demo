# 🎓 Demo: Vite + Lustre + Gleam

[Gleam](https://gleam.run/) project with [lustre](https://lustre.build/) library and [vitejs](https://vite.dev/) with [experimental rolldown](https://rolldown.rs/) runtime.

Gleam build:

```sh
gleam clean
gleam build
```

Vite build:

```sh
npx vite build
```

## How create this project?

Vite create:

```sh
npm create vite
```

1. Project name -> `vite-lustre-plugin-gleam-demo`
2. Select a framework -> `Vanilla`
3. Select a variant -> `JavaScript`
4. Use rolldown-vite (Experimental) -> `Yes` *
5. Install with npm and start now -> `No`

Add plugin:

```sh
cd vite-lustre-plugin-gleam-demo
# gleam
npm install --save-dev vite-plugin-gleam

# tailwindcss
npm install --save-dev tailwindcss
npm install --save-dev @tailwindcss/vite
```

Vite config [vite.config.js](./vite.config.js):

```js
import { resolve } from "path";
import { defineConfig } from "vite";

import gleam from "vite-plugin-gleam";
import tailwindcss from "@tailwindcss/vite";

export default defineConfig({
	plugins: [gleam({ log: "info" }), tailwind()],
	resolve: {
		alias: {
			'@gleam': resolve(__dirname, "./build/dev/javascript")
		}
	}
})
```

Gleam new:

```sh
# new gleam config
cd vite-lustre-plugin-gleam-demo
gleam new vite_lustre_plugin_gleam_demo --skip-git --skip-github --template javascript .

# lustre
gleam add lustre
gleam build
```

Vite dev:

```sh
npm install
npx vite
# or npm run dev
```

## ✅ Plugins

- [vite-plugin-gleam](https://github.com/gleam-br/vite-plugin-gleam)
- [bun-plugin-gleam](https://github.com/gleam-br/bun-plugin-gleam)
- [ts-plugin-gleam](https://github.com/gleam-br/ts-plugin-gleam)

## 🧪 Demo

- [bun-plugin-gleam-demo](https://github.com/gleam-br/bun-plugin-gleam-demo)
- [bunup-plugin-gleam-demo](https://github.com/gleam-br/bunup-plugin-gleam-demo)
- [vite-ts-plugin-gleam-demo](https://github.com/gleam-br/vite-ts-plugin-gleam-demo)

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```

## ⚠️ Warning

This project uses (experimental) [rolldown](https://rolldown.rs/) bundler.

Using [vitejs with rollup default](https://rollupjs.org/) and log level "info" to vite-plugin-gleam:

```
[vite-plugin-gleam] [hotUpdate] ok!
```

Using rolldown maybe show maybe not show this log.
