# To do
## General
* support transforms that don't take args
    * field :x, :downcase, :upcase
    * field :y, date: "YYYY", string: "YY", lowercase :_
* handle errors - Timex returns strings Ecto does not
* remove need for primitive? call
* documentation
    * process/app config for locale
    * available locales see Timex/priv/translations
    * document built-in transformations
    * write guides for the transformations?

## Numbers
* support format/parse options
* handle decimal errors - will error when there is a loss of precision

## Dates & Times
* handle locales
* have default date parsing return naive_datetimes
* support timezones (already handled I think - add tests)
    * provide timezone when converting to DateTime

## Maps
* remove custom struct and map modules?
