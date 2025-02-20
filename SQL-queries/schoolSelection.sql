-- Column headers:
<th>LASID</th>
<th>Last</th>
<th>First</th>
<th>HRTeacher</th>
<th>HR</th>
<th>GL</th>
<th>BarCode</th>

-- SQL query:
-- Using asci characters to build the html tags
with chars as (
    select 
        chr(60) oB, 
        chr(62) cB, 
        chr(34) dQ, 
        chr(39) sQ, 
        chr(59) sC, 
        chr(58) C, 
        chr(47) fS 
    from dual
),
tags as (
    select 
        oB || 'table' || cB TBL, 
        oB || 'tr' || cB TR, 
        oB || 'th' || cB TH, 
        oB || 'td' || cB TD,
        oB || fS || 'table' || cB eTBL, 
        oB || fS || 'tr' || cB eTR, 
        oB || fS || 'th' || cB eTH, 
        oB || fS || 'td' || cB eTD
    from chars
)

-- Main query
select st.student_number,
st.last_name, 
st.first_name,
US.homeroom_teacher,
st.home_room,
st.grade_level,
oB || 'div class=' || dQ || 'libre-barcode-39-regular-LPS' || dQ || cB || '*' || st.student_number || '*' || oB || '/div' || cB as Barcode
-- translates to: < class="libre-barcode-39-regular-LPS">*st.student_number*</div>

from students st
left join U_def_ext_students US ON st.dcid=us.studentsdcid
LEFT OUTER JOIN StudentCoreFields ON st.dcid = StudentCoreFields.studentsdcid
inner join tags on 1=1
inner join chars on 1=1
where st.enroll_status in (0,-1) and st.schoolid=~(curschoolid)
order by st.last_name