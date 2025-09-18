#!/bin/bash
# agecrypt – CLI-tool for encrypting/decrypting files and folders
# Usage: agecrypt -e <file|folder> <recipient-public-key> [--clean]
#        agecrypt -d <encrypted-file> <private-key-file> [--clean]
#        agecrypt -v|--version
#        agecrypt -h|--help

VERSION="1.0.0"

set -e

if [ $# -lt 1 ]; then
    echo "Usage: $0 -e <file|folder> <recipient-public-key> [--clean]"
    echo "       $0 -d <encrypted-file> <private-key-file> [--clean]"
    echo "       $0 -v|--version"
    echo "       $0 -h|--help"
    exit 1
fi

command="$1"

case "$command" in
    -e)
        if [ $# -lt 3 ]; then
            echo "Usage: $0 -e <file|folder> <recipient-public-key> [--clean]"
            exit 1
        fi
        INPUT="$2"
        RECIPIENT="$3"
        CLEANUP="$4"

        if [ ! -e "$INPUT" ]; then
            echo "[-] Error: File or folder '$INPUT' does not exist!"
            exit 1
        fi

        if [ -d "$INPUT" ]; then
            ARCHIVE="${INPUT}.tar.gz"
            ENCRYPTED="${ARCHIVE}.age"

            echo "[*] Creating archive: $ARCHIVE"
            if ! tar -czf "$ARCHIVE" "$INPUT"; then
                echo "[-] Archive creation failed!"
                exit 1
            fi

            echo "[*] Start encryption with age for recipient: $RECIPIENT..."
            if ! age -r "$RECIPIENT" -o "$ENCRYPTED" "$ARCHIVE"; then
                echo "[-] Encryption failed!"
                exit 1
            fi

            echo "[+] Done! encrypted data: $ENCRYPTED"

            if [ "$CLEANUP" == "--clean" ]; then
                echo "[*] Deleting unencrypted archive..."
                rm "$ARCHIVE"
            fi
        else
            ENCRYPTED="${INPUT}.age"

            echo "[*] Start encryption with age for recipient: $RECIPIENT..."
            if ! age -r "$RECIPIENT" -o "$ENCRYPTED" "$INPUT"; then
                echo "[-] Encryption failed!"
                exit 1
            fi

            echo "[+] Done! encrypted data: $ENCRYPTED"
        fi
        ;;

    -d)
        if [ $# -lt 3 ]; then
            echo "Usage: $0 -d <encrypted-file> <private-key-file> [--clean]"
            exit 1
        fi
        ENCRYPTED="$2"
        KEY="$3"
        CLEANUP="$4"

        if [ ! -f "$ENCRYPTED" ]; then
            echo "[-] Error: Encrypted file '$ENCRYPTED' does not exist!"
            exit 1
        fi
        if [ ! -f "$KEY" ]; then
            echo "[-] Error: Private key file '$KEY' does not exist!"
            exit 1
        fi

        if [[ "$ENCRYPTED" == *.tar.gz.age ]]; then
            ARCHIVE="${ENCRYPTED%.age}"

            echo "[*] Start decrypting data: $ENCRYPTED..."
            if ! age -d -i "$KEY" -o "$ARCHIVE" "$ENCRYPTED"; then
                echo "[-] Decryption failed!"
                exit 1
            fi

            echo "[*] Unpacking archive: $ARCHIVE..."
            if ! tar -xzf "$ARCHIVE"; then
                echo "[-] Archive extraction failed!"
                exit 1
            fi

            echo "[+] Done! Data extracted."

            if [ "$CLEANUP" == "--clean" ]; then
                echo "[*] Delete archive..."
                rm "$ARCHIVE"
            fi
        else
            DECRYPTED="${ENCRYPTED%.age}"

            echo "[*] Start decrypting file: $ENCRYPTED..."
            if ! age -d -i "$KEY" -o "$DECRYPTED" "$ENCRYPTED"; then
                echo "[-] Decryption failed!"
                exit 1
            fi

            echo "[+] Done! Decrypted file: $DECRYPTED"
        fi
        ;;

    -v|--version)
        echo "agecrypt v$VERSION"
        ;;

    -h|--help)
        echo "agecrypt – CLI-tool for encrypting/decrypting files and folders using age"
        echo ""
        echo "USAGE:"
        echo "    agecrypt -e <file|folder> <recipient-public-key> [--clean]"
        echo "    agecrypt -d <encrypted-file> <private-key-file> [--clean]"
        echo "    agecrypt -v|--version"
        echo "    agecrypt -h|--help"
        echo ""
        echo "COMMANDS:"
        echo "    -e    Encrypt a file or folder"
        echo "    -d    Decrypt an encrypted file"
        echo "    -v    Show version"
        echo "    -h    Show this help"
        echo ""
        echo "OPTIONS:"
        echo "    --clean    Remove intermediate files after operation"
        echo ""
        echo "DEPENDENCIES:"
        echo "    age       File encryption tool (install via: brew install age)"
        echo ""
        echo "EXAMPLES:"
        echo "    # Generate keypair"
        echo "    age-keygen -o key.txt"
        echo ""
        echo "    # Encrypt a file"
        echo "    agecrypt -e document.pdf age1abc...xyz"
        echo ""
        echo "    # Encrypt a folder"
        echo "    agecrypt -e my_folder age1abc...xyz [--clean]"
        echo ""
        echo "    # Decrypt a file"
        echo "    agecrypt -d document.pdf.age path_to_key.txt (agekey)"
        echo ""
        echo "    # Decrypt a folder"
        echo "    agecrypt -d my_folder.tar.gz.age path_to_key.txt (agekey) [--clean]"
        ;;

    *)
        echo "Unknown command: $command"
        echo "Usage: $0 -e <file|folder> <recipient-public-key> [--clean]"
        echo "       $0 -d <encrypted-file> <private-key-file> [--clean]"
        echo "       $0 -v|--version"
        echo "       $0 -h|--help"
        exit 1
        ;;
esac

