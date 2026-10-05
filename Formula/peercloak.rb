# typed: false
# frozen_string_literal: true

class Peercloak < Formula
  desc "Mesh VPN client with encrypted peer-to-peer networking"
  homepage "https://peercloak.com"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://releases.peercloak.com/releases/v0.1.0/peercloak_0.1.0_darwin_amd64.tar.gz"
      sha256 "f96f4f749bf08b6a9aa6db1a341394b6c6eba59bddb786523400e2ab42be9b0d"

      define_method(:install) do
        bin.install "peercloak"
        bin.install "peercloakd"
      end
    end
    if Hardware::CPU.arm?
      url "https://releases.peercloak.com/releases/v0.1.0/peercloak_0.1.0_darwin_arm64.tar.gz"
      sha256 "d591b31075c0232fd72b7ab4b29a1d3e91945df5030b9f6ea913fbc94bffd8ea"

      define_method(:install) do
        bin.install "peercloak"
        bin.install "peercloakd"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://releases.peercloak.com/releases/v0.1.0/peercloak_0.1.0_linux_amd64.tar.gz"
      sha256 "e89e923f26e2b6bb17600b72633e53c4ba8366fa95d60433859158f299422792"
      define_method(:install) do
        bin.install "peercloak"
        bin.install "peercloakd"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://releases.peercloak.com/releases/v0.1.0/peercloak_0.1.0_linux_arm64.tar.gz"
      sha256 "44fbbe80f7550e69dc727ad2ed916dcf73fefcf213c6870d8366559a460ea92c"
      define_method(:install) do
        bin.install "peercloak"
        bin.install "peercloakd"
      end
    end
  end

  def caveats
    <<~EOS
      To finish setup, register the background service and join your network.
      Generate a registration token in your dashboard (https://app.peercloak.com):

        sudo peercloak install --daemon-path "#{opt_bin}/peercloakd"
        sudo peercloak up --auth-key <TOKEN>

      To remove PeerCloak completely:

        sudo peercloak uninstall
        brew uninstall peercloak

      Update with `brew upgrade peercloak` (not `peercloak update`).
    EOS
  end

  test do
    system bin/"peercloak", "version"
  end
end
