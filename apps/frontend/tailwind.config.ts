import type { Config } from "tailwindcss";
import baseConfig from "@repo/tailwind-config/tailwind-base";

const config: Config = {
  content: [
    "./src/app/**/*.{js,jsx,mjs,cjs,ts,tsx,mdx}",
    "./src/components/**/*.{js,jsx,mjs,cjs,ts,tsx,mdx}",
  ],
  presets: [baseConfig],
};

export default config;
