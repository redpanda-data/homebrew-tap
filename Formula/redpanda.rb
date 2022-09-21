class Redpanda < Formula
    desc "Redpanda CLI & toolbox"
    homepage "https://redpanda.com"
    url "https://github.com/redpanda-data/redpanda/releases/download/v22.2.3/rpk-darwin-amd64.zip"
    version "22.2.3"
    sha256 "3f75b96fd7e237e24ab6ac4a8f672d9ae6650a2cd902394054b4245d35a4aba9"

    def install
        bin.install "rpk"
    end

    def caveats; <<~EOS
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

        For more examples and guides, visit: https://docs.redpanda.com/
    EOS
    end
end
