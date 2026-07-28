# typed: false
# frozen_string_literal: true

# This file was generated from a template file redpanda.rb.tmpl. DO NOT EDIT.
class Redpanda < Formula
  desc "Redpanda CLI & toolbox"
  homepage "https://redpanda.com"
  version "26.2.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v26.2.1/rpk-darwin-amd64.zip"
      sha256 "b3902795ac2bc5ef2ca980bbceeb9888aa6bd2d3d155f85914f65a9d7b273af3"
    end
    if Hardware::CPU.arm?
      url "https://github.com/redpanda-data/redpanda/releases/download/v26.2.1/rpk-darwin-arm64.zip"
      sha256 "b457057ca2e2c3da28f191a4662c532130a1c478d20071e9422942e6488e8d78"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/redpanda-data/redpanda/releases/download/v26.2.1/rpk-linux-arm64.zip"
      sha256 "64de1d45b566759596cc4a788d8594ebc1842fef59d47547065944e4382ed46f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v26.2.1/rpk-linux-amd64.zip"
      sha256 "11cb33c1ece559f44789d422d1b3bfa353e835ff9489d1ecd2ea5f438316b7ad"
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
