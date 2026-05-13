#!/usr/bin/env python3
"""
Web Reconnaissance URL Generator
Generates targeted wordlists for security testing purposes.
For educational use only.
"""

import os
import sys
import re
from pathlib import Path

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
    "git/HEAD", ".svn/entries", "crossdomain.xml",
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


class ValidationError(Exception):
    """Custom exception for validation errors."""
    pass


def is_valid_domain(domain):
    """
    Validate domain format.
    
    Args:
        domain (str): Domain to validate
        
    Returns:
        bool: True if valid, False otherwise
        
    Raises:
        ValidationError: If domain is invalid
    """
    if not domain or len(domain) == 0:
        raise ValidationError("Domain cannot be empty")
    
    if len(domain) > 255:
        raise ValidationError("Domain is too long (max 255 characters)")
    
    # Basic domain pattern validation
    domain_pattern = re.compile(
        r'^(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.)*'
        r'[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?$'
    )
    
    if not domain_pattern.match(domain):
        raise ValidationError(
            f"Invalid domain format: '{domain}'. "
            "Use format like: example.com or sub.example.co.uk"
        )
    
    return True


def clean_domain(domain):
    """
    Strip protocol and trailing slash from domain.
    
    Args:
        domain (str): Raw domain input
        
    Returns:
        str: Cleaned domain
        
    Raises:
        ValidationError: If domain is invalid
    """
    if not isinstance(domain, str):
        raise ValidationError("Domain must be a string")
    
    domain = domain.strip().lower()
    
    # Remove common protocols
    if domain.startswith("https://"):
        domain = domain[8:]
    elif domain.startswith("http://"):
        domain = domain[7:]
    
    domain = domain.rstrip("/").strip()
    
    # Validate the cleaned domain
    is_valid_domain(domain)
    
    return domain


def generate_urls(domain, words):
    """
    Generate full URLs from domain + paths.
    
    Args:
        domain (str): Target domain
        words (list): List of paths to append
        
    Returns:
        list: Generated URLs
        
    Raises:
        ValidationError: If inputs are invalid
    """
    if not isinstance(domain, str) or not domain:
        raise ValidationError("Domain must be a non-empty string")
    
    if not isinstance(words, list) or len(words) == 0:
        raise ValidationError("Words must be a non-empty list")
    
    try:
        urls = [f"http://{domain}/{path}" for path in words]
        return urls
    except Exception as e:
        raise ValidationError(f"Error generating URLs: {str(e)}")


def save_urls(filename, urls, output_dir="wordlists"):
    """
    Save URLs to a txt file with error handling.
    
    Args:
        filename (str): Output filename
        urls (list): List of URLs to save
        output_dir (str): Output directory path
        
    Returns:
        str: Path to saved file
        
    Raises:
        ValidationError: If filename or urls are invalid
        IOError: If file operations fail
    """
    if not filename or not isinstance(filename, str):
        raise ValidationError("Filename must be a non-empty string")
    
    if not isinstance(urls, list):
        raise ValidationError("URLs must be a list")
    
    if len(urls) == 0:
        raise ValidationError("URLs list cannot be empty")
    
    # Validate filename (prevent directory traversal)
    if "/" in filename or "\\" in filename or ".." in filename:
        raise ValidationError(f"Invalid filename: '{filename}'. No path separators allowed")
    
    try:
        # Create output directory
        output_path = Path(output_dir)
        output_path.mkdir(parents=True, exist_ok=True)
        
        # Check write permissions
        if not os.access(output_path, os.W_OK):
            raise IOError(f"No write permission for directory: {output_dir}")
        
        filepath = output_path / filename
        
        # Write to file
        with open(filepath, "w", encoding="utf-8") as f:
            f.write("\n".join(urls))
        
        print(f"  [+] Saved: {filepath}  ({len(urls)} URLs)")
        return str(filepath)
        
    except IOError as e:
        raise IOError(f"Failed to save file {filename}: {str(e)}")
    except Exception as e:
        raise Exception(f"Unexpected error while saving file: {str(e)}")


def show_menu():
    """Display the main menu."""
    print("\n" + "=" * 50)
    print("   Web Recon URL Generator")
    print("   For educational purposes only 🔐")
    print("=" * 50)
    print("\nAvailable Categories:")
    for i, cat in enumerate(CATEGORIES.keys(), 1):
        print(f"  {i}. {cat.replace('_', ' ').title()}")
    print(f"  {len(CATEGORIES)+1}. Generate ALL + master list")
    print(f"  0. Exit")
    print()


