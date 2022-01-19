package main

import (
	"net/http"
	"os"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {

	e := echo.New()

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/go", func(c echo.Context) error {
		return c.HTML(http.StatusOK, "Hello, stranger! <3")
	})

	e.GET("/go/ping", func(c echo.Context) error {
		return c.JSON(http.StatusOK, struct{ Status string }{Status: "pong"})
	})

	httpPort := os.Getenv("HTTP_PORT")
	if httpPort == "" {
		httpPort = "8081"
	}

	e.Logger.Fatal(e.Start(":" + httpPort))
}
