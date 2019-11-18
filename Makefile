update:
	mix deps.get
	cd assets && npm install

setup:
	mix local.hex --if-missing
	mix archive.install hex phx_new 1.4.10
	mix deps.get
	cd assets && npm install

start:
	export MIX_ENV=dev
	mix phx.server