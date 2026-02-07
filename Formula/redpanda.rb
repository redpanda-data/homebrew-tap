# typed: false
# frozen_string_literal: true

# This file was generated from a template file redpanda.rb.tmpl. DO NOT EDIT.
class Redpanda < Formula
  desc "Redpanda CLI & toolbox"
  homepage "https://redpanda.com"
  version "25.3.7"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.3.7/rpk-darwin-amd64.zip"
      sha256 "6bc30d5e6aa2ec2c8b019dea810094f84d83564e06229d875dd6e8519b1ae51f"
    end
    if Hardware::CPU.arm?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.3.7/rpk-darwin-arm64.zip"
      sha256 "bcaf4f390213fa079d9c05ea7a3b52b12d947bbd9576434f4875e591d3129fb5"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.3.7/rpk-linux-arm64.zip"
      sha256 "5da6f9b4d14229f8251b15cef09d6258ab737b9abd1c5da52793ce57352a8484"
    end
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v25.3.7/rpk-linux-amd64.zip"
      sha256 "d3e1334ae72b54a9ef542432c80128891737d55dd66c3ab22937b79b43df598a"
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
