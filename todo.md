# To do
* handle locale
* support transforms that don't take args
    * field :x, :downcase, :upcase
    * field :y, date: "YYYY", string: "YY", lowercase :_
* have default date parsing return naive_datetimes
* support timezones (already handled I think - add tests)
* handle errors
* more thorough testing on data types (within transforms)
* write guides for the transformations
* remove need for primitive? call
* remove custom struct and map modules?
* explicitly handle all primitive types in transformer.ex
* provide good error handling when transformation atom is invalid
* documentation
    * process/app config for locale
    * available locales see Timex/priv/translations
    * document all supported type transformations
    * document built-in transformations
