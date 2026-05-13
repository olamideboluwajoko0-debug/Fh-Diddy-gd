import os

# ─────────────────────────────────────────
#  Wordlist Categories
# ─────────────────────────────────────────

ADMIN_PANELS = [
    "admin", "admin/login", "admin/dashboard", "admin/panel",
    "administrator", "administrator/login", "adminpanel",
    "admin1", "admin2", "admin_area", "admin_login",
    "backend", "backend/login", "controlpanel", "cp",
    "cpanel", "manage", "management", "manager",
    "moderator", "owner", "root", "superadmin",
    "sysadmin", "webadmin", "wp-admin", "wp-login.php",
]

LOGIN_PAGES = [
    "login", "login.php", "login.html", "login.aspx",
    "signin", "sign-in", "sign_in", "logon",
    "log-in", "log_in", "auth", "authenticate",
    "authentication", "user/login", "account/login",
    "portal", "portal/login", "secure/login",
    "member/login", "members/login", "staff/login",
]

DASHBOARD_PATHS = [
    "dashboard", "dashboard/home", "dash", "home",
    "index", "index.php", "index.html", "main",
    "overview", "panel", "profile", "settings",
    "user/dashboard", "account/dashboard", "console",
]

CONFIG_FILES = [
    ".env", ".env.backup", ".env.old", ".env.local",
    "config.php", "config.yml", "config.yaml", "config.json",
    "configuration.php", "settings.php", "settings.py",
    "database.php", "db.php", "db_config.php",
    "wp-config.php", "app.config", "web.config",
    ".htaccess", ".htpasswd", "phpinfo.php",
]

BACKUP_FILES = [
    "backup", "backup.zip", "backup.tar.gz", "backup.sql",
    "backup/db", "backups", "old", "old_site",
    "site_backup", "www_backup", "database_backup",
    "dump.sql", "db_backup.sql", "backup.php",
    "archive", "archives", "restore",
]

API_ENDPOINTS = [
    "api", "api/v1", "api/v2", "api/v3",
    "api/login", "api/admin", "api/users",
    "api/config", "api/debug", "api/test",
    "v1", "v2", "rest", "graphql",
    "swagger", "swagger-ui", "api-docs",
    "docs", "documentation",
]

SENSITIVE_FILES = [
    "robots.txt", "sitemap.xml", ".git/config",
    ".git/HEAD", ".svn/entries", "crossdomain.xml",
    "security.txt", ".well-known/security.txt",
    "server-status", "server-info", "info.php",
    "test.php", "debug.php", "error_log",
    "access_log", "logs", "log",
]

# ─────────────────────────────────────────
#  All categories mapped
# ─────────────────────────────────────────

CATEGORIES = {
    "admin_panels":    ADMIN_PANELS,
    "login_pages":     LOGIN_PAGES,
    "dashboard_paths": DASHBOARD_PATHS,
    "config_files":    CONFIG_FILES,
    "backup_files":    BACKUP_FILES,
    "api_endpoints":   API_ENDPOINTS,
    "sensitive_files": SENSITIVE_FILES,
}


def save_wordlist(name, words, output_dir="wordlists"):
    """Save a wordlist to a .txt file."""
    os.makedirs(output_dir, exist_ok=True)
    filepath = os.path.join(output_dir, f"{name}.txt")
    with open(filepath, "w") as f:
        f.write("\n".join(sorted(set(words))))
    print(f"  [+] Saved: {filepath}  ({len(words)} entries)")
    return filepath


def generate_all(output_dir="wordlists"):
    """Generate individual wordlists + one combined master list."""
    print("\n[*] Generating wordlists...\n")
    all_words = []

    for category, words in CATEGORIES.items():
        save_wordlist(category, words, output_dir)
        all_words.extend(words)

    # Master combined list (deduplicated)
    save_wordlist("master_wordlist", all_words, output_dir)
    print(f"\n[✓] Done! {len(set(all_words))} unique entries in master list.")
    print(f"[✓] Files saved to '{output_dir}/' folder.\n")


def show_menu():
    print("=" * 45)
    print("   Web Recon Wordlist Generator")
    print("   by: you 😈")
    print("=" * 45)
    print("\nCategories available:")
    for i, cat in enumerate(CATEGORIES.keys(), 1):
        print(f"  {i}. {cat}")
    print(f"  {len(CATEGORIES)+1}. Generate ALL + master list")
    print(f"  0. Exit")
    print()


def main():
    show_menu()
    choice = input("Choose an option: ").strip()

    cats = list(CATEGORIES.keys())

    if choice == "0":
        print("Exiting. Happy hacking 🔥")

    elif choice == str(len(CATEGORIES) + 1):
        generate_all()

    elif choice.isdigit() and 1 <= int(choice) <= len(cats):
        selected = cats[int(choice) - 1]
        print(f"\n[*] Generating: {selected}\n")
        save_wordlist(selected, CATEGORIES[selected])
        print("\n[✓] Done!\n")

    else:
        print("Invalid choice. Run the script again.")


if __name__ == "__main__":
    main()