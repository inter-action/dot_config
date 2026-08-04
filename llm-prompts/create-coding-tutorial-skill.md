## description

this file contains instructions on creating a tutorial creation skill globally for a coding agent. Pls following instructions below.

## actions

pls create a skill globally named `coding-tutorial-creation` . this skill needs to creating coding tutorial that mimics the famous book 'crafting interpreters' at https://craftinginterpreters.com/ . 

the output file format should be either html or markdown. the tutorial should be structured in sections then chapters. 

this skill should prompt user with questions in batchs until there's no any ambiguous left before emiting the files. also try use questions to figure out user's experience on this topic so that this skill can tailor the content for the user without too much of entry level content.

for each chapter, this skill also need to ensure the code's correctness and consistence across all the chapters. the code should evolve naturally from previous chapter if it has dependence on code in prior chapter
