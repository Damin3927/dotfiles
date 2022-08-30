package cmd

import (
	"fmt"
	"strings"

	"github.com/spf13/cobra"
)

func installBrewFormulae() error {
	brewFormulaeStdout, err := RunCommandSilently("brew", "list", "--formulae", "--full-name")
	if err != nil {
		return err
	}
	brewCasksStdout, err := RunCommandSilently("brew", "list", "--casks", "--full-name")
	if err != nil {
		return err
	}

	installedBrewFormulae := strings.Split(brewFormulaeStdout, "\n")
	installedBrewCasks := strings.Split(brewCasksStdout, "\n")
	installed := append(installedBrewFormulae, installedBrewCasks...)

	// Install brew formulae
	targetBrewFormulae, err := GetLinesOfFile("init/brew_formulae")
	if err != nil {
		return fmt.Errorf("Failed to read brew_formulae: %v", err)
	}
	ignoreFiles, err := GetLinesOfFile("init/.installignore")
	if err != nil {
		return fmt.Errorf("Failed to read .installignore: %v", err)
	}

	for _, formula := range targetBrewFormulae {
		if Contains(ignoreFiles, formula) {
			fmt.Printf("%s is marked to be skipped.\n", formula)
			continue
		}

		if Contains(installed, formula) {
			fmt.Printf("%s is already installed. Skipped.\n", formula)
			continue
		}

		fmt.Printf("### Installing %s ###\n", formula)
		err := RunCommandInShell("brew", "install", formula)
		if err != nil {
			return fmt.Errorf("Failed to install %s: %v", formula, err)
		}
		fmt.Printf("Installed %s!\n", formula)
	}

	return nil
}

func installOtherPkgs() error {
	files, err := ListFiles(initDir)
	if err != nil {
		return fmt.Errorf("Failed to list files: %v", err)
	}

	for _, fileInfo := range files {
		if Contains(ignoreFiles, fileInfo.Name()) {
			continue
		}

		if !fileInfo.IsDir() {
			continue
		}

		if IsInstalled(fileInfo.Name()) {
			fmt.Printf("%s is already installed. Skipped.\n", fileInfo.Name())
			continue
		}

		filename := fmt.Sprintf("%s/%s/install.sh", initDir, fileInfo.Name())
		fmt.Printf("### Installing %s ... ###\n", fileInfo.Name())
		err := RunCommandInShell("bash", filename)
		if err != nil {
			return fmt.Errorf("Failed to run %s: %v", filename, err)
		}
		fmt.Printf("Installed %s!\n", fileInfo.Name())
	}
	return nil
}

func installPkgs() error {
	if err := installBrewFormulae(); err != nil {
		return fmt.Errorf("Brew formulae installation failed: %v", err)
	}
	if err := installOtherPkgs(); err != nil {
		return fmt.Errorf("Other package installation failed: %v", err)
	}

	return nil
}

var installPkgsCmd = &cobra.Command{
	Use:   "install-pkgs",
	Short: "Package installer",
	Long:  `Package installer`,
	RunE: func(cmd *cobra.Command, args []string) error {
		fmt.Println("Installing required packages...")
		err := installPkgs()
		if err != nil {
			return fmt.Errorf("Failed to install packages: %v", err)
		}
		fmt.Println("Finished installing required packages.")
		return nil
	},
}

func init() {
	rootCmd.AddCommand(installPkgsCmd)
}
