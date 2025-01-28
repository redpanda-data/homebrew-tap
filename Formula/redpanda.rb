# typed: false
# frozen_string_literal: true

# This file was generated from a template file redpanda.rb.tmpl. DO NOT EDIT.
class Redpanda < Formula
  desc "Redpanda CLI & toolbox"
  homepage "https://redpanda.com"
  version "24.3.4"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v24.3.4/rpk-darwin-amd64.zip"
      sha256 "a65cf9f2e157e598286728e5be4744555171c524665b8ee26fc2c6aa71a4e951"

      def install
        bin.install "rpk"
        generate_completions_from_executable(bin/"rpk", "generate", "shell-completion", base_name: "rpk")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/redpanda-data/redpanda/releases/download/v24.3.4/rpk-darwin-arm64.zip"
      sha256 "6ee34f758375e15080c94f692ba3c955fff996f09b09bf470c2a4eadcc2e1f20"

      def install
        bin.install "rpk"
        generate_completions_from_executable(bin/"rpk", "generate", "shell-completion", base_name: "rpk")
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/redpanda-data/redpanda/releases/download/v24.3.4/rpk-linux-arm64.zip"
      sha256 "aea97794c13c83043c4b21c579778f170716a9ea9e2765e14e9fa005b94711af"

      def install
        bin.install "rpk"
        generate_completions_from_executable(bin/"rpk", "generate", "shell-completion", base_name: "rpk")
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v24.3.4/rpk-linux-amd64.zip"
      sha256 "3a17ba27dba45bcd9cf421e40b1d4694cde6adf8ab4ab3c1ce8f76a9ca2cd7af"

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
