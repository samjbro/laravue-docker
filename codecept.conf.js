exports.config = {
  "tests": "tests/e2e/**/*_test.js",
  "timeout": 10000,
  "output": "./tests/e2e/output",
  "helpers": {
    "Nightmare": {
      "url": "http://localhost:80",
      "show": true
    }
  },
  "include": {},
  "bootstrap": false,
  "mocha": {},
  "name": "html"
};