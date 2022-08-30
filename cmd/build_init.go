package cmd

import (
	"bufio"
	"fmt"
	"io"
	"io/fs"
	"io/ioutil"
	"os"
	"strings"

	"github.com/spf13/cobra"
)

const initDir = "./init"

var ignoreFiles = []string{
	".DS_Store",
	"installer.sh",
	"brew_formulae",
	"README.md",
	"scaffold_tool_script.sh",
	".gitignore",
	".installignore",
	".installignore.example",
}

func Contains[K comparable](array []K, el K) bool {
	for _, candidate := range array {
		if candidate == el {
			return true
		}
	}

	return false
}

func listFiles(dir string) ([]fs.FileInfo, error) {
	return ioutil.ReadDir(dir)
}

func readLines(f io.Reader) []string {
	sc := bufio.NewScanner(f)
	sc.Split(bufio.ScanLines)

	result := []string{}
	for sc.Scan() {
		result = append(result, sc.Text())
	}
	return result
}

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

func writeToFile(f io.Writer, lines []string) error {
	data := []byte(strings.Join(lines, "\n"))
	_, err := f.Write(data)
	return err
}

func buildInit() error {
	files, err := listFiles(initDir)
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

		var filename string
		if fileInfo.IsDir() {
			filename = fmt.Sprintf("%s/%s/init.sh", initDir, fileInfo.Name())
		} else {
			filename = fmt.Sprintf("%s/%s", initDir, fileInfo.Name())
		}

		file, err := os.Open(filename)
		defer file.Close()
		if err != nil {
			return fmt.Errorf("failed to load: %s", file.Name())
		}

		lines := readLines(file)
		resultScript = appendScript(fileInfo.Name(), resultScript, lines)

	}

	file, err := os.Create("zsh/generated_init.zsh")
	if err != nil {
		return fmt.Errorf("Failed to create file zsh/generated_init.zsh: %v", err)
	}
	if err := writeToFile(file, resultScript); err != nil {
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
