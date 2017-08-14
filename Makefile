all: app component

app:
	elm-make src/Main.elm --output=elm.js --debug

component:
	elm-make components/Counter.elm --output=components/counter.js
