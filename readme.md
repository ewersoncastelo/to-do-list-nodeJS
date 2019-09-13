<h1 align="left">
    To do List API with NodeJS
</h1>

<h4 align="lef">
  This is an application that uses Express to store projects and their to-do lists.
</h4>

<p align="left">
<img alt="GitHub top language" src="https://img.shields.io/github/languages/top/ewersoncastelo/to-do-list-nodeJS.svg">
  <img alt="GitHub language count" src="https://img.shields.io/github/languages/count/ewersoncastelo/to-do-list-nodeJS.svg">
  <a href="https://www.codacy.com/manual/ewersoncastelo/to-do-list-nodeJS?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=ewersoncastelo/to-do-list-nodeJS&amp;utm_campaign=Badge_Grade"><img src="https://api.codacy.com/project/badge/Grade/0c62144c58794a21ac46ce18c7f606ff"/></a>
<a href="https://github.com/ewersoncastelo/to-do-list-nodeJS/blob/master/LICENSE"><img alt="GitHub license" src="https://img.shields.io/github/license/ewersoncastelo/to-do-list-nodeJS"></a>
<a href="https://github.com/ewersoncastelo/to-do-list-nodeJS/issues">
    <img alt="Repository issues" src="https://img.shields.io/github/issues/ewersoncastelo/to-do-list-nodeJS.svg">
  </a>
    <img alt="Repository size" src="https://img.shields.io/github/repo-size/ewersoncastelo/to-do-list-nodeJS.svg">
  <a href="https://github.com/ewersoncastelo/to-do-list-nodeJS/commits/master">
    <img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/ewersoncastelo/to-do-list-nodeJS.svg">
  </a>
</p>

## Installation

-   [Express](https://expressjs.com/)
-   [VS Code][vc] with [EditorConfig][vceditconfig] and [ESLint][vceslint]
-   [Insomnia](https://insomnia.rest/download/)

## Software Required

To access the routes (post, get, update, ..), download the insomnia, and the settings the program can be found in the root of the project.

To perform tests on the api routes follow the following steps:

-   Run the program and click on the Main Logo
-   Then click the import/export option and import the file **Insonmia-desafio01.json**
-   Switch Workspace for **Bootcamp Desafio #01**

## How To Use

This App requires [nodejs](https://nodejs.org/) v4+ and [yarn](https://yarnpkg.com/) to run.

Open your favorite Terminal and run these commands. Navigate to the project folder and run the following command to install the dependencies:

```bash
# Clone this repository
$ git clone https://github.com/ewersoncastelo/to-do-list-nodeJS

# Go into the repository
$ cd to-do-list-nodeJS

# Install dependencies
$ yarn install

# Run the app
$ yarn dev
```

Now simply access the routes in your preferred browser that are displayed on Insomnia and test them:

`http://localhost:3000/projects`

---
## License
This project is under the [MIT LICENSE](https://github.com/ewersoncastelo/to-do-list-nodeJS/blob/master/LICENSE) for more information.

---

[nodejs]: https://nodejs.org/
[yarn]: https://yarnpkg.com/
[vc]: https://code.visualstudio.com/
[vceditconfig]: https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig
[vceslint]: https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint
