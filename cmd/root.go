/*
Copyright © 2024 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"fmt"
	"os"
	"strings"

	"github.com/spf13/cobra"
)

// Declare global variables
var name string
var language string

var rootCmd = &cobra.Command{
	Use:   "gocli",
	Short: "A small go cli to generate multiple greeting languages and greet the user by their name.",
	Long:  `A small go cli to generate multiple greeting languages and greet the user by their name.`,
	Run: func(cmd *cobra.Command, args []string) {
		greet(name, language)
	},
}

func Execute() {
	err := rootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}

func init() {
	rootCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
	rootCmd.Flags().StringVarP(&name, "name", "n", "", "Name to greet")
	rootCmd.Flags().StringVarP(&language, "language", "l", "", "Language for greeting")
}

func greet(name string, language string) {
	// Lists of greeting language
	greetings := map[string]string{
		"english":  "Hello",
		"spanish":  "Hola",
		"french":   "Bonjour",
		"german":   "Hallo",
		"italian":  "Ciao",
		"japanese": "こんにちは (Konnichiwa)",
		"korean":   "안녕하세요 (Annyeonghaseyo)",
		"chinese":  "你好 (Nǐ hǎo)",
		"hindi":    "नमस्ते (Namaste)",
		"arabic":   "مرحبا (Marhaba)",
	}

	greeting, exists := greetings[strings.ToLower(language)]

	if !exists {
		greeting = "Hello"
	}

	if name == "" {
		fmt.Println(greeting + " World!")
	} else {
		fmt.Printf("%s %s!\n", greeting, name)
	}
}
