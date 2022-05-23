class Redpanda < Formula
    desc "Fastest Queue in the West"
    homepage "https://www.redpanda.com"
    version "22.1.3"

    on_macos do
        if Hardware::CPU.arm?
            url "https://github.com/redpanda-data/redpanda/releases/download/v22.1.3/rpk-darwin-arm64.zip"
            sha256 "56dac79665f9a5606019cead4d51bbd955a46e2888b257e631e47cb0df4ff203"
        end
        if Hardware::CPU.intel?
            url "https://github.com/redpanda-data/redpanda/releases/download/v22.1.3/rpk-darwin-amd64.zip"
            sha256 "2956dcf87cc12055bc65545aa4269a034e2880af686f7e438a9caa2fa5a1854b"
        end
        def install
          bin.install "rpk"
        end
    end

    def caveats; <<~EOS
        Redpanda - The fastest queue in the west!

        This installs RPK which, with Docker, enables the running of a local cluster 
        for testing purposes.

        You can start a 3 node cluster locally using the following command: 

            rpk container start -n 3
        
        You can then interact with the cluster using commands like the following: 

            rpk topic list
        
        When done, you can stop and delete the cluster with the following command:
            
            rpk container purge

        For information on how to setup production evironments, check out our
        installation guide here: https://vectorized.io/documentation/setup-guide/
    EOS
    end
end
