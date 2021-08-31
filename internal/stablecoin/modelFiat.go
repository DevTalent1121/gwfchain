package stablecoin

type Fiat struct {
	Continent string
	Name      string
	history   Means
}

func NewFiat(cont, name string) *Fiat {
	result := &Fiat{Continent: cont, Name: name, history: *NewMeans()}
	return result
}

func (m *Fiat) Update(price float64, blockNumber int64) (err error) {
	// if price > 0.0 {
	// 	newMeans := &Means{}
	// }

	return nil
}
