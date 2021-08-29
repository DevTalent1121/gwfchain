package stablecoin

const (
	FIAT_COUNT = 15 // number of fiats to base price off
)

type GWFStableCoin struct {
	fiats []*Fiat
}

func NewGWFStableCoin() *GWFStableCoin {
	result := &GWFStableCoin{}
	result.GWFStableCoin()
	return result
}

func (m *GWFStableCoin) GWFStableCoin() {
	// - Asia
	//     - KUWAITI DINAR
	//     - BAHRAINI DINAR
	//     - OMANI RIYAL
	m.fiats[0] = NewFiat("Asia", "Kuwaiti Dinar")
	m.fiats[1] = NewFiat("Asia", "Bahraini Dinar")
	m.fiats[2] = NewFiat("Asia", "Omani Riyal")

	// - Africa
	//     - Libyan Dinar
	//     - Tunisian Dinar
	//     - Ghanaian Cedi
	m.fiats[3] = NewFiat("Africa", "Libyan Dinar")
	m.fiats[4] = NewFiat("Africa", "Tunisian Dinar")
	m.fiats[5] = NewFiat("Africa", "Ghanaian Cedi")

	// - Europe
	//     - European euro
	//     - Switzerland Swiss franc
	//     - Russia Russian ruble
	m.fiats[6] = NewFiat("Europe", "European euro")
	m.fiats[7] = NewFiat("Europe", "Switzerland Swiss franc")
	m.fiats[8] = NewFiat("Europe", "Russia Russian ruble")

	// - North America
	//     - USA
	//     - Canada
	//     - Mexico
	m.fiats[9] = NewFiat("North America", "United States Dollar")
	m.fiats[10] = NewFiat("North America", "Canada")
	m.fiats[11] = NewFiat("North America", "Mexico Peso")

	// - South America
	//     - Brazilian real
	//     - Bolivian boliviano
	//     - Guatemalan quetzal
	m.fiats[12] = NewFiat("South America", "Brazilian real")
	m.fiats[13] = NewFiat("South America", "Bolivian boliviano")
	m.fiats[14] = NewFiat("South America", "Guatemalan quetzal")
}
