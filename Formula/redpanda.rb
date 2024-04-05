# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Redpanda < Formula
  desc "Redpanda CLI & toolbox"
  homepage "https://redpanda.com"
  version "23.3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/redpanda-data/redpanda/releases/download/v23.3.11/rpk-darwin-arm64.zip"
      sha256 "66697fb82ee3e2a920439e0faa7a69bd95a02ca03feaf68337985783e3fc6f84"

      def install
        bin.install "rpk"
        generate_completions_from_executable(bin/"rpk", "generate", "shell-completion", base_name: "rpk")
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v23.3.11/rpk-darwin-amd64.zip"
      sha256 "716fe61be39a5a87e2d9d5f7f532bfaca1050eff7c8175e82170fcdb3e07f480"

      def install
        bin.install "rpk"
        generate_completions_from_executable(bin/"rpk", "generate", "shell-completion", base_name: "rpk")
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/redpanda-data/redpanda/releases/download/v23.3.11/rpk-linux-arm64.zip"
      sha256 "7348e7bb5794e2862c88cc584c9c543c1649f9d28d9b15e746a2e8a221e21e21"

      def install
        bin.install "rpk"
        generate_completions_from_executable(bin/"rpk", "generate", "shell-completion", base_name: "rpk")
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v23.3.11/rpk-linux-amd64.zip"
      sha256 "543cbd1d1c15393bd52e47b2d2e9d5e39871b4069735845abf0d106f2fd2f260"

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
