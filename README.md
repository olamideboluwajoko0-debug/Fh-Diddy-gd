# 🔐 Fh-Diddy-gd - Web Reconnaissance URL Generator

> A professional Python tool for generating targeted wordlists and reconnaissance URLs for authorized security testing and penetration testing engagements.

![Python](https://img.shields.io/badge/Python-3.7+-blue)
![License](https://img.shields.io/badge/License-MIT-green)
![Status](https://img.shields.io/badge/Status-Production%20Ready-brightgreen)

---

## 📖 Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Examples](#examples)
- [Security & Disclaimer](#security--disclaimer)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)

---

## 🎯 Overview

**Fh-Diddy-gd** is a specialized reconnaissance tool designed for security professionals and authorized penetration testers. It automates the generation of common web paths and endpoints that are frequently targeted during security assessments.

### **Key Use Cases:**
- **Penetration Testing**: Identify common web paths on target systems
- **Security Auditing**: Enumerate potential attack surfaces
- **OSINT**: Gather reconnaissance data during authorized assessments
- **Educational**: Learn about common web vulnerabilities and paths

---

## ✨ Features

### **Wordlist Categories**
The tool generates URLs across 7 specialized categories:

| Category | Purpose | Example Paths |
|----------|---------|----------------|
| **Admin Panels** | Administrative interfaces | `/admin`, `/wp-admin`, `/cpanel` |
| **Login Pages** | Authentication endpoints | `/login`, `/signin`, `/auth` |
| **Dashboard Paths** | User dashboards | `/dashboard`, `/home`, `/profile` |
| **Config Files** | Configuration & secrets | `/.env`, `/config.php`, `/settings` |
| **Backup Files** | Backup & archive data | `/backup`, `/backup.zip`, `/dump.sql` |
| **API Endpoints** | API interfaces | `/api/v1`, `/rest`, `/graphql` |
| **Sensitive Files** | Exposed files & logs | `/.git/config`, `/robots.txt`, `/logs` |

### **Generation Modes**
- ✅ Single category generation
- ✅ All categories at once
- ✅ Master consolidated list
- ✅ Organized file output

### **Advanced Features**
- Domain validation with regex pattern matching
- Automatic URL cleaning and normalization
- Directory traversal prevention
- Write permission verification
- Keyboard interrupt handling
- Comprehensive error messages
- UTF-8 encoding support

---

## 📦 Installation

### **Requirements**
- Python 3.7 or higher
- No external dependencies (uses standard library only)

### **Clone & Setup**
```bash
# Clone the repository
git clone https://github.com/olamideboluwajoko0-debug/Fh-Diddy-gd.git
cd Fh-Diddy-gd

# Make executable (Linux/macOS)
chmod +x tool

# Or use directly with Python
python3 tool
```

### **Quick Start**
```bash
python3 tool
```

---

## 🚀 Usage

### **Interactive Mode**
The tool runs in an interactive menu-driven mode:

```bash
$ python3 tool

==================================================
   Web Recon URL Generator
   For educational purposes only 🔐
==================================================

Available Categories:
  1. Admin Panels
  2. Login Pages
  3. Dashboard Paths
  4. Config Files
  5. Backup Files
  6. Api Endpoints
  7. Sensitive Files
  8. Generate ALL + master list
  0. Exit

Choose an option (0-8): 
```

### **Input Your Target**
```
Enter target domain (e.g., example.com): target-site.com

[✓] Target domain: http://target-site.com/
```

### **Select Category or Generate All**
```
Choose an option (0-8): 1

[*] Generating admin panels for target-site.com...

  [+] Saved: wordlists/target_site_com_admin_panels.txt  (16 URLs)

[✓] Done! Check the 'wordlists/' folder.
```

---

## 📋 Examples

### **Example 1: Generate Admin Panels Only**
```bash
$ python3 tool
Enter target domain: vulnerable-app.com
Choose an option: 1

# Output: wordlists/vulnerable_app_com_admin_panels.txt
# Contains 16 common admin panel URLs
```

**Generated URLs:**
```
http://vulnerable-app.com/admin
http://vulnerable-app.com/admin/login
http://vulnerable-app.com/wp-admin
http://vulnerable-app.com/cpanel
...
```

### **Example 2: Generate Master List (All Categories)**
```bash
$ python3 tool
Enter target domain: bank-api.local
Choose an option: 8

[*] Generating all categories for bank-api.local...

  [+] Saved: wordlists/bank_api_local_admin_panels.txt (16 URLs)
  [+] Saved: wordlists/bank_api_local_login_pages.txt (15 URLs)
  [+] Saved: wordlists/bank_api_local_dashboard_paths.txt (13 URLs)
  [+] Saved: wordlists/bank_api_local_config_files.txt (18 URLs)
  [+] Saved: wordlists/bank_api_local_backup_files.txt (14 URLs)
  [+] Saved: wordlists/bank_api_local_api_endpoints.txt (14 URLs)
  [+] Saved: wordlists/bank_api_local_sensitive_files.txt (17 URLs)
  [+] Saved: wordlists/bank_api_local_master.txt (107 unique URLs)

[✓] Done! 107 unique URLs saved to 'wordlists/' folder.
```

### **Example 3: Integration with Other Tools**
```bash
# Use with curl for quick testing
cat wordlists/target_com_admin_panels.txt | while read url; do
  curl -s -o /dev/null -w "%{http_code} - $url\n" "$url"
done

# Use with ffuf for fuzzing
ffuf -w wordlists/target_com_admin_panels.txt -u http://target.com/FUZZ

# Use with Burp Suite Intruder
# Import the wordlist file into your fuzzing payload list
```

---

## 🔒 Security & Disclaimer

### **⚠️ IMPORTANT LEGAL WARNING**

This tool is **STRICTLY FOR AUTHORIZED SECURITY TESTING ONLY**. Unauthorized access to computer systems is illegal.

**DO NOT use this tool to:**
- ❌ Test systems you don't own without written permission
- ❌ Bypass authentication or access controls illegally
- ❌ Interfere with system operations
- ❌ Conduct unauthorized security testing

**ONLY use this tool to:**
- ✅ Test systems you own or operate
- ✅ Conduct authorized penetration tests with written permission
- ✅ Educational purposes in controlled environments
- ✅ Authorized security audits and assessments

**By using this tool, you assume all legal responsibility for your actions.**

### **Security Features**
- ✅ Input validation prevents injection attacks
- ✅ No external dependencies = minimal attack surface
- ✅ URL generation only (non-destructive)
- ✅ Comprehensive error handling
- ✅ File write permission verification

---

## 📁 Project Structure

```
Fh-Diddy-gd/
├── tool                 # Main Python script (executa ble)
├── README.md           # This file
├── LICENSE             # MIT License
├── .gitignore          # Git ignore rules
├── wordlists/          # Output directory (created at runtime)
│   ├── example_admin_panels.txt
│   ├── example_login_pages.txt
│   └── example_master.txt
└── .github/
    └── SECURITY.md     # Security policy
```

---

## 🛠️ Technical Details

### **Code Quality**
- ✅ PEP 8 compliant
- ✅ Type hints in docstrings
- ✅ Comprehensive error handling
- ✅ Input validation & sanitization
- ✅ Security best practices

### **Error Handling**
The tool gracefully handles:
- Invalid domain formats
- File system errors
- Permission issues
- Keyboard interrupts (Ctrl+C)
- Empty or invalid inputs

### **Performance**
- Lightweight (~12KB)
- No external dependencies
- Generates 107+ URLs in <100ms
- Memory efficient

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Report Issues**: Found a bug? [Open an issue](https://github.com/olamideboluwajoko0-debug/Fh-Diddy-gd/issues)
2. **Suggest Features**: Have ideas? [Create a discussion](https://github.com/olamideboluwajoko0-debug/Fh-Diddy-gd/discussions)
3. **Submit PRs**: Want to improve the code? Fork and submit a pull request!

### **Development Setup**
```bash
git clone https://github.com/olamideboluwajoko0-debug/Fh-Diddy-gd.git
cd Fh-Diddy-gd
python3 tool
```

---

## 📊 Wordlist Statistics

| Category | Path Count | Common Use Case |
|----------|-----------|-----------------|
| Admin Panels | 16 | Finding administration interfaces |
| Login Pages | 15 | Authentication endpoints |
| Dashboard Paths | 13 | User control panels |
| Config Files | 18 | Sensitive configurations |
| Backup Files | 14 | Data exposure risks |
| API Endpoints | 14 | API surface enumeration |
| Sensitive Files | 17 | Information disclosure |
| **TOTAL** | **107** | **Comprehensive recon** |

---

## 📚 Resources & Learning

- **OWASP Top 10**: Common web vulnerabilities
- **PortSwigger Web Academy**: Web security training
- **HackTheBox**: Hands-on security labs
- **TryHackMe**: Interactive security challenges

---

## 📜 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

```
MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, and distribute, subject to the
conditions of the Software.
```

---

## 🙏 Acknowledgments

- Security research community for wordlist inspiration
- OWASP for security best practices
- Python community for best practices

---

## 📬 Contact & Support

- **Issues**: [GitHub Issues](https://github.com/olamideboluwajoko0-debug/Fh-Diddy-gd/issues)
- **Discussions**: [GitHub Discussions](https://github.com/olamideboluwajoko0-debug/Fh-Diddy-gd/discussions)

---

## 🔐 Security Reporting

Found a security vulnerability? Please email security@your-domain.com instead of using the issue tracker.

---

**⭐ If you find this tool useful, please give it a star!**

Made with ❤️ for the security community
