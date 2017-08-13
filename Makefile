app:
	elm-make src/Main.elm --output=elm.js

component:
	elm-make components/Counter.elm --output=components/counter.js
