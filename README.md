# 🖥️ GitHub Codespace - VNC + AnyDesk Setup Guide

> **By Badal** | Ubuntu 20.04 | XFCE Desktop | TigerVNC + AnyDesk + bore.pub tunnel

---

## 📋 Prerequisites

- GitHub Codespace (4-core, 16GB RAM recommended)
- Termux ya browser terminal
- Phone pe **RealVNC Viewer** app (Play Store)
- Phone pe **AnyDesk** app (Play Store)

---

## ⚡ Step 1: System Update

```bash
sudo apt update
```

---

## 🖥️ Step 2: XFCE Desktop Install

```bash
sudo apt install -y xfce4 xfce4-goodies xfce4-terminal
```

> ☕ 2-3 minute lagega, chai pee lo!

---

## 📡 Step 3: TigerVNC Install

```bash
sudo apt install -y tigervnc-standalone-server tigervnc-common
```

---

## ⚙️ Step 4: VNC xstartup Configure

```bash
cat > ~/.vnc/xstartup << 'EOF'
#!/bin/bash
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
export XKL_XMODMAP_DISABLE=1
startxfce4 &
EOF
chmod +x ~/.vnc/xstartup
```

---

## 🚀 Step 5: VNC Server Start (No Password)

```bash
vncserver :1 -geometry 1280x500 -depth 24 -SecurityTypes None -localhost no --I-KNOW-THIS-IS-INSECURE
```

> 💡 Resolution change karna ho to `1280x500` ki jagah apna size daalo

---

## 🌐 Step 6: bore.pub Tunnel Install

```bash
curl -L https://github.com/ekzhang/bore/releases/download/v0.5.0/bore-v0.5.0-x86_64-unknown-linux-musl.tar.gz | tar -xz
sudo mv bore /usr/local/bin/
```

---

## 🔗 Step 7: bore Tunnel Start (Background)

```bash
nohup bore local 5901 --to bore.pub > ~/bore.log 2>&1 &
sleep 2 && cat ~/bore.log
```

> 📝 Port number note karo jo `bore.pub:XXXXX` mein aayega!

---

## 📱 Step 8: RealVNC se Connect karo

1. RealVNC Viewer app kholo
2. Address: `bore.pub:XXXXX` (apna port daalo)
3. Connect! (No password)
4. XFCE desktop dikhega ✅

---

## 🖱️ Step 9: AnyDesk Install (VNC Terminal se)

VNC ke andar terminal kholo (right click → Terminal) aur:

```bash
wget https://download.anydesk.com/linux/anydesk_6.3.2-1_amd64.deb
sudo dpkg -i anydesk_6.3.2-1_amd64.deb
sudo apt install -f -y
```

---

## 🚀 Step 10: AnyDesk Start

VNC terminal mein:

```bash
anydesk &
```

- AnyDesk ID note karo
- Phone pe AnyDesk app se connect karo
- **VNC band karo** → AnyDesk se kaam karo! 👑

---

## 🔁 Next Session / New Codespace mein

Agar sab install hai to sirf yeh commands:

```bash
# VNC start
vncserver :1 -geometry 1280x500 -depth 24 -SecurityTypes None -localhost no --I-KNOW-THIS-IS-INSECURE

# bore tunnel
nohup bore local 5901 --to bore.pub > ~/bore.log 2>&1 &
sleep 2 && cat ~/bore.log

# AnyDesk (VNC terminal se)
anydesk &
```

---

## ⚠️ Important Notes

| Problem | Solution |
|---------|----------|
| Codespace timeout | GitHub Settings → Codespaces → Idle timeout → 240 min |
| bore band ho gaya | `nohup bore local 5901 --to bore.pub > ~/bore.log 2>&1 &` |
| VNC black screen | `vncserver -kill :1` phir dobara start |
| AnyDesk banner | Ignore karo, kaam karta hai 😂 |
| SSH se connect | `while true; do echo "alive" > /dev/null; sleep 60; done &` |

---

## 🏆 Final Verdict

```
KDE          ❌ Too heavy
LXDE         ❌ Ugly
xterm        🤮 Bakwaas
RDP (xrdp)   ❌ Laggy
RustDesk     ❌ Wrong password
NoMachine    ❌ Slow
AnyDesk      👑 WINNER! 1 ghanta mast chala!
```

---

> 💡 **Tip:** New Codespace mein sab fresh install karna padega (XFCE, VNC, AnyDesk)  
> kyunki Codespace ka filesystem reset hota hai!
> 
> Permanent setup ke liye `.devcontainer/Dockerfile` mein yeh sab add karo!
> 
