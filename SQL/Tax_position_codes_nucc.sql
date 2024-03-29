/****** Script for SelectTopNRows command from SSMS  ******/
select NPI, Taxonomy_Code, Primary_Taxonomy_Switch, Lic_pos, Classification, Specialization from
(select * from [dbo].[NPI_Tax]
where NPI in 
(SELECT tx.[NPI]
  FROM [NPI].[dbo].[NPI_tax_gt1] as gt1
  join NPI_Tax as tx on gt1.NPI = tx.NPI
  )) as NPI_lic_pos   /*group by tx.NPI having COUNT (*) >1*/

join [dbo].[nucc_taxonomy_190] nucc
on NPI_lic_pos.Taxonomy_Code = nucc.Code 
where Classification not like 'Student%' and (Classification != 'Hospitalist' or Primary_Taxonomy_Switch != 'Y')
order by NPI, Lic_pos