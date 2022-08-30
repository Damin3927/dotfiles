package cmd

import (
	"fmt"
	"os"
	"strings"

	"github.com/spf13/cobra"
)

func appendScript(name string, original, appendee []string) []string {
	hasShebang := false
	if strings.HasPrefix(appendee[0], "#!") {
		hasShebang = true
	}

	if (hasShebang && len(appendee) == 1) || (!hasShebang && len(appendee) == 0) {
		return original
	}

	result := append(original, fmt.Sprintf("### %s init script", name))

	// ignore shebang
	if hasShebang {
		result = append(result, appendee[1:]...)
	} else {
		result = append(result, appendee...)
	}

	result = append(result, "", "") // add 2 empty lines
	return result
}

func buildInit() error {
	files, err := ListFiles(initDir)
	if err != nil {
		return fmt.Errorf("Failed to list files: %v", err)
	}

	resultScript := []string{
		"# This script is generated automatically. DO NOT EDIT.",
	}

	for _, fileInfo := range files {
		if Contains(ignoreFiles, fileInfo.Name()) {
			continue
		}

		if !fileInfo.IsDir() {
			continue
		}

		filename := fmt.Sprintf("%s/%s/init.sh", initDir, fileInfo.Name())
		lines, err := GetLinesOfFile(filename)
		if err != nil {
			return fmt.Errorf("Failed to load: %s", err)
		}

		resultScript = appendScript(fileInfo.Name(), resultScript, lines)
	}

	file, err := os.Create("zsh/generated_init.zsh")
	if err != nil {
		return fmt.Errorf("Failed to create file zsh/generated_init.zsh: %v", err)
	}
	if err := WriteToFile(file, resultScript); err != nil {
		return fmt.Errorf("failed to write data to script: %v", err)
	}

	return nil
}

var buildInitCmd = &cobra.Command{
	Use:   "build-init",
	Short: "Init script builder",
	Long:  `Init script builder`,
	RunE: func(cmd *cobra.Command, args []string) error {
		fmt.Println("Building init files...")
		err := buildInit()
		if err != nil {
			return fmt.Errorf("Failed to build init files: %v", err)
		}
		fmt.Println("Finished building init files.")
		return nil
	},
}

func init() {
	rootCmd.AddCommand(buildInitCmd)
}
