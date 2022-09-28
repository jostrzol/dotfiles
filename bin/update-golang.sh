cd /tmp
if [ -d update-golang ]; then
	rm -rf update-golang
fi
git clone https://github.com/udhos/update-golang
cd update-golang
sudo ./update-golang.sh -declutter
