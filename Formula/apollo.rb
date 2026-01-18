class Apollo < Formula
  desc "AI coding assistant that lives in your terminal - Illuminating your code"
  homepage "https://github.com/i-luv-pho/testerpho01"
  url "https://github.com/i-luv-pho/testerpho01/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "55be991d7aa56fbd353518aa1f1edf91c6ea1688649e2c0c57da9ef4b089134a"
  license "MIT"
  version "1.0.1"

  depends_on "curl"
  depends_on "git"
  depends_on "jq"

  def install
    # Install all files to libexec
    libexec.install Dir["*"]

    # Create the apollo-setup command that runs the setup script
    (bin/"apollo-setup").write <<~EOS
      #!/bin/bash
      echo ""
      echo -e "\\033[1;32m    ___    ____  ____  __    __    ____\\033[0m"
      echo -e "\\033[1;32m   /   |  / __ \\/ __ \\/ /   / /   / __ \\\\033[0m"
      echo -e "\\033[1;32m  / /| | / /_/ / / / / /   / /   / / / /\\033[0m"
      echo -e "\\033[1;32m / ___ |/ ____/ /_/ / /___/ /___/ /_/ /\\033[0m"
      echo -e "\\033[1;32m/_/  |_/_/    \\____/_____/_____/\\____/\\033[0m"
      echo -e "\\033[0;36m        by Metamorphis Labs\\033[0m"
      echo ""
      cd "#{libexec}" && bash setup.sh "$@"
    EOS

    # Make it executable
    chmod 0755, bin/"apollo-setup"
  end

  def caveats
    <<~EOS

      \033[1;32m>>> Apollo has been installed!\033[0m

      To complete the setup, run:
        \033[1;32mapollo-setup\033[0m

      This will:
        - Install aichat (the CLI engine)
        - Set up llm-functions (tools)
        - Configure Apollo's personality
        - Create the 'apollo' command

      After setup, set your API key:
        \033[0;36mexport ANTHROPIC_API_KEY="your-key"\033[0m

      Then launch Apollo:
        \033[1;32mapollo\033[0m

      \033[2mIlluminating your code, one line at a time.\033[0m

    EOS
  end

  test do
    assert_predicate bin/"apollo-setup", :exist?
    assert_predicate bin/"apollo-setup", :executable?
  end
end
