setup:
	mix local.hex --if-missing
	mix archive.install hex phx_new 1.4.10

start:
	export MIX_ENV=dev
	mix phx.server