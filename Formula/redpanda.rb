# typed: false
# frozen_string_literal: true

# This file was generated from a template file redpanda.rb.tmpl. DO NOT EDIT.
class Redpanda < Formula
  desc "Redpanda CLI & toolbox"
  homepage "https://redpanda.com"
  version "26.2.4"

  on_macos do
    if Hardware::CPU.intel?
      url "https://rpk.redpanda.com/v26.2.4/rpk-darwin-amd64.zip"
      sha256 "59c220ea3c50d03857a7260f923669ea1804d2fec1c3c8c0e93717e221ab1b29"
    end
    if Hardware::CPU.arm?
      url "https://rpk.redpanda.com/v26.2.4/rpk-darwin-arm64.zip"
      sha256 "0a1e51b8f44bbf8998647711a176b4bf05738ec14e67f7ba5bdc72b24a8103f1"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://rpk.redpanda.com/v26.2.4/rpk-linux-arm64.zip"
      sha256 "d28bce836536b8ee7896f5f0ba6ec8c07fa8798ce9dd92b4560eac4f0dd4ce64"
    end
    if Hardware::CPU.intel?
      url "https://rpk.redpanda.com/v26.2.4/rpk-linux-amd64.zip"
      sha256 "d35e58e43be071a800c61f4a379c6c38c857b2e0e11c91f8fc83691f3b34d78f"
    end
  end

  head do
    url "https://github.com/redpanda-data/redpanda.git", branch: "dev"
    depends_on "go" => :build
  end

  def install
    if build.head?
      head_rev = Utils.git_short_head
      cd "src/go/rpk" do
        go_bin = Formula["go"].opt_bin/"go"
        ldflags = %W[
          -s -w
          -X github.com/redpanda-data/redpanda/src/go/rpk/pkg/cli/version.buildTime=#{time.iso8601}
          -X github.com/redpanda-data/redpanda/src/go/rpk/pkg/cli/version.rev=#{head_rev}
          -X github.com/redpanda-data/redpanda/src/go/rpk/pkg/cli/version.version=#{version}
        ]
        system go_bin, "build", *std_go_args(output: bin/"rpk", ldflags:), "./cmd/rpk"
      end
    else
      bin.install "rpk"
    end
    generate_completions_from_executable(bin/"rpk", "generate", "shell-completion", base_name: "rpk")
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
