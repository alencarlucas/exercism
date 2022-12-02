// Package weather documentation maneirinho.
package weather

// CurrentCondition defines the current condition.
var CurrentCondition string
// CurrentLocation defines the current location.
var CurrentLocation string

// Forecast returns the weather condition to a specific location.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
