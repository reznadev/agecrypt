class Agecrypt < Formula
  desc "CLI tool for encrypting/decrypting files and folders using age"
  homepage "https://github.com/reznadev/agecrypt"
  url "https://github.com/reznadev/agecrypt/archive/v1.0.0.tar.gz"
  sha256 "SHA256_PLACEHOLDER"
  license "MIT"
  version "1.0.0"

  depends_on "age"

  def install
    bin.install "agecrypt.sh" => "agecrypt"
  end

  test do
    # Test version command
    assert_match "agecrypt v1.0.0", shell_output("#{bin}/agecrypt --version")

    # Test help command
    assert_match "CLI-tool for encrypting/decrypting", shell_output("#{bin}/agecrypt --help")
  end
end