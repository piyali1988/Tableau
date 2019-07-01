

select distinct * into RosterNPIunmatched from [ELicense_SF].[dbo].[Roster_1_4_19] as sub
left join [NPI].[dbo].[NPI_Dist_Lic] as n 
on (SUBSTRING(REPLACE (sub.[Number],'.',''),1,9) = SUBSTRING(REPLACE(REPLACE(REPLACE (n.[License_Number],'-',''),'.',''),' ',''),1,9))
or (SUBSTRING(sub.Number,4,9) = n.License_Number)
or (SUBSTRING(sub.Number,4,9) = SUBSTRING(n.License_Number,3,8))
or (SUBSTRING(sub.Number,4,len(sub.Number)) = n.License_Number)
or (SUBSTRING(sub.Number,4,len(sub.Number)) = SUBSTRING(n.License_Number,3,len(n.License_Number)))
or (SUBSTRING(sub.Number,4,len(sub.Number)) = SUBSTRING(n.License_Number,4,len(n.License_Number)))
where (sub."Parcel State" = 'OH' or sub."Parcel State" = 'Ohio')
and sub.Type = 'Physician Assistant (PA)'
and n.NPI is Null