
select * from
(select distinct * from [ELicense_SF].[dbo].[Roster_1_4_19] as r

left join [dbo].[Lic_cons_cord_td_mcd_cnty] as sf
on r.Number = sf.Name_License) as sub

where (sub."Parcel State" = 'OH' or sub."Parcel State" = 'Ohio')
and sub.Type in ('Doctor of Medicine (MD)','Telemedicine (DO)','Telemedicine (MD)','Doctor of Osteopathic Medicine (DO)',
'Physician Assistant (PA)','Training Certificate (MD)','Training Certificate (DO)') 
and sub.Name_License is Null;




