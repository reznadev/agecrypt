class Agecrypt < Formula
  desc "CLI tool for encrypting/decrypting files and folders using age"
  homepage "https://github.com/reznadev/agecrypt"
  url "https://github.com/reznadev/agecrypt/archive/v1.0.0.tar.gz"
  sha256 "91749100af96e26b7685d0c26840f2590954c63a4d3b1963d5c86b1827e8faa0"
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