# typed: false
# frozen_string_literal: true

# This file was generated from a template file redpanda.rb.tmpl. DO NOT EDIT.
class Redpanda < Formula
  desc "Redpanda CLI & toolbox"
  homepage "https://redpanda.com"
  version "25.1.4"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.1.4/rpk-darwin-amd64.zip"
      sha256 "2e79fa4f00490dd40638822c4b9267171e2a11e9d6f770610a62ac860e22f62e"

      def install
        bin.install "rpk"
        generate_completions_from_executable(bin/"rpk", "generate", "shell-completion", base_name: "rpk")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.1.4/rpk-darwin-arm64.zip"
      sha256 "a87e2ddf6e3754fdc45a56d5f322d6eaaa312d0665b8b55e504b21180f81f77b"

      def install
        bin.install "rpk"
        generate_completions_from_executable(bin/"rpk", "generate", "shell-completion", base_name: "rpk")
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.1.4/rpk-linux-arm64.zip"
      sha256 "cc2f3050fb212649afc91ca97edb78208130d9d7f29455e3b8fea953008dbd63"

      def install
        bin.install "rpk"
        generate_completions_from_executable(bin/"rpk", "generate", "shell-completion", base_name: "rpk")
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.1.4/rpk-linux-amd64.zip"
      sha256 "4ba281ad6c15a06b42c96292c38ebcf78047eba9d64d1b40ecb4b6f2afb40184"

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
