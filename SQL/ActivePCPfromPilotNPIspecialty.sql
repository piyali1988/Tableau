select * from
	(select distinct * from [ELicense_SF].[dbo].[Roster_1_4_19] as r

	join [dbo].[Lic_cons_cord_td_mcd_cnty] as sf
	on r.Number = sf.Name_License) as sub
	join [NPI].[dbo].[NPI_Tax] as tx on sub.NPI = tx.NPI
where (sub."Parcel State" = 'OH' or sub."Parcel State" = 'Ohio')
and sub.Type in ('Doctor of Medicine (MD)','Telemedicine (DO)','Telemedicine (MD)','Doctor of Osteopathic Medicine (DO)',
'Physician Assistant (PA)','Training Certificate (MD)','Training Certificate (DO)')
and (tx.Taxonomy_Code in ('367A00000X','363L00000X','364S00000X','363A00000X','207Q00000X','207RA0000X','207V00000X','208000000X','2080A0000X','
207R00000X','208D00000X','207RG0300X','207QA0000X','207QG0300X','2084P0804X','2084P0805X','2084P0800X')
and tx.Primary_Taxonomy_Switch = 'Y')
and Classification not like 'Student%' and (Classification != 'Hospitalist' or Primary_Taxonomy_Switch != 'Y');


select * from
	(select distinct * from [ELicense_SF].[dbo].[Roster_1_4_19] as r

	join [dbo].[Lic_cons_cord_td_mcd_cnty] as sf
	on r.Number = sf.Name_License) as sub
	join 
	(select NPI, Taxonomy_Code, Primary_Taxonomy_Switch, Lic_pos, Classification, Specialization from
		(select * from [NPI].[dbo].[NPI_Tax]
		where NPI in 
		(SELECT tax.[NPI]
		  FROM [NPI].[dbo].[NPI_tax_gt1] as gt1
		  join [NPI].[dbo].[NPI_Tax] as tax on gt1.NPI = tax.NPI
		  )) as NPI_lic_pos   /*group by tx.NPI having COUNT (*) >1*/

		join [NPI].[dbo].[nucc_taxonomy_190] nucc
		on NPI_lic_pos.Taxonomy_Code = nucc.Code
	) as tx on sub.NPI = tx.NPI
where (sub."Parcel State" = 'OH' or sub."Parcel State" = 'Ohio')
and sub.Type in ('Doctor of Medicine (MD)','Telemedicine (DO)','Telemedicine (MD)','Doctor of Osteopathic Medicine (DO)',
'Physician Assistant (PA)','Training Certificate (MD)','Training Certificate (DO)')
and (tx.Taxonomy_Code in ('367A00000X','363L00000X','364S00000X','363A00000X','207Q00000X','207RA0000X','207V00000X','208000000X','2080A0000X','
207R00000X','208D00000X','207RG0300X','207QA0000X','207QG0300X','2084P0804X','2084P0805X','2084P0800X')
and tx.Primary_Taxonomy_Switch = 'Y')
and tx.Classification not like 'Student%' and (tx.Classification != 'Hospitalist' or tx.Primary_Taxonomy_Switch != 'Y');

