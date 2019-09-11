# Details The App

This is an application that uses Express to store projects and their to-do lists..

- Routes
- Middlewares
- Express

## Installation

- This App requires [Node.js] \(<https://nodejs.org/)> v4+ to run.

> Windows

Using Chocolatey: <https://chocolatey.org/install>

```sh
cinst nodejs.install
# or for without npm
cinst nodejs
```

check if the installation was successful
(ps: maybe you need to restart the terminal)

```sh
npm -v
node -v
```

> macOS

Using Homebrew: <http://brew.sh/>

```sh
brew install node
```

check if the installation was successful...

- This App requires [yarnPKG](https://yarnpkg.com) v1.16.0 + to run.

> Windows

- Using Chocolatey: [Chocolatey](https://chocolatey.org/install)

```sh
choco install yarn
```

check if the installation was successful...
(ps: maybe you need to restart the terminal)

```sh
yarn -v
```

> macOS
> Using Homebrew: [HomeBrew](http://brew.sh/)

```sh
brew install yarn --without-node
```

check if the installation was successful...

### Software Required

To access the routes (post, get, update, ..), download the insomnia, and the settings the program can be found in the root of the project.

| Software | Link Download                               |
| -------- | ------------------------------------------- |
| Insomnia | [Insomnia](https://insomnia.rest/download/) |

#### How Use

Open your favorite Terminal and run these commands.

navigate to the project folder and run the command to install the dependencies:

```sh
yarn
```

Then Run:

```sh
yarn dev
```

##### Using the Insomnia

To perform tests on the api routes follow the following steps::

- Run the program and click on the Main Logo

- Then click the _import/export_ option and import the file **Insonmia-desafio01.json**
- Switch Workspace for **Bootcamp Desafio #01**

Now simply access the routes in your preferred browser that are displayed on Insomnia and test them:

`http://localhost:3000/projects`
