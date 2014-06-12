# smashcator

### Description

*smashcator* is a service for Super Smash Bros. fans to find tournaments. I developed it as an alternative to the
*SmashBoards* tournament listings section because it lacked the ability to filter tournaments by anything other than region.
*smashcator* lets the user filter through a listing of tournaments based on a number of factors: geographical proximity,
size, prize pool, ruleset, game, etc.

### Installation

To clone and install the repository enter the following commands:

```bash
# This assumes that you have cabal and git installed on your computer.

>$ git clone https://github.com/Crockeo/smashcator.git  # Cloning the repository
>$ cd smashcator  # Moving into the repository directory
>$ cabal sandbox init  # OPTIONAL - Creates a sandbox so that you can avoid dependency errors
>$ cabal install --only-dependencies  # Installing dependencies for the project
># cabal run  # Running the project
```
