import js from "@eslint/js";

export default [
  js.configs.recommended,

  {
    env: {
      browser: true,
      node: true,
      es2021: true,
    },
    extends: [
      "eslint:recommended",
      "plugin:@typescript-eslint/recommended",
      "plugin:react/recommended",
      "plugin:prettier/recommended",
    ],
    parser: "@typescript-eslint/parser",
    parserOptions: {
      ecmaVersion: 12,
      sourceType: "module",
    },
    plugins: ["@typescript-eslint", "react"],
    rules: {
      "no-unused-vars": "warn",
      "no-undef": "warn",
    },
    overrides: [
      {
        files: ["**/*.ts", "**/*.tsx"],
      },
      {
        files: [
          "apps/frontend/**/*.js",
          "apps/frontend/**/*.ts",
          "apps/frontend/**/*.jsx",
          "apps/frontend/**/*.tsx",
        ],
        env: {
          browser: true,
        },
        plugins: ["react"],
        extends: ["plugin:react/recommended"],
        rules: {
          "react/prop-types": "off",
        },
      },
      {
        files: ["apps/backend/**/*.js", "apps/backend/**/*.ts"],
        env: {
          node: true,
        },
      },
    ],
  },
];
