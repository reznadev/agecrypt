# agecrypt

A minimalistic CLI tool for encrypting and decrypting files and folders using [age](https://age-encryption.org/).

## Features

- 🔒 **File Encryption**: Encrypt individual files directly
- 📁 **Folder Encryption**: Compress and encrypt entire folders
- 🔓 **Smart Decryption**: Automatically detects and handles both file and folder archives
- 🧹 **Clean Mode**: Optional cleanup of intermediate files
- ⚡ **Simple Interface**: Easy-to-use command-line interface

## Installation

### Option 1: Tap and Install
```bash
brew tap reznadev/agecrypt
brew install agecrypt
```

### Option 2: Direct Install
```bash
brew install reznadev/agecrypt/agecrypt
```

## Prerequisites

Make sure you have `age` installed:
```bash
brew install age
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
# Creates: document.pdf.age
```

### Encrypt a folder
```bash
agecrypt -e my_folder age1abc...xyz [--clean]
# Creates: my_folder.tar.gz.age
# --clean removes the intermediate .tar.gz file
```

### Decrypt a file
```bash
agecrypt -d document.pdf.age path_to_key.txt
# Restores: document.pdf
```

### Decrypt a folder
```bash
agecrypt -d my_folder.tar.gz.age path_to_key.txt [--clean]
# Extracts the original folder
# --clean removes the intermediate .tar.gz file
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
