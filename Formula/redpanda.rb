# typed: false
# frozen_string_literal: true

# This file was generated from a template file redpanda.rb.tmpl. DO NOT EDIT.
class Redpanda < Formula
  desc "Redpanda CLI & toolbox"
  homepage "https://redpanda.com"
  version "25.2.7"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.2.7/rpk-darwin-amd64.zip"
      sha256 "6942e9e8973ce6dfb0ee7463082c3470d71e04c0e82ffefc2549eaeac72a8f5e"

      def install
        bin.install "rpk"
        generate_completions_from_executable(bin/"rpk", "generate", "shell-completion", base_name: "rpk")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.2.7/rpk-darwin-arm64.zip"
      sha256 "c84f433efd97bd56abd6948ab64de97e4fcd6dc198cfb0e3fa2e5e9bc4e2ca95"

      def install
        bin.install "rpk"
        generate_completions_from_executable(bin/"rpk", "generate", "shell-completion", base_name: "rpk")
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.2.7/rpk-linux-arm64.zip"
      sha256 "4f8e6fa0e0a8cd7f77b31beeb02698c4dc1bfba4d5212c6931c83212f529641d"

      def install
        bin.install "rpk"
        generate_completions_from_executable(bin/"rpk", "generate", "shell-completion", base_name: "rpk")
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.2.7/rpk-linux-amd64.zip"
      sha256 "29ddadc72f36e3dda705e3d5cb24bcded98ff90053211cf0fe4284889151a00a"

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
