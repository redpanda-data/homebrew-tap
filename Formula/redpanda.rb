# typed: false
# frozen_string_literal: true

# This file was generated from a template file redpanda.rb.tmpl. DO NOT EDIT.
class Redpanda < Formula
  desc "Redpanda CLI & toolbox"
  homepage "https://redpanda.com"
  version "26.1.8"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v26.1.8/rpk-darwin-amd64.zip"
      sha256 "662258d84aa22688b615af62ab2b354e77d4dd1a87aae4f3e5fe2bddd2b60c12"
    end
    if Hardware::CPU.arm?
      url "https://github.com/redpanda-data/redpanda/releases/download/v26.1.8/rpk-darwin-arm64.zip"
      sha256 "c6c2f2af6f35a6abdbccf6cf7f7561ed492f80ef76da1401a9b529d3087915ef"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/redpanda-data/redpanda/releases/download/v26.1.8/rpk-linux-arm64.zip"
      sha256 "4f0faa8b8723549abdeefff935214c05208bba99e0219168b43a3117c22ef4bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v26.1.8/rpk-linux-amd64.zip"
      sha256 "203099f08abe3aa0c2c247d2f11f396f7007effda5e63c70feae4c4cfceb989c"
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
