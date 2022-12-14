# A Wasp template on Gitpod

<img src="./MyNewApp/src/client/waspLogo.png" width='100px'/>

This is a [Wasp](https://wasp-lang.dev/) template configured for ephemeral developer environments on [Gitpod](https://www.gitpod.io/).

Inside this template is a simple ToDo app complete with Authentication, Database Entities, and Client & Server Operations. 

* Look for the `main.wasp` file within the `MyNewApp` directory to see how a Wasp App is built! 
* The `src` directory contains your client and server files that you edit and reference within `main.wasp`
* Wasp uses this information to put all the pieces of your app together, so you can focus on the important stuff (you can see what Wasp builds in `.wasp/out`, but **don't** edit these files 🐝)!

Visit [wasp-lang.dev](https://www.wasp-lang.dev) for more info.


## Next Steps

Click the button below to start a new development environment:

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/gitpod-io/template-wasp)

## Get Started With Your Own Project

### A new project

Click the above "Open in Gitpod" button to start a new workspace. Once you're ready to push your first code changes, Gitpod will guide you to fork this project so you own it.

### An existing project

To get started with Wasp on Gitpod, add a [`.gitpod.yml`](./.gitpod.yml) file which contains the configuration to improve the developer experience on Gitpod. To learn more, please see the [Getting Started](https://www.gitpod.io/docs/getting-started) documentation.

## Wasp CLI Commands

* `wasp start` starts development environment
* `wasp db migrate-dev` to run database migrations
* `wasp db studio` to open Prisma Studio and view your database models 