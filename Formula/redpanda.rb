class Redpanda < Formula
    desc "Redpanda CLI & toolbox"
    homepage "https://redpanda.com"
    url "https://github.com/redpanda-data/redpanda/releases/download/v22.2.2/rpk-darwin-amd64.zip"
    version "22.2.2"
    sha256 "7fb07b933bcbfc16a1f02b815b47a70a62ecee303aa92a9c03c6119c70219319"

    def install
        bin.install "rpk"
    end

    def caveats; <<~EOS
        Redpanda - The fastest queue in the west!

        This installs RPK which, with Docker, enables the running of a local cluster 
        for testing purposes.

        Start a three-node cluster locally:

            rpk container start -n 3
        
        Interact with the cluster using commands like:

            rpk topic list
        
        When done, stop and delete the cluster:
            
            rpk container purge

        For more examples and guides, visit: https://docs.redpanda.com/
    EOS
    end
end
