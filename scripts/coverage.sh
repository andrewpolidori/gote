tail -q -n +2 cover/*.cov >> cover/coverage.cov
go tool cover -func=cover/coverage.cov
