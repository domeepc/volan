# Pokretanje aplikacije

```bash
./path/appvolan
```

Potrebno compilirati svaki library koji app koristi i 
sam app preko qt creatora (library preko gcc compilera).

---

Pokretanje can-a

```bash
sudo ip link set can0 up type can bitrate 1000000
sudo ifconfig can0 txqueuelen 65536
sudo ifconfig can0 up
```
