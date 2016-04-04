additional languages/binaries to be tested are welcomed. fork this repository, make your changes and send us a PR with:
  * 0755 permissions `test.sh` in `test/<language>/<library>/`
  * update of the 'tests' table in `README.md`

`test.sh` is the entry point for 1863BFAF, and should trigger your language/binary to:
  * call `http://localhost:4567/meta` to receive list of API routes to call (JSON array)
  * call each route returned, if your library/binary fails (throws an exception or error), fail a test
  * test.sh exit code should be 0 for success, 1 for any failure, 2 for an error unrelated to 1863BFAF