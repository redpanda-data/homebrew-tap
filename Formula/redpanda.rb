# typed: false
# frozen_string_literal: true

# This file was generated from a template file redpanda.rb.tmpl. DO NOT EDIT.
class Redpanda < Formula
  desc "Redpanda CLI & toolbox"
  homepage "https://redpanda.com"
  version "25.2.4"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.2.4/rpk-darwin-amd64.zip"
      sha256 "079c677e1e060b8196664957482e9f356460711766a27fee228d896154bc0861"

      def install
        bin.install "rpk"
        generate_completions_from_executable(bin/"rpk", "generate", "shell-completion", base_name: "rpk")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.2.4/rpk-darwin-arm64.zip"
      sha256 "d7eb3012939bf6b601f3a3f02c88cebd088794697ca3f1b0312990e3b98c3416"

      def install
        bin.install "rpk"
        generate_completions_from_executable(bin/"rpk", "generate", "shell-completion", base_name: "rpk")
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.2.4/rpk-linux-arm64.zip"
      sha256 "31e63c309cbef4177d274f730a69b73e56a934e19ed896cf9e8ef665e397fab2"

      def install
        bin.install "rpk"
        generate_completions_from_executable(bin/"rpk", "generate", "shell-completion", base_name: "rpk")
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.2.4/rpk-linux-amd64.zip"
      sha256 "a90fe32725cd89a6c1006062a0e5190037bcc4d0a935899eced2a184e25819dc"

      def install
        bin.install "rpk"
        generate_completions_from_executable(bin/"rpk", "generate", "shell-completion", base_name: "rpk")
      end
    end
  end

  def caveats
    <<~EOS
      Redpanda Keeper (rpk) is Redpanda's command line interface (CLI)
      utility. The rpk commands let you configure, manage, and tune
      Redpanda clusters. They also let you manage topics, groups,
      and access control lists (ACLs).
      Start a three-node docker cluster locally:

          rpk container start -n 3

      Interact with the cluster using commands like:

          rpk topic list

      When done, stop and delete the docker cluster:

          rpk container purge

      For more examples and guides, visit: https://docs.redpanda.com
    EOS
  end
end
