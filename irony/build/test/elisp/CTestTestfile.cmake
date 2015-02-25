# CMake generated Testfile for 
# Source directory: /home/strannik/.emacs.d/elpa/irony-20150202.1453/server/test/elisp
# Build directory: /home/strannik/.emacs.d/irony/build/test/elisp
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
ADD_TEST(irony-el "/usr/local/bin/emacs" "-batch" "-l" "package" "--eval" "(package-initialize) (unless (require 'cl-lib nil t) (package-refresh-contents) (package-install 'cl-lib))" "-l" "/home/strannik/.emacs.d/elpa/irony-20150202.1453/server/test/elisp/irony.el" "-f" "ert-run-tests-batch-and-exit")
ADD_TEST(irony-cdb-json-el "/usr/local/bin/emacs" "-batch" "-l" "package" "--eval" "(package-initialize) (unless (require 'cl-lib nil t) (package-refresh-contents) (package-install 'cl-lib))" "-l" "/home/strannik/.emacs.d/elpa/irony-20150202.1453/server/test/elisp/irony-cdb-json.el" "-f" "ert-run-tests-batch-and-exit")
