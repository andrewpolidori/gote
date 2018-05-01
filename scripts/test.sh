PKG_LIST=$(go list ./... | grep -v /vendor/)
mkdir cover/
for package in ${PKG_LIST}; do
    go test -covermode=count -coverprofile "cover/${package##*/}.cov" "$package";
done
