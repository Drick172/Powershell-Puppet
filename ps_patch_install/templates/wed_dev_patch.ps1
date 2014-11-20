$WeekDay='Tuesday'
[datetime]$Today=[datetime]::NOW
$todayM=$Today.Month.ToString()
$todayY=$Today.Year.ToString()
[datetime]$StrtMonth=$todayM+'/1/'+$todayY
while ($StrtMonth.DayofWeek -ine $WeekDay ) { $StrtMonth=$StrtMonth.AddDays(1) }
$WedDevPatchDay = $StrtMonth.AddDays(8)

if ($WedDevPatchDay -eq (get-date -format d)) {WUInstall -Category 'Security', 'Critical', 'Rollup', 'Important' -AcceptAll -AutoReboot}
