package cmd

import (
	"bufio"
	"fmt"
	"io"
	"io/fs"
	"io/ioutil"
	"os"
	"os/exec"
	"strings"
)

var ignoreFiles = []string{
	".DS_Store",
	"brew_formulae",
	"README.md",
	"scaffold_tool_script.sh",
	".gitignore",
	".installignore",
	".installignore.example",
}

const initDir = "./init"

func Contains[K comparable](array []K, el K) bool {
	for _, candidate := range array {
		if candidate == el {
			return true
		}
	}

	return false
}

func ListFiles(dir string) ([]fs.FileInfo, error) {
	return ioutil.ReadDir(dir)
}

func ReadLines(f io.Reader) []string {
	sc := bufio.NewScanner(f)
	sc.Split(bufio.ScanLines)

	result := []string{}
	for sc.Scan() {
		result = append(result, sc.Text())
	}
	return result
}

func GetLinesOfFile(name string) ([]string, error) {
	file, err := os.Open(name)
	defer file.Close()
	if err != nil {
		return nil, fmt.Errorf("Failed to open file %s: %v", name, err)
	}
	lines := ReadLines(file)
	return lines, nil
}

func WriteToFile(f io.Writer, lines []string) error {
	data := []byte(strings.Join(lines, "\n"))
	_, err := f.Write(data)
	return err
}

func RunCommandSilently(name string, args ...string) (string, error) {
	stdout, err := exec.Command(name, args...).Output()
	if err != nil {
		return "", fmt.Errorf("Failed to run command %s: %v", name, err)
	}

	return string(stdout), nil
}

func RunCommandInShell(name string, args ...string) error {
	cmd := exec.Command(name, args...)
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	err := cmd.Run()
	if err != nil {
		return fmt.Errorf("Failed to run command %s: %v", name, err)
	}

	return nil
}

func Exists(filename string) bool {
	_, err := os.Stat(filename)
	return err == nil
}

func IsInstalled(initDir, executable string) bool {
	_, err := RunCommandSilently("command", "-v", executable)
	if err == nil {
		return true
	}

	installCheckerPath := fmt.Sprintf("%s/%s/install_checker.sh", initDir, executable)
	if Exists(installCheckerPath) {
		_, err := RunCommandSilently("bash", "-c", fmt.Sprintf("source %s/%s/install_checker.sh && is_%s_installed", initDir, executable, executable))
		if err == nil {
			return true
		}
	}

	return false
}
