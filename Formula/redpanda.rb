# typed: false
# frozen_string_literal: true

# This file was generated from a template file redpanda.rb.tmpl. DO NOT EDIT.
class Redpanda < Formula
  desc "Redpanda CLI & toolbox"
  homepage "https://redpanda.com"
  version "25.1.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.1.2/rpk-darwin-amd64.zip"
      sha256 "cadf1c24cfbc627eb623239e007186d935eb38633353214991c5aaf428c752e1"

      def install
        bin.install "rpk"
        generate_completions_from_executable(bin/"rpk", "generate", "shell-completion", base_name: "rpk")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.1.2/rpk-darwin-arm64.zip"
      sha256 "ed7ebd0c9057cc17eb895b692f25ed63d2f7f4c6584e7db7324ea7fc615e8556"

      def install
        bin.install "rpk"
        generate_completions_from_executable(bin/"rpk", "generate", "shell-completion", base_name: "rpk")
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.1.2/rpk-linux-arm64.zip"
      sha256 "e621dc9de03a59c620586a6e047a9fec80df6ca52367d831e613f2d288569bbe"

      def install
        bin.install "rpk"
        generate_completions_from_executable(bin/"rpk", "generate", "shell-completion", base_name: "rpk")
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.1.2/rpk-linux-amd64.zip"
      sha256 "e5d76f9040c46ab24c685fa2111d9c54d5830b4d3741aac2250e59da4a560d59"

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
