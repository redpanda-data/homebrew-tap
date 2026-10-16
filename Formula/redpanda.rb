# typed: false
# frozen_string_literal: true

# This file was generated from a template file redpanda.rb.tmpl. DO NOT EDIT.
class Redpanda < Formula
  desc "Redpanda CLI & toolbox"
  homepage "https://redpanda.com"
  version "26.2.5"

  on_macos do
    if Hardware::CPU.intel?
      url "https://rpk.redpanda.com/v26.2.5/rpk-darwin-amd64.zip"
      sha256 "6cb234435712fc3a1214e32bc71773de62fcf7c857fdb5680c204953fab76168"
    end
    if Hardware::CPU.arm?
      url "https://rpk.redpanda.com/v26.2.5/rpk-darwin-arm64.zip"
      sha256 "c3aa66de100f75c04f7aefdcd0532fac8f0cefa784f38944e3089315b8c7cf18"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://rpk.redpanda.com/v26.2.5/rpk-linux-arm64.zip"
      sha256 "355e032c2e9d34e147d194bf8b4006b038f8a634fc933ddbd33d51a2dd355819"
    end
    if Hardware::CPU.intel?
      url "https://rpk.redpanda.com/v26.2.5/rpk-linux-amd64.zip"
      sha256 "d18c3ecb38a155abaf6abd756eb5dc4bb69668396819fa044de9ab56d8bbfc7e"
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
