
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

CATEGORIES = {
    "admin_panels":    ADMIN_PANELS,
    "login_pages":     LOGIN_PAGES,
    "dashboard_paths": DASHBOARD_PATHS,
    "config_files":    CONFIG_FILES,
    "backup_files":    BACKUP_FILES,
    "api_endpoints":   API_ENDPOINTS,
    "sensitive_files": SENSITIVE_FILES,
}


def clean_domain(domain):
    """Strip protocol and trailing slash from domain."""
    domain = domain.strip()
    if domain.startswith("https://"):
        domain = domain[8:]
    elif domain.startswith("http://"):
        domain = domain[7:]
    domain = domain.rstrip("/")
    return domain


def generate_urls(domain, words):
    """Generate full URLs from domain + paths."""
    return [f"http://{domain}/{path}" for path in words]


def save_urls(filename, urls, output_dir="wordlists"):
    """Save URLs to a txt file."""
    os.makedirs(output_dir, exist_ok=True)
    filepath = os.path.join(output_dir, filename)
    with open(filepath, "w") as f:
        f.write("\n".join(urls))
    print(f"  [+] Saved: {filepath}  ({len(urls)} URLs)")
    return filepath


def show_menu():
    print("\n" + "=" * 45)
    print("   Web Recon URL Generator")
    print("   For educational purposes only 🔐")
    print("=" * 45)
    print("\nCategories:")
    for i, cat in enumerate(CATEGORIES.keys(), 1):
        print(f"  {i}. {cat}")
    print(f"  {len(CATEGORIES)+1}. Generate ALL + master list")
    print(f"  0. Exit")
    print()


def main():
    # Get domain from user
    domain_input = input("Enter target domain (e.g. example.com): ").strip()
    if not domain_input:
        print("No domain entered. Exiting.")
        return

    domain = clean_domain(domain_input)
    print(f"\n[*] Target: http://{domain}/\n")

    show_menu()
    choice = input("Choose an option: ").strip()

    cats = list(CATEGORIES.keys())
    safe_domain = domain.replace(".", "_").replace("/", "_")

    if choice == "0":
        print("Exiting. Happy learning 🔥")

    elif choice == str(len(CATEGORIES) + 1):
        print(f"\n[*] Generating all categories for {domain}...\n")
        all_urls = []
        for category, words in CATEGORIES.items():
            urls = generate_urls(domain, words)
            save_urls(f"{safe_domain}_{category}.txt", urls)
            all_urls.extend(urls)

        # Master list
        all_urls = sorted(set(all_urls))
        save_urls(f"{safe_domain}_master.txt", all_urls)
        print(f"\n[✓] Done! {len(all_urls)} unique URLs saved to 'wordlists/' folder.\n")

    elif choice.isdigit() and 1 <= int(choice) <= len(cats):
        selected = cats[int(choice) - 1]
        urls = generate_urls(domain, CATEGORIES[selected])
        print(f"\n[*] Generating {selected} for {domain}...\n")
        save_urls(f"{safe_domain}_{selected}.txt", urls)
        print(f"\n[✓] Done! Check the 'wordlists/' folder.\n")

    else:
        print("Invalid choice. Run the script again.")


if __name__ == "__main__":
    main()
