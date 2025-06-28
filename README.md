#Naredbe za pokretanje aplikacije


-Pokretanje same aplikacije

```bash
./path/appvolan
```

Pri svakoj promjeni aplikacije potrebno je compilirati preko qt creatora inace se promjene nece prikazati na rpi-u. Potrebno i compilirati svaki library zasebno koji aplikacija koristi.

-Setupiranje can porta

```bash
sudo ip link set can0 up type can bitrate 1000000
sudo ifconfig can0 txqueuelen 65536
sudo ifconfig can0 up
```
