\r
\uFFFD
\u0000FFFD

list_of_string_lists = <
	[1] = <
		[1] = <"first string in first list">
		[2] = <"second string in first list">
	>
	[2] = <
		[1] = <"first string in second list">
		[2] = <"second string in second list">
		[3] = <"third string in second list">
	>
	[3] = <
		[1] = <"only string in third list">
	>
>


/list_of_string_lists[1]/[2]
/list_of_string_lists[2]/[1]

/destinations["seville"]/hotels["gran sevilla"]
/destinations["seville"]/hotels["sofitel"]
/destinations["seville"]/hotels["hotel real"]

/bookings["seville:0134"]/customer_id
/bookings["seville:0134"]/period
/bookings["seville:0134"]/hotel

/hotels["sofitel"]
/hotels["hotel real"]
/hotels["gran sevilla"]

destinations = <
	["seville"] = <
		hotels = <
			["gran sevilla"] = </hotels["gran sevilla"]>
			["sofitel"]      = </hotels["sofitel"]>
			["hotel real"]   = </hotels["hotel real"]>
		>
	>
>


1919-01-23
16:35:04,5
2001-05-12T07:35:20+1000
P22D4TH15M0S
-- birthdate of Django Reinhardt
-- rise of Venus in Sydney on 24 Jul 2003
-- timestamp on an email received from Australia -- period of 22 days, 4 hours, 15 minutes


-- Partial dates/times
2020-08
22:10

2020-01-10T10:20
2020-01-10T10


2020-01-??
2020-??-??

12:33:??
12:??:??

2020-01-08T12:34:??
2020-01-08T12:??:??
2020-01-08T??:??:??
2020-01-??T??:??:??
2020-??-??T??:??:??


-- Intervals
|0..5.0|          -- integer interval
|0..5|            -- integer interval
|0.0..1000.0|     -- real interval
|0.0..<1000.0|    -- real interval 0.0 >= x < 1000.0
|08:02..09:10|    -- interval of time
|>= 1939-02-01|   -- open-ended interval of dates
|5.0 +/-0.5|      -- 4.5 - 5.5
|5.0 +/- 0.5|     -- 4.5 - 5.5
|>=0|             -- >=0
|0..infinity|     -- 0 - infinity (i.e. >= 0)

|0..-infinity|
|-Infinity..INFINITY|



-- URIs
http://openEHR.org/home
ftp://get.this.file.com?file=cats.doc#section_5
http://www.mozilla.org/products/firefox/upgrade/?application=thunderbird


-- Coded terms
[terminology_id::code]
[icd10AM::F60.1]                     -- from ICD10AM
[snomed_ct::2004950]                 -- from snomed-ct
[snomed_ct(3.1)::2004950]            -- from snomed-ct v 3.1


-- Lists
"cyan", "magenta", "yellow", "black" -- printer's colours
1, 1, 2, 3, 5                        -- first 5 fibonacci numbers
08:02, 08:35, 09:10                  -- set of train times

"en", ...      -- languages
"icd10", ...   -- terminologies
[at0200], ...


-- Paths
/term_definitions["en"]/items["at0001"]/text

items[1]
items["systolic"]
items["at0001"]


-- Plug-ins
definition = (cadl) <#
	ENTRY[at0000] ∈ { -- blood pressure measurement
		name ∈ {      -- any synonym of BP
			CODED_TEXT ∈ {
				code ∈ {
					CODE_PHRASE ∈ {[ac0001]}
				}
			}
		}
	}
#>


-- Schema
@schema = <http://something.com/>
