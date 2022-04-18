module gocon.cafe

go 1.18

replace (
	brazil.farm => ../brazil-farm
	colombia.farm => ../colombia-farm
	uk.farm => ../uk-farm
)

require (
	brazil.farm v0.0.0-00010101000000-000000000000
	colombia.farm v0.0.0-00010101000000-000000000000
	uk.farm v0.0.0-00010101000000-000000000000
)
