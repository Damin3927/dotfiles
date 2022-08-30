package cmd

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

func createDefaultScript(name string) error {
	file, err := os.Create(name)
	if err != nil {
		return fmt.Errorf("Failed to create init/%s/init.sh: %v", name, err)
	}

	if err := WriteToFile(file, []string{
		"#!/bin/bash",
		"",
	}); err != nil {
		return fmt.Errorf("Failed to initialize %s: %v", name, err)
	}

	return nil
}

func scaffold(name string) error {
	if err := os.Mkdir(fmt.Sprintf("init/%s", name), 0777); err != nil {
		return fmt.Errorf("Failed to create init/%s: %v", name, err)
	}

	if err := createDefaultScript(fmt.Sprintf("init/%s/init.sh", name)); err != nil {
		return err
	}
	if err := createDefaultScript(fmt.Sprintf("init/%s/install.sh", name)); err != nil {
		return err
	}

	return nil
}

var scaffoldCmd = &cobra.Command{
	Use:   "scaffold",
	Short: "Init script scaffolder",
	Long:  `Init script scaffolder`,
	Args:  cobra.ExactArgs(1),
	RunE: func(cmd *cobra.Command, args []string) error {
		err := scaffold(args[0])
		if err != nil {
			return fmt.Errorf("Failed to scaffold init files: %v", err)
		}
		return nil
	},
}

func init() {
	rootCmd.AddCommand(scaffoldCmd)
}
