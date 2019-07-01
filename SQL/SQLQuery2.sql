select * from [ELicense_SF].[dbo].[Roster_1_4_19] as r join
[NPI].[dbo].[NPI_Dist_Lic] as d on r.Number =
case 
	when len(d.License_Number) > 8  then STUFF(d.License_Number , 3, 1, '.')
	when d.License_Number LIKE '__-%' then STUFF(d.License_Number , 3, 1, '.')
	when len(ltrim(coalesce(d.License_Number,''))) = 0 then replace(d.License_Number, ' ', '')
	else d.License_Number
end
where (r."Parcel State" = 'OH' or r."Parcel State" = 'Ohio')
and r.Type in ('Doctor of Medicine (MD)','Telemedicine (DO)','Telemedicine (MD)','Doctor of Osteopathic Medicine (DO)',
'Physician Assistant (PA)','Training Certificate (MD)','Training Certificate (DO)') ;


select case 
	when len(d.License_Number) > 8  then STUFF(d.License_Number , 3, 1, '.')
	when d.License_Number LIKE '__-%' then STUFF(d.License_Number , 3, 1, '.')
	when len(ltrim(coalesce(d.License_Number,''))) = 0 then replace(d.License_Number, ' ', '')
	else d.License_Number
end, NPI, License_State from [ELicense_SF].[dbo].[Roster_1_4_19] as r join
[NPI].[dbo].[NPI_Dist_Lic] as d on r.Number = d.License_Number

where (r."Parcel State" = 'OH' or r."Parcel State" = 'Ohio')
and r.Type in ('Doctor of Medicine (MD)','Telemedicine (DO)','Telemedicine (MD)','Doctor of Osteopathic Medicine (DO)',
'Physician Assistant (PA)','Training Certificate (MD)','Training Certificate (DO)') ;