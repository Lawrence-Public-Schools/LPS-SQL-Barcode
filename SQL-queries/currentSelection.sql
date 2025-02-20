-- Column headers:
<th>LASID</th>
<th>Last</th>
<th>First</th>
<th>HRTeacher</th>
<th>HR</th>
<th>GL</th>
<th>BarCode</th>

-- SQL query:
-- Using ASCII characters to build the HTML tags
WITH chars AS (
    SELECT 
        chr(60) AS oB, 
        chr(62) AS cB, 
        chr(34) AS dQ, 
        chr(39) AS sQ, 
        chr(59) AS sC, 
        chr(58) AS C, 
        chr(47) AS fS 
    FROM dual
), tags AS (
    SELECT 
        oB || 'table' || cB AS TBL, 
        oB || 'tr' || cB AS TR, 
        oB || 'th' || cB AS TH, 
        oB || 'td' || cB AS TD,
        oB || fS || 'table' || cB AS eTBL, 
        oB || fS || 'tr' || cB AS eTR, 
        oB || fS || 'th' || cB AS eTH, 
        oB || fS || 'td' || cB AS eTD
    FROM chars
)

-- Main query
SELECT 
    st.student_number,
    st.last_name, 
    st.first_name,
    US.homeroom_teacher,
    st.home_room,
    st.grade_level,
    oB || 'div class=' || dQ || 'libre-barcode-39-regular-LPS' || dQ || cB || '*' || st.student_number || '*' || oB || '/div' || cB AS Barcode
    -- translates to: <div class="libre-barcode-39-regular-LPS">*st.student_number*</div>

from students st
INNER JOIN ~[temp.table.current.selection:students] stusel ON stusel.dcid=st.dcid 
left join U_def_ext_students US ON st.dcid=us.studentsdcid
LEFT OUTER JOIN StudentCoreFields ON st.dcid = StudentCoreFields.studentsdcid
inner join tags on 1=1
inner join chars on 1=1
order by st.last_name