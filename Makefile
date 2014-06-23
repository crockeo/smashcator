default:
	cabal build

clean:
	cabal clean

reconfigure:
	cabal clean
	cabal configure
