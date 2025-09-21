![alt text](age_image.png)

`agecrypt` - A minimalistic CLI tool for encrypting and decrypting files and folders using [age](https://age-encryption.org/).

## Features

- 🔒 **File Encryption**: Encrypt individual files directly
- 📁 **Folder Encryption**: Compress and encrypt entire folders
- 🔓 **Smart Decryption**: Automatically detects and handles both file and folder archives
- 🧹 **Clean Mode**: Optional cleanup of intermediate files
- ⚡ **Simple Interface**: Easy-to-use command-line interface

## Installation

### macOS

#### Option 1: Tap and Install

```bash
brew tap reznadev/agecrypt
brew install agecrypt
```

#### Option 2: Direct Install

```bash
brew install reznadev/agecrypt/agecrypt
```

#### Prerequisites

Make sure you have `age` installed:

```bash
brew install age
```

### Linux

#### Install age dependency

```bash
# Ubuntu/Debian
sudo apt install age

# Or download from https://github.com/FiloSottile/age/releases
```

#### Install agecrypt

```bash
# Clone the repository
git clone https://github.com/reznadev/agecrypt.git
cd agecrypt

# Make executable and install
chmod +x agecrypt.sh
sudo cp agecrypt.sh /usr/local/bin/agecrypt
```

## Usage

### Generate a keypair

```bash
age-keygen -o key.txt
# This creates a private key file and displays the public key
```

### Encrypt a file

```bash
agecrypt -e document.pdf age1abc...xyz
```

### Encrypt a folder

```bash
agecrypt -e my_folder age1abc...xyz [--clean]
```

### Decrypt a file

```bash
agecrypt -d document.pdf.age path_to_key.txt
```

### Decrypt a folder

```bash
agecrypt -d my_folder.tar.gz.age path_to_key.txt [--clean]
```

### Help and Version

```bash
agecrypt --help
agecrypt --version
```

## How it works

- **Files**: Directly encrypted using age
- **Folders**: First compressed into a `.tar.gz` archive, then encrypted
- **Decryption**: Automatically detects the type based on filename and handles accordingly

## License

MIT
