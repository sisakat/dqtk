cat header.txt  | awk '{print "-- " $0}' >  dq.sql
cat LICENSE | awk '{print "-- " $0}' >> dq.sql
echo >> dq.sql
cat drops.sql >> dq.sql
echo >> dq.sql
cat dq_quote.sql >> dq.sql
echo >> dq.sql
cat dq_letter.sql >> dq.sql
echo >> dq.sql
cat dq_extract.sql >> dq.sql
echo >> dq.sql
cat dq_apply_quoted.sql >> dq.sql
echo >> dq.sql
cat dq_apply.sql >> dq.sql
echo >> dq.sql
cat dq_sp_apply.sql >> dq.sql