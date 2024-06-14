<div  align="center">
<h1> Dictionary - TGY Homework by Agah Berkin Güler </h1>
</div>

<div  align="leading">
<h3> - This application helps you to look up for the words meanings, example usages, how to spell and learn more about their synonyms. </h3>
</div>

## Features
- Search: User can search words.
- Spell: User can listen and be aware of the word's pronunciations.
- Recent Search: User can look up by not directly type the word with the section of the last 5 recent search section.
- UITest
- Unit Test: only for the search (for now)

## Tech Stack
- **Xcode:** Version 15.4
- **Language:** Swift 5.10
- **Minimum iOS Version:** 15.0

## Project Development
- UIKit with .xib design
- VIPER architecture

## Architecture
- The Viper architecture is an open-source toolkit for writing reusable, modular, and scalable applications in Swift, emphasizing separation of concerns through components like View, Interactor, Presenter, Entity, and Routing.
- View: Responsible for presenting data to the user and capturing user interactions, but should not contain business logic.
- Interactor: Contains the business logic and handles data fetching, manipulation, and interaction with the data layer (e.g., APIs, databases).
- Presenter: Acts as a mediator between the view and the interactor, formatting data received from the interactor into a suitable format for display in the view.
- Entity: Represents the basic model object or data structure used by the interactor and presenter.
- Routing: Handles navigation between different modules (VIPER components), typically through segues or other navigation mechanisms.

![image](https://github.com/agahberkknglr/turkcell-viper-dictionary/assets/79965739/688e916b-a4ee-4149-8909-45ab6d12cb44)

 ## Screenshots
| Image 1                | Image 2                |
|------------------------|------------------------|
| ![Simulator Screenshot - iPhone SE (3rd generation) - 2024-06-14 at 18 40 13](https://github.com/agahberkknglr/turkcell-viper-dictionary/assets/79965739/0d8c8d0e-fe28-4796-8ceb-2a5e1af68bb1) |
![Simulator Screenshot - iPhone SE (3rd generation) - 2024-06-14 at 18 40 51](https://github.com/agahberkknglr/turkcell-viper-dictionary/assets/79965739/413daed8-f4d2-47a7-9786-17bdda1c85a1) |
| Search Page | Detail Page |

## Gif
![Screen Recording 2024-06-14 at 21 46 42 (2)](https://github.com/agahberkknglr/turkcell-viper-dictionary/assets/79965739/54bfdd51-f196-4b4a-8217-881382232d82)


