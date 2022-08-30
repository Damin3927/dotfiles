package cmd

import (
	"fmt"
	"os/exec"
	"strings"

	"github.com/spf13/cobra"
)

func runCommand(name string, args ...string) (string, error) {
	stdout, err := exec.Command(name, args...).Output()
	if err != nil {
		return "", fmt.Errorf("Failed to run command %s: %v", name, err)
	}

	return string(stdout), nil
}

func installPkgs() error {
	brewFormulaeStdout, err := runCommand("brew", "list", "--formulae")
	if err != nil {
		return err
	}

	brewFormulae := strings.Split(brewFormulaeStdout, "\n")
	fmt.Println(brewFormulae)

	// Install brew formulae

	// stdout, err := runCommand("bash", "./bootstrap.sh")
	// fmt.Println(string(stdout))
	return err
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
