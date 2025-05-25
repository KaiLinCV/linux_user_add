# 🧑‍💻 Add New Local User – Bash Script

This project demonstrates a bash script that automates the process of adding a new local user to a Linux system. It’s designed for system administrators to efficiently manage user onboarding with security best practices in mind.

---

## 📌 Features

- ✅ Adds a new user to the local Linux system  
- 🔐 Automatically generates a secure, random password  
- 🧾 Outputs the username, password, and hostname to the console for documentation  
- 🔄 Enforces password change upon first login (administrator enforced)

---

## 🛠️ Script Execution Flow

### 1. ❌ Non-admin attempt

Running the script without administrator privileges results in an error:

![Permission Denied](./screenshots/01_RunningWithoutPermission.png)

---

### 2. ✅ Running the script with `sudo`

The script accepts:
- First argument: desired username
- Remaining arguments: comment (e.g., full name)

```bash
sudo ./add_new_local_user.sh Jim "Jim Lee"

