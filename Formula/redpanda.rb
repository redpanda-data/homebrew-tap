# typed: false
# frozen_string_literal: true

# This file was generated from a template file redpanda.rb.tmpl. DO NOT EDIT.
class Redpanda < Formula
  desc "Redpanda CLI & toolbox"
  homepage "https://redpanda.com"
  version "26.1.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v26.1.2/rpk-darwin-amd64.zip"
      sha256 "f2287266f90e84ec3f487d61c52a1f3c70e57910ef5a2444b647c2232acbfca9"
    end
    if Hardware::CPU.arm?
      url "https://github.com/redpanda-data/redpanda/releases/download/v26.1.2/rpk-darwin-arm64.zip"
      sha256 "fba002888e78eb5c766fe4d1e1b88b36d45bd537fd52061a0b050ed67f421ac3"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/redpanda-data/redpanda/releases/download/v26.1.2/rpk-linux-arm64.zip"
      sha256 "48c15f6a983488c7b4bf52140aec4729f6e9ee3c6db57eff1809bc1f7b0fef5e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/redpanda-data/redpanda/releases/download/v26.1.2/rpk-linux-amd64.zip"
      sha256 "612f58eb7619e546526485ae9870f2e4205ba810c82dad2807f375fd8ab023fc"
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