def get_user_choice():
    """
    Get and validate user choice input.
    
    Returns:
        str: User's choice
    """
    max_choice = len(CATEGORIES) + 1
    while True:
        try:
            choice = input("Choose an option (0-{}): ".format(max_choice)).strip()
            
            if not choice:
                print("❌ Choice cannot be empty. Please try again.")
                continue
            
            if not choice.isdigit():
                print(f"❌ Invalid input. Please enter a number between 0 and {max_choice}.")
                continue
            
            choice_num = int(choice)
            if choice_num < 0 or choice_num > max_choice:
                print(f"❌ Please enter a number between 0 and {max_choice}.")
                continue
            
            return choice
            
        except KeyboardInterrupt:
            print("\n\n⚠️  Operation cancelled by user.")
            sys.exit(0)
        except Exception as e:
            print(f"❌ Error reading input: {str(e)}")
            continue


def get_domain_input():
    """
    Get and validate domain input from user.
    
    Returns:
        str: Validated domain
    """
    while True:
        try:
            domain_input = input("Enter target domain (e.g., example.com): ").strip()
            
            if not domain_input:
                print("❌ Domain cannot be empty.")
                continue
            
            domain = clean_domain(domain_input)
            print(f"\n[✓] Target domain: http://{domain}/")
            return domain
            
        except ValidationError as e:
            print(f"❌ Validation Error: {str(e)}")
            continue
        except KeyboardInterrupt:
            print("\n\n⚠️  Operation cancelled by user.")
            sys.exit(0)
        except Exception as e:
            print(f"❌ Unexpected error: {str(e)}")
            continue


def process_choice(choice, domain):
    """
    Process user's menu choice.
    
    Args:
        choice (str): User's selected option
        domain (str): Target domain
    """
    cats = list(CATEGORIES.keys())
    safe_domain = domain.replace(".", "_").replace("/", "_")
    
    try:
        if choice == "0":
            print("\n✓ Exiting. Happy learning! 🔥\n")
            sys.exit(0)
        
        elif choice == str(len(CATEGORIES) + 1):
            print(f"\n[*] Generating all categories for {domain}...\n")
            all_urls = []
            
            for category, words in CATEGORIES.items():
                try:
                    urls = generate_urls(domain, words)
                    save_urls(f"{safe_domain}_{category}.txt", urls)
                    all_urls.extend(urls)
                except Exception as e:
                    print(f"  ⚠️  Error processing {category}: {str(e)}")
                    continue
            
            # Save master list
            if all_urls:
                all_urls = sorted(set(all_urls))
                save_urls(f"{safe_domain}_master.txt", all_urls)
                print(f"\n[✓] Done! {len(all_urls)} unique URLs saved to 'wordlists/' folder.\n")
            else:
                print("\n❌ No URLs were generated.\n")
        
        elif choice.isdigit() and 1 <= int(choice) <= len(cats):
            selected = cats[int(choice) - 1]
            urls = generate_urls(domain, CATEGORIES[selected])
            print(f"\n[*] Generating {selected.replace('_', ' ').title()} for {domain}...\n")
            save_urls(f"{safe_domain}_{selected}.txt", urls)
            print(f"\n[✓] Done! Check the 'wordlists/' folder.\n")
        
        else:
            print("❌ Invalid choice. Please try again.")
    
    except ValidationError as e:
        print(f"\n❌ Validation Error: {str(e)}\n")
    except IOError as e:
        print(f"\n❌ File Error: {str(e)}\n")
    except Exception as e:
        print(f"\n❌ Unexpected Error: {str(e)}\n")


def main():
    """Main function with comprehensive error handling."""
    try:
        print("\n" + "🔐 " * 15)
        
        # Get and validate domain
        domain = get_domain_input()
        
        # Show menu and get choice
        show_menu()
        choice = get_user_choice()
        
        # Process the choice
        process_choice(choice, domain)
        
    except KeyboardInterrupt:
        print("\n\n⚠️  Operation cancelled by user.")
        sys.exit(0)
    except Exception as e:
        print(f"\n❌ Critical Error: {str(e)}")
        sys.exit(1)


if __name__ == "__main__":
    main()
