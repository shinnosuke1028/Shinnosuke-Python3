prompt
prompt Creating package PKG_MANAGE_SYSTEM_SHIN_PLUS8
prompt =============================================
prompt
CREATE OR REPLACE PACKAGE PKG_MANAGE_SYSTEM_SHIN_PLUS8 AUTHID CURRENT_USER AS
------------------------------------------------------------------------
  --  OVERVIEW
  --
  --  Oracle ���ݿ���������ͨ�ð�
  --
  --  OWNER:    Shinnosuke
  --
  --  VERSION:   3.4
  --
  --  CREATE DATE�� 2019/06/11 version 1.0
  --
  --  UPDATE DATE��2019/06/09 version 1.1
  --               1.������չ����--PROC_PARTITION_ADD_RANGE
  --               2.����ɾ�����ܣ���δ���ã� --PROC_PARTITION_DROP_RANGE 
  --
  --  UPDATE DATE��2019/06/13 version 1.2
  --               1.���ӷ���������--PROC_PARTITION_CLEANUP_RANGE
  --
  --  UPDATE DATE��2019/06/18 version 1.3
  --               1.���ӷ����Զ���չ����--PROC_PARTITION_ADD_AUTO
  --               2.���ӷ����Զ�������--PROC_PARTITION_CLEANUP_AUTO
  --
  --  UPDATE DATE��2019/06/19 version 1.4
  --               1.����������չ���ܣ�������/��
  --
  --  UPDATE DATE��2019/06/21 version 1.5
  --               1.����������չ���ܣ����ӷ�����ά����ڲ�����������/��/��
  --               2.�������������ܣ����ӷ�����ά����ڲ��� ��������/��/��
  --               3.���ӷ�����������Demo --TEST1�����޷����ؽ����ܣ�
  --  
  --  UPDATE DATE��2019/06/28 version 2.0
  --               1.���������Զ���չ���ܣ�������/��/��
  --               2.���������Զ������ܣ�������/��/��
  --
  --  UPDATE DATE��2019/06/28 version 2.1
  --               1.���ӷ�����������Demo --SQL_GET_DDL��������תģʽ�������ݣ�A �� W �� B��
  --               2.����������������Demo������ --SQL_GET_DDL_WK��������תģʽ�������ݣ�A �� WK_A ��(rename to) A��
  --               3.����������������Demo --SQL_GET_DDL_WK����δ���������ؽ��������湦�ܣ�
  --
  --  UPDATE DATE��2019/06/28 version 2.2
  --               1.����ɾ�������ع���
  --               2.����������������ʾ
  --               3.���������Զ������ܣ��������ñ�
  --
  --  UPDATE DATE��2019/07/15 version 2.3
  --               1.���ӷ��������ܣ�����SYS����������
  --               2.���������Զ������ܣ�����SYS_P*�����������������ñ�
  --               3.���������Զ������ܣ��������ñ�
  --
  --  UPDATE DATE��2019/07/16 version 2.4
  --               1.���������������ܣ����ݻر�ʱ�ر�logging
  --               2.���������Զ������ܣ�����SYS_P*�����������������ñ��Ż���������
  --               3.����������չ���ܣ��ܱ���չ
  --
  --  UPDATE DATE��2019/07/19 version 2.5
  --               1.�������������ܣ�Truncate�������滻Delete����
  --
  --  UPDATE DATE��2019/07/22 version 2.6
  --               1.��������Truncate���ܣ�����������������滻Delete����
  --               2.���������Զ������ܣ���/�±�澯DBMS��ӡ��־
  --
  --  UPDATE DATE��2019/09/07 version 2.7
  --               1.��������־���� PROC_LOGGING
  --               2.���������Զ������ܣ��������������������жϣ�������������ͨ������
  --
  --  UPDATE DATE��2019/09/08 version 2.8
  --               1.�������������Զ������ܣ��������������������жϣ��Ǳ���/�����������Ǳ���/������ͨIndex��
  --
  --  UPDATE DATE��2019/10/16 version 3.0
  --               1.���ӷ�����������Demo --SQL_GET_DDL��������ԭʼ��������WK������ת�������滻��Դ��
  --
  --  UPDATE DATE��2019/10/20 version 3.1
  --               1.���������Զ������ܣ����ӷ����Ƿ�����жϣ����������ڣ�������  
  --
  --  UPDATE DATE��2019/10/31 version 3.2
  --               1.���������������̣�����ʱ��� locate �����������
  --
  --  UPDATE DATE��2019/10/31 version 3.3
  --               1.���������Զ������ܣ����������Ƿ�����ж�������������������&��ͨȫ��������
  --
  --  UPDATE DATE��2019/11/07 version 3.4
  --               1.��������ɾ�����ܣ����������켶����������ʱ���Զ����������������ɾ����
  --
  --  TODO    1.���������Զ������ܣ������׼������ʽ��ͬʱ����Oracleϵͳ�����������SYS������ʽ��Finished��
  --               2.��������ɾ�����ܣ�Pending�����������켶��������켶��
  --               3.���ӷ����Զ�ɾ�����ܣ�Pending��
  --               4.����������չ���ܣ����ڷ�����������Сʱ  --PROC_PARTITION_ADD_RANGE��Pending��
  --               5.����������ؽ��Ƿ���Ҫ�����ع��̣�ͨ����ʱ��ʽ�ؽ��ϱ���ӷ�����Finished��
  --               6.�����Ƿ����ӽ�����ؼ����Ϣ�������˼򵥵Ĺ��̼�أ�ȷ���������Ƿ�������
  --               7.���� DBMS_SCHEDULER ��������ϵͳ���񣬿ɱ�����Ԥ��LOG
------------------------------------------------------------------------


  --Partition Add Manually����������ʽ����P_20191028��
  PROCEDURE PROC_PARTITION_ADD_RANGE
  (
    V_TBNAME VARCHAR2, V_TM_GRN VARCHAR2, V_DATE_THRESHOLD_START VARCHAR2,
    V_DATE_THRESHOLD_END VARCHAR2, V_TABLESPACE VARCHAR2
  );
  
  --Partition Delete Manually����Truncate 
  PROCEDURE PROC_PARTITION_CLEANUP_RANGE
  (V_TBNAME VARCHAR2, V_TM_GRN VARCHAR2, V_DATE_THRESHOLD_START VARCHAR2, V_DATE_THRESHOLD_END VARCHAR2);

  --�������� Partition Truncate Manually
  PROCEDURE PROC_PARTITION_TRUNCATE_RANGE
  (V_TBNAME VARCHAR2, V_TM_GRN VARCHAR2, V_DATE_THRESHOLD_START VARCHAR2, V_DATE_THRESHOLD_END VARCHAR2);

  --Truncate with Global Index Valid Manually
  PROCEDURE PROC_PARTITION_TRUNCATE_RANGE_INDEX
  (V_TBNAME VARCHAR2, V_TM_GRN VARCHAR2, V_DATE_THRESHOLD_START VARCHAR2, V_DATE_THRESHOLD_END VARCHAR2);

  --Partition Drop Manually
  PROCEDURE PROC_PARTITION_DROP_RANGE(V_TBNAME VARCHAR2, V_DATE_THRESHOLD_START VARCHAR2, V_DATE_THRESHOLD_END VARCHAR2);
  
  --Partition Add Automaticly����������ʽ����P_20191028��
  PROCEDURE PROC_PARTITION_ADD_AUTO;--�����Զ���չ
    
  --Partition Truncate Automaticly����������ʽ����P_20191028��
  PROCEDURE PROC_PARTITION_CLEANUP_AUTO;--�����Զ�����
    
  --Partition Locate
  PROCEDURE PROC_PARTITION_LOCATE(V_TABLE_NAME VARCHAR2, V_DATE_THRESHOLD_START VARCHAR2, V_PARTITION_NAME OUT VARCHAR2);

  --TABLE DDL with WK_Table
  PROCEDURE SQL_GET_DDL_WK
  (
    I_FROM_TABLENAME VARCHAR2, I_TM_GRN VARCHAR2, I_FROM_OWNER VARCHAR2,
    I_TABLESPACE VARCHAR2, I_DATE_THRESHOLD_START VARCHAR2
  );
  
  --TABLE DDL without WK_Table
  PROCEDURE SQL_GET_DDL--�� SQL_GET_DDL_WK ���������ڣ��������м��DROPԴ��ȷ�������ʹ��
  (
    I_FROM_TABLENAME VARCHAR2, I_TM_GRN VARCHAR2, I_FROM_OWNER VARCHAR2,
    I_TABLESPACE VARCHAR2, I_DATE_THRESHOLD_START VARCHAR2
  );
  
  --TABLE Drop Manually
  PROCEDURE DROPTABLE_IFEXISTS(I_TABLE_NAME VARCHAR2, PURGE_FLAG NUMBER);

  --�򵥵Ĺ��� Loggging
  PROCEDURE PROC_LOGGING(i_sdate date, i_pkg_name VARCHAR2,  i_inside_loop_log number,  i_exsit_flag number);
  
  PROCEDURE PROC_TEST;--�����Զ���չ


END PKG_MANAGE_SYSTEM_SHIN_PLUS8;
/

prompt
prompt Creating package body PKG_MANAGE_SYSTEM_SHIN_PLUS8
prompt ==================================================
prompt
CREATE OR REPLACE PACKAGE BODY PKG_MANAGE_SYSTEM_SHIN_PLUS8 AS
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
/*  procedure PROC_PARTITION_ADD_RANGE(V_TBNAME varchar2, V_DATE_THRESHOLD_START varchar2, V_DATE_THRESHOLD_END varchar2) is
      --V_TBNAME������չ����
      --V_DATE_THRESHOLD_START��������չ��ʼʱ�䣨����ʼʱ�����
      --V_DATE_THRESHOLD_END��������չ����ʱ�䣨������ʱ�����
      -- v_date date;

      v_date  date;
      v_part_name varchar2(30);
      v_date_name varchar2(200);
      v_loop_log number := 0 ;
      v_tablespace_default varchar2(50);
      BEGIN

          select to_date(V_DATE_THRESHOLD_START,'yyyymmdd') into v_date from dual;--��ʼʱ���'yyyymmdd'��ʽ��

          select distinct u.tablespace_name into v_tablespace_default
          from \*dba_tables d left join*\ USER_TAB_PARTITIONS u--������������
          \*on d.table_name = u.table_name*\
          where u.table_name = V_TBNAME;

          \*select distinct d.owner as i_owner,
          d.table_name as i_tablename,
          decode(u.tablespace_name,null,d.tablespace_name,u.tablespace_name)  as v_tablespace_default,
          to_char(sysdate,'yyyymmdd') as i_part_name,
          to_char(sysdate+1,'yyyy-mm-dd') as i_part_date
          from dba_tables d left join USER_TAB_PARTITIONS u
          on d.table_name = u.table_name
          where d.owner ='LRNOP'
          and (d.table_name like 'ZC%' or d.table_name like'LC_INDEX_LXN_BAD_CELL%')*\

          while v_date >= to_date(V_DATE_THRESHOLD_START,'yyyymmdd') and v_date <= to_date(V_DATE_THRESHOLD_END,'yyyymmdd') LOOP
          --v_loop_log := 1;
          v_part_name := 'P_' ||to_char(v_date,'yyyymmdd');
          v_date_name := ' VALUES LESS THAN (TO_DATE('''|| to_char(v_date+1,'YYYY-MM-DD')||' 00:00:00'',''YYYY-MM-DD HH24:MI:SS'')) ';--ƴ��ʱ��
          --������execute immediate 'alter table '||V_TBNAME||' drop partition '||v_part_name;
          --������ALTER TABLE LRNOP.ZC_CELL_LIST_3G ADD PARTITION P_20190610 VALUES LESS THAN (TO_DATE('2019-06-11 00:00:00','YYYY-MM-DD HH24:MI:SS')) TABLESPACE DBS_D_WRNOP;
          execute immediate 'ALTER TABLE ' || V_TBNAME || ' ADD PARTITION '|| v_part_name || v_date_name ||' TABLESPACE '||v_tablespace_default;--ע��ƴ�ӿո�

          dbms_output.put_line('��'||V_TBNAME||'�µķ���'||v_part_name||'�����ӣ�');--ִ��SQL��������
          v_date := v_date +1;--��������ٴβ�����һ����С��v_date������ѭ���ж�
          v_loop_log := v_loop_log +1;
         \* if       then
         else

          end if*\
          end LOOP;
          dbms_output.put_line('���η�����չ����: '||v_loop_log||'.');--ִ��SQL��������
          \*dbms_logmnr.add_logfile( LogFileName => 'E:\TEST1.log.');*\--Ŀǰ�����������������������Ϊlog
      end PROC_PARTITION_ADD_RANGE;*/
      
  PROCEDURE PROC_PARTITION_ADD_RANGE(V_TBNAME VARCHAR2, V_TM_GRN VARCHAR2, V_DATE_THRESHOLD_START VARCHAR2, V_DATE_THRESHOLD_END VARCHAR2, V_TABLESPACE VARCHAR2) IS
    --V_TBNAME������չ����
    v_date                  date;--��ʼʱ���
    v_date_partition        date;--���������������������
    --v_max_partition_name    varchar2(15);--������������
    v_part_name             varchar2(30);--������ƴ��
    v_date_threshold_part   varchar2(10);--��ǰ����+1 ��ʽ����YYYY-MM-DD��
    v_date_name             varchar2(200);--������չʱ���SQLƴ��
    v_loop_log              number := 0 ;--������
    v_tablespace_default    varchar2(30);--��ռ�
    BEGIN
                            
        select to_date(V_DATE_THRESHOLD_START,'yyyymmdd') into v_date from dual;--��ʼʱ���'yyyymmdd'��ʽ��--2019/06/11
        
        --��ռ�δ����ʱ��Ĭ�Ϸ���
        if V_TABLESPACE is null 
          then 
          select distinct u.tablespace_name into v_tablespace_default--��ռ䱣��
          from /*dba_tables d left join*/ USER_TAB_PARTITIONS u--������������
          /*on d.table_name = u.table_name*/
          where u.table_name = V_TBNAME;
        end if;

        select to_date(regexp_substr(max(u.partition_name),'[^P_]+',1,1,'i'),'yyyymmdd')
        into v_date_partition--���У�2019/06/19���죩 /2019/06/17���ܣ� /2019/06/01���£�
        from USER_TAB_PARTITIONS u
        where u.table_name = V_TBNAME;

        /*select max(u.partition_name)
        into v_max_partition_name--���У�P_20190619���죩 /P_20190617���ܣ� /P_20190601���£�
        from \*dba_tables d left join*\ USER_TAB_PARTITIONS u--������������
        where u.table_name = V_TBNAME;*/

        --������ֹ���޷Ƿ��ж�
        if  v_date_partition >= to_date(V_DATE_THRESHOLD_END,'yyyymmdd')--���з������������� >= ��ֹʱ�������
            then --��������--318
            /*RAISE_APPLICATION_ERROR(-20813, '�� '||V_TBNAME||' �����һ����������Ϊ��P_' ||to_char(v_date_partition,'yyyymmdd') ||'. 
            ��ָ���ķ�����ֹ����'||V_DATE_THRESHOLD_END||', �������Ϊ�������һ����������!', TRUE);*/
            dbms_output.put_line('�� '||V_TBNAME||' �µ����һ����������Ϊ P_'||to_char(v_date_partition, 'yyyymmdd')||'��');--ִ��SQL��������
            return;
            --continue;
            --V_DATE_THRESHOLD_START := to_char(v_date_partition + 1, 'yyyymmdd');--����ѭ���жϱ�ǩ
        end if;

        --V_DATE_THRESHOLD_START: 20190611
        --V_DATE_THRESHOLD_END: 20190621
        --v_date��2019/06/11
        --����ֱ�ӱȴ�С����ת��ΪDATE��ʽ
        while /*v_date >= to_date(V_DATE_THRESHOLD_START,'yyyymmdd') and*/ v_date <= to_date(V_DATE_THRESHOLD_END,'yyyymmdd') LOOP
        --v_loop_log := 1;
            if  V_TM_GRN = '2'--�켶����
                then
                  if v_loop_log = 0 then v_date := v_date_partition + 1;--�״ν�ѭ����ʱ��=��������������+1
                  --v_date��2019/06/20
                  end if;
                  
                  v_part_name := 'P_' ||to_char(v_date,'yyyymmdd');--P_20190620
                  v_date_threshold_part := to_char(v_date + 1,'YYYY-MM-DD');--2019-06-21
                  v_date_name := ' VALUES LESS THAN (TO_DATE('''|| v_date_threshold_part||' 00:00:00'',''YYYY-MM-DD HH24:MI:SS'')) ';--ƴ��ʱ��
                  --������ALTER TABLE LRNOP.LC_INDEX_LXN_BAD_CELL_DAY_ORC_TEST ADD PARTITION P_20190620 VALUES LESS THAN (TO_DATE('2019-06-21 00:00:00','YYYY-MM-DD HH24:MI:SS')) TABLESPACE DBS_D_WRNOP;
                  if V_TABLESPACE is null 
                    then 
                      execute immediate 'ALTER TABLE ' || V_TBNAME || ' ADD PARTITION '|| v_part_name || v_date_name ||' TABLESPACE '||v_tablespace_default;--ע��ƴ�ӿո�
                    else
                      execute immediate 'ALTER TABLE ' || V_TBNAME || ' ADD PARTITION '|| v_part_name || v_date_name ||' TABLESPACE '||V_TABLESPACE;--ע��ƴ�ӿո�
                  end if;
                  dbms_output.put_line('�� '||V_TBNAME||' �µ��켶���� '||v_part_name||' �����ӣ�');--ִ��SQL��������
                  v_date := v_date + 1;--���ｫ���ڸ������������գ����ж��Ƿ�����ѭ�� --2019/06/21
                  v_loop_log := v_loop_log + 1;


            elsif  V_TM_GRN = '3'--�ܼ�����
                then
                  if v_loop_log = 0 then v_date := v_date_partition + 7;--2019/06/24;--�״ν�ѭ����ʱ��=��������������+1
                  --v_date��2019/07/01
                  end if;
                  v_part_name := 'P_' ||to_char(v_date,'yyyymmdd');--P_20190624
                  v_date_threshold_part := to_char(v_date + 7,'YYYY-MM-DD');--2019-07-01
                  v_date_name := ' VALUES LESS THAN (TO_DATE('''|| v_date_threshold_part||' 00:00:00'',''YYYY-MM-DD HH24:MI:SS'')) ';--ƴ��ʱ��
                  
                  if V_TABLESPACE is null 
                    then 
                      execute immediate 'ALTER TABLE ' || V_TBNAME || ' ADD PARTITION '|| v_part_name || v_date_name ||' TABLESPACE '||v_tablespace_default;--ע��ƴ�ӿո�
                    else
                      execute immediate 'ALTER TABLE ' || V_TBNAME || ' ADD PARTITION '|| v_part_name || v_date_name ||' TABLESPACE '||V_TABLESPACE;--ע��ƴ�ӿո�
                  end if;                  
                  dbms_output.put_line('�� '||V_TBNAME||' �µ��ܼ����� '||v_part_name||' �����ӣ�');--ִ��SQL��������
                  --v_date := trunc(next_day(v_date,2),'dd');--2019/06/24
                  v_date := v_date + 7;--���ｫ���ڸ������������գ����ж��Ƿ�����ѭ�� --2019/06/24
                  v_loop_log := v_loop_log + 1;


            elsif  V_TM_GRN = '4'--�¼�����
                then
                  if v_loop_log = 0 then v_date := add_months(v_date_partition,1);--�״ν�ѭ����ʱ��=��������������+1
                  --v_date��2019/07/01
                  end if;
                  --v_date := add_months(v_date_partition,1);--2019/07/01
                  v_part_name := 'P_' ||to_char(v_date,'yyyymmdd');--P_20190701
                  v_date_threshold_part := to_char(add_months(v_date,1),'YYYY-MM-DD');--2019-08-01
                  v_date_name := ' VALUES LESS THAN (TO_DATE('''|| v_date_threshold_part||' 00:00:00'',''YYYY-MM-DD HH24:MI:SS'')) ';--ƴ��ʱ��
                  if V_TABLESPACE is null 
                    then 
                      execute immediate 'ALTER TABLE ' || V_TBNAME || ' ADD PARTITION '|| v_part_name || v_date_name ||' TABLESPACE '||v_tablespace_default;--ע��ƴ�ӿո�
                    else
                      execute immediate 'ALTER TABLE ' || V_TBNAME || ' ADD PARTITION '|| v_part_name || v_date_name ||' TABLESPACE '||V_TABLESPACE;--ע��ƴ�ӿո�
                  end if;        
                  dbms_output.put_line('�� '||V_TBNAME||' �µ��¼����� '||v_part_name||' �����ӣ�');--ִ��SQL��������
                  v_date := add_months(v_date,1);--2019/08/01
                  --v_date := trunc(last_day(v_date) + 1,'mm');--���ｫ���ڸ������������գ����ж��Ƿ�����ѭ�� --2019/08/01
                  v_loop_log := v_loop_log + 1;
            end if;
        end loop;

        dbms_output.put_line('���η�����չ����: '||v_loop_log||'.  ���ʱ�����'||to_char(sysdate,'yyyy/mm/dd hh24:mi:ss')||'.');--ִ��SQL��������
        /*dbms_logmnr.add_logfile( LogFileName => 'E:\TEST1.log.');*/--Ŀǰ�����������������������Ϊlog
    
    END PROC_PARTITION_ADD_RANGE;


-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
  PROCEDURE PROC_PARTITION_CLEANUP_RANGE(V_TBNAME VARCHAR2, V_TM_GRN VARCHAR2, V_DATE_THRESHOLD_START VARCHAR2, V_DATE_THRESHOLD_END VARCHAR2) IS
    v_date  date;
    v_part_name varchar2(30);--������ƴ��
    --v_date_threshold_part varchar2(10);--��ǰ����+1 ��ʽ����YYYY-MM-DD��
   -- v_date_name varchar2(200);--������չʱ���SQLƴ��
    v_loop_log number := 0 ;--������
    --v_tablespace_default varchar2(30);--��ռ�
    v_partition_type varchar2(20);--�������ͣ�С�±�׼����/ϵͳ����

    c_high_value varchar2(200);
    v_high_value_vc varchar2(20);
    c_table_name varchar2(50);
    c_partition_name varchar2(80);
    --v_ssql varchar2(300);
    v_tb_partition_exists_flag number;

    cursor c_partition_cur is
    select table_name,t.partition_name,t.high_value
    from USER_TAB_PARTITIONS t
    where table_name = V_TBNAME and partition_name not like 'P2%'--SYS_21313
    order by to_number(substr(partition_name,6)) desc;--���շ������������

    BEGIN
      
     select count(distinct table_name) into v_tb_partition_exists_flag from user_tables where table_name  = V_TBNAME;
      if v_tb_partition_exists_flag = 0
        then 
             dbms_output.put_line('�� '||V_TBNAME||' �����ڣ�');
             return;
      end if;
      
      --���������ж�
      select distinct
      case when partition_name like 'P\_%' escape '\' then 'SHIN'
              when partition_name like 'SYS\_%' escape '\' then 'SYS'
                  else null end partition_type into v_partition_type
      --decode(count(1), 0, to_char(count(1)), max(partition_name) )
      from
      (
          select partition_name
          from USER_TAB_PARTITIONS t
          /* using (table_name) */
          where partition_name not like 'P2%' and table_name = V_TBNAME
      );

      --���У�2019/06/19���죩 /2019/06/17���ܣ� /2019/06/01���£�
      select to_date(V_DATE_THRESHOLD_START,'yyyymmdd') into v_date from dual;--��ʼʱ���'yyyymmdd'��ʽ��--2019/06/20

      while v_date >= to_date(V_DATE_THRESHOLD_START,'yyyymmdd') and v_date <= to_date(V_DATE_THRESHOLD_END,'yyyymmdd') LOOP

        if v_partition_type = 'SHIN'
          then
            --v_loop_log := 1;
            if  V_TM_GRN = '2' --�켶��������
              then
                v_part_name := 'P_' ||to_char(v_date,'yyyymmdd');
                execute immediate 'DELETE FROM '||V_TBNAME||' partition('||v_part_name||')';
                commit;
                --execute immediate 'ALTER TABLE '||V_TBNAME||' TRUNCATE PARTITION('||v_part_name||')';
                --������execute immediate 'DELETE FROM XXX partition(P_20190620);
                dbms_output.put_line('�� '||V_TBNAME||' �µ��켶���� '||v_part_name||' ������');--ִ��SQL��������
                v_date := v_date +1;--��������ٴβ�����һ����С��v_date������ѭ���ж�
                v_loop_log := v_loop_log + 1;

            elsif  V_TM_GRN = '3' --�¼���������
              then
                --������3~9/3  10~16/10  17~23/17   24~30/24
                v_date := trunc(v_date, 'iw');--���� v_date ����ʼʱ����������һ�����ڣ�in: 20190620 out: 20190617
                v_part_name := 'P_' ||to_char(v_date, 'yyyymmdd');--P_20190617

                execute immediate 'DELETE FROM '||V_TBNAME||' partition('||v_part_name||')';
                --������execute immediate 'DELETE FROM XXX partition(P_20190601);
                commit;
                --execute immediate 'ALTER TABLE '||V_TBNAME||' TRUNCATE PARTITION('||v_part_name||')';
                dbms_output.put_line('�� '||V_TBNAME||' �µ��ܼ����� '||v_part_name||' ������');--ִ��SQL��������
                v_date := v_date + 7;--2019/06/24
                --v_date := trunc(last_day(v_date)+1,'mm');--���ｫ���ڸ������������գ����ж��Ƿ�����ѭ�� --2019/07/01
                v_loop_log := v_loop_log + 1;

            elsif  V_TM_GRN = '4' --�¼���������
              then
                v_date := trunc(v_date,'mm');--���� v_date �������գ�in: 20190620 out: 20190601
                v_part_name := 'P_' ||to_char(v_date,'yyyymmdd');

                execute immediate 'DELETE FROM '||V_TBNAME||' partition('||v_part_name||')';
                --������execute immediate 'DELETE FROM XXX partition(P_20190601);
                commit;
                --execute immediate 'ALTER TABLE '||V_TBNAME||' TRUNCATE PARTITION('||v_part_name||')';
                dbms_output.put_line('�� '||V_TBNAME||' �µ��¼����� '||v_part_name||' ������');--ִ��SQL��������
                v_date := add_months(v_date,1);--2019/08/01
                --v_date := trunc(last_day(v_date)+1,'mm');--���ｫ���ڸ������������գ����ж��Ƿ�����ѭ�� --2019/07/01
                v_loop_log := v_loop_log + 1;
            end if;

        elsif v_partition_type = 'SYS'
          then
            begin
              open c_partition_cur;--�ֵ���ڻ�ȡ�Ǳ�׼�����ķ�����
                  loop--******
                      fetch c_partition_cur into c_table_name ,c_partition_name, c_high_value;
                      exit when NOT c_partition_cur%FOUND;
                      v_high_value_vc := substr(c_high_value, 11, 10); --less than 2019-07-14 ...
                      if (to_char(to_date(v_high_value_vc,'yyyy-mm-dd')-1, 'yyyymmdd') between V_DATE_THRESHOLD_START and V_DATE_THRESHOLD_END)
                      --and c_table_name = V_TBNAME--ֻ����SYS������
                          then
                            execute immediate 'DELETE FROM '||V_TBNAME||' PARTITION('||c_partition_name||')';
                            --v_ssql := 'DELETE FROM '||V_TBNAME||' PARTITION('||c_partition_name||')';
                            --execute immediate v_ssql;--******
                            commit;
                            --execute immediate 'ALTER TABLE '||V_TBNAME||' TRUNCATE PARTITION('||c_partition_name||')';
                            dbms_output.put_line('�� '||V_TBNAME||' �µ�SYS�Զ����� '||c_partition_name||' ������');--ִ��SQL��������
                            v_loop_log := v_loop_log + 1;
                            if to_char(to_date(v_high_value_vc,'yyyy-mm-dd')-1, 'yyyymmdd') = V_DATE_THRESHOLD_START
                              then
                                 --SYSϵͳ�������ڽ�������������ȫ��ʱ��ı����������ټ������ʱ��LOOP����v_date = ��ֹʱ�� + 1
                                 v_date := to_date(V_DATE_THRESHOLD_END,'yyyymmdd') + 1;
                                 exit;--����������ﵽ��������ʱ��������ɣ��˳������������������
                            --else continue;
                            end if;
                      end if;
                  --fetch c_partition_cur into tab_owner,tab_name,tab_partition,tab_high_value;
                  end loop;
              close c_partition_cur;
            end;

        end if;
      END LOOP;
      dbms_output.put_line('��'||V_TBNAME||' �µķ������������ϼ�: '||v_loop_log||'.  ���ʱ�����'||to_char(sysdate,'yyyy/mm/dd hh24:mi:ss')||'.');
      dbms_output.put_line('----------------------------------------------------------------------');
      /*dbms_logmnr.add_logfile( LogFileName => 'E:\TEST1.log.');*/--Ŀǰ�����������������������Ϊlog

    END PROC_PARTITION_CLEANUP_RANGE;

  /*PROCEDURE PROC_PARTITION_CLEANUP_RANGE(V_TBNAME VARCHAR2, V_DATE_THRESHOLD_START VARCHAR2, V_DATE_THRESHOLD_END VARCHAR2) IS
      -- v_date date;
      \*v_date_threshold varchar(10);
      V_TBNAME varchar2(50);  *\
      v_date  date;
      v_part_name varchar2(30);
      v_loop_log number := 0 ;
      BEGIN
          -- v_date := date'2015-2-4';
          -- select to_date(20180901,'yyyymmdd') into v_date from dual;
          \*select to_char(trunc(to_date(start_date,'YYYYMMDD'),'MM'\*���ص�������*\),'YYYYMMDD')into date_mth_start from dual;*\
          \*select date_threshold into v_date_threshold from dual;
          select tbname into V_TBNAME from dual;*\
          \*select to_date(min(partition_name),'yyyymmdd')into v_date
          from
          (
              select distinct \*t.table_name,*\ to_number(substr(t.partition_name,3)) as partition_name
              from SYS.USER_TAB_PARTITIONS t where  t.table_name = V_TBNAME
              \*t.partition_name like 'P_201808%' *\
              --and t.table_name not like '%$%' --and t.num_rows is not null;
              --order by\* t.table_name,*\partition_name
          );*\

          select to_date(V_DATE_THRESHOLD_START,'yyyymmdd') into v_date from dual;

          while v_date >= to_date(V_DATE_THRESHOLD_START,'yyyymmdd') and v_date <= to_date(V_DATE_THRESHOLD_END,'yyyymmdd') LOOP
          --v_loop_log := 1;
          v_part_name := 'P_' ||to_char(v_date,'yyyymmdd');
          execute immediate 'DELETE FROM '||V_TBNAME||' partition('||v_part_name||')';
          commit;
          dbms_output.put_line('��'||V_TBNAME||'�µķ���'||v_part_name||'������');--ִ��SQL��������

          v_date := v_date +1;--��������ٴβ�����һ����С��v_date������ѭ���ж�
          v_loop_log := v_loop_log +1;
         \* if       then
         else

          end if*\
          end LOOP;
          dbms_output.put_line('���η�����������: '||v_loop_log||'.');--ִ��SQL��������
          \*dbms_logmnr.add_logfile( LogFileName => 'E:\TEST1.log.');*\--Ŀǰ�����������������������Ϊlog
      END PROC_PARTITION_CLEANUP_RANGE;*/

  /*PROCEDURE PROC_PARTITION_CLEANUP_RANGE(V_TBNAME VARCHAR2, V_TM_GRN VARCHAR2, V_DATE_THRESHOLD_START VARCHAR2, V_DATE_THRESHOLD_END VARCHAR2) IS
    v_date  date;
    v_part_name varchar2(30);--������ƴ��
    --v_date_threshold_part varchar2(10);--��ǰ����+1 ��ʽ����YYYY-MM-DD��
   -- v_date_name varchar2(200);--������չʱ���SQLƴ��
    v_loop_log number := 0 ;--������
    --v_tablespace_default varchar2(30);--��ռ�
    begin
        \*select to_char(trunc(to_date(start_date,'YYYYMMDD'),'MM'\*���ص�������*\),'YYYYMMDD')into date_mth_start from dual;*\
        \*select date_threshold into v_date_threshold from dual;
        select tbname into V_TBNAME from dual;*\
        
        
        --���У�2019/06/19���죩 /2019/06/17���ܣ� /2019/06/01���£�
        select to_date(V_DATE_THRESHOLD_START,'yyyymmdd') into v_date from dual;--��ʼʱ���'yyyymmdd'��ʽ��--2019/06/20

        while v_date >= to_date(V_DATE_THRESHOLD_START,'yyyymmdd') and v_date <= to_date(V_DATE_THRESHOLD_END,'yyyymmdd') LOOP
            --v_loop_log := 1;
            if  V_TM_GRN = '2' --�켶��������
                then
                v_part_name := 'P_' ||to_char(v_date,'yyyymmdd');
                execute immediate 'DELETE FROM '||V_TBNAME||' partition('||v_part_name||')';
                --������execute immediate 'DELETE FROM XXX partition(P_20190620);
                commit;
                dbms_output.put_line('�� '||V_TBNAME||' �µ��켶���� '||v_part_name||' ������');--ִ��SQL��������
                v_date := v_date +1;--��������ٴβ�����һ����С��v_date������ѭ���ж�
                v_loop_log := v_loop_log +1;
                
            elsif  V_TM_GRN = '3' --�¼���������
                then
                --������3~9/3  10~16/10  17~23/17   24~30/24
                v_date := trunc(v_date, 'iw');--���� v_date ����ʼʱ����������һ�����ڣ�in: 20190620 out: 20190617
                v_part_name := 'P_' ||to_char(v_date, 'yyyymmdd');--P_20190617

                execute immediate 'DELETE FROM '||V_TBNAME||' partition('||v_part_name||')';
                --������execute immediate 'DELETE FROM XXX partition(P_20190601);
                commit;
                dbms_output.put_line('�� '||V_TBNAME||' �µ��ܼ����� '||v_part_name||' ������');--ִ��SQL��������
                v_date := v_date + 7;--2019/06/24
                --v_date := trunc(last_day(v_date)+1,'mm');--���ｫ���ڸ������������գ����ж��Ƿ�����ѭ�� --2019/07/01
                v_loop_log := v_loop_log +1;

            elsif  V_TM_GRN = '4' --�¼���������
                then
                v_date := trunc(v_date,'mm');--���� v_date �������գ�in: 20190620 out: 20190601
                v_part_name := 'P_' ||to_char(v_date,'yyyymmdd');

                execute immediate 'DELETE FROM '||V_TBNAME||' partition('||v_part_name||')';
                --������execute immediate 'DELETE FROM XXX partition(P_20190601);
                commit;
                dbms_output.put_line('�� '||V_TBNAME||' �µ��¼����� '||v_part_name||' ������');--ִ��SQL��������
                v_date := add_months(v_date,1);--2019/08/01
                --v_date := trunc(last_day(v_date)+1,'mm');--���ｫ���ڸ������������գ����ж��Ƿ�����ѭ�� --2019/07/01
                v_loop_log := v_loop_log +1;
            end if;

        end LOOP;
        dbms_output.put_line('��'||V_TBNAME||'�µķ������������ϼ�: '||v_loop_log||'.  ���ʱ�����'||to_char(sysdate,'yyyy/mm/dd hh24:mi:ss')||'.');--ִ��SQL��������
        \*dbms_logmnr.add_logfile( LogFileName => 'E:\TEST1.log.');*\--Ŀǰ�����������������������Ϊlog
        
    END PROC_PARTITION_CLEANUP_RANGE;*/

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
  PROCEDURE PROC_PARTITION_TRUNCATE_RANGE(V_TBNAME VARCHAR2, V_TM_GRN VARCHAR2, V_DATE_THRESHOLD_START VARCHAR2, V_DATE_THRESHOLD_END VARCHAR2) IS
    v_date  date;
    v_part_name varchar2(30);--������ƴ��
    --v_date_threshold_part varchar2(10);--��ǰ����+1 ��ʽ����YYYY-MM-DD��
   -- v_date_name varchar2(200);--������չʱ���SQLƴ��
    v_loop_log number := 0 ;--������
    --v_tablespace_default varchar2(30);--��ռ�
    v_partition_type varchar2(20);--�������ͣ�С�±�׼����/ϵͳ����

    c_high_value varchar2(200);
    v_high_value_vc varchar2(20);
    c_table_name varchar2(50);
    c_partition_name varchar2(80);
    --v_ssql varchar2(300);
    v_tb_partition_exists_flag number;

    cursor c_partition_cur is
    select table_name,t.partition_name,t.high_value
    from USER_TAB_PARTITIONS t
    where table_name = V_TBNAME and partition_name not like 'P2%'--SYS_21313
    order by to_number(substr(partition_name,6)) desc;--���շ������������

    BEGIN

     select count(distinct table_name) into v_tb_partition_exists_flag from user_tables where table_name  = V_TBNAME;
      if v_tb_partition_exists_flag = 0
        then 
             dbms_output.put_line('�� '||V_TBNAME||' �����ڣ�');
             return;
      end if;

      --���������ж�
      select distinct
      case when partition_name like 'P\_%' escape '\' then 'SHIN'
              when partition_name like 'SYS\_%' escape '\' then 'SYS'
                  else null end partition_type into v_partition_type
      --decode(count(1), 0, to_char(count(1)), max(partition_name) )
      from
      (
          select partition_name, rownum rn
          from USER_TAB_PARTITIONS t
          /* using (table_name) */
          where partition_name not like 'P2%' and table_name = V_TBNAME
      )where rn >= 5;

      --���У�2019/06/19���죩 /2019/06/17���ܣ� /2019/06/01���£�
      select to_date(V_DATE_THRESHOLD_START,'yyyymmdd') into v_date from dual;--��ʼʱ���'yyyymmdd'��ʽ��--2019/06/20

      while v_date >= to_date(V_DATE_THRESHOLD_START,'yyyymmdd') and v_date <= to_date(V_DATE_THRESHOLD_END,'yyyymmdd') LOOP

        if v_partition_type = 'SHIN'
          then
            --v_loop_log := 1;
            if  V_TM_GRN = '2' --�켶��������
              then
                v_part_name := 'P_' ||to_char(v_date,'yyyymmdd');
                /*execute immediate 'DELETE FROM '||V_TBNAME||' partition('||v_part_name||')';
                commit;*/
                --execute immediate 'ALTER TABLE '||V_TBNAME||' TRUNCATE PARTITION('||v_part_name||') UPDATE GLOBAL INDEXES';
                execute immediate 'ALTER TABLE '||V_TBNAME||' TRUNCATE PARTITION('||v_part_name||')';
                --������execute immediate 'DELETE FROM XXX partition(P_20190620);
                dbms_output.put_line('�� '||V_TBNAME||' �µ��켶���� '||v_part_name||' ������');--ִ��SQL��������
                v_date := v_date +1;--��������ٴβ�����һ����С��v_date������ѭ���ж�
                v_loop_log := v_loop_log + 1;

            elsif  V_TM_GRN = '3' --�¼���������
              then
                --������3~9/3  10~16/10  17~23/17   24~30/24
                v_date := trunc(v_date, 'iw');--���� v_date ����ʼʱ����������һ�����ڣ�in: 20190620 out: 20190617
                v_part_name := 'P_' ||to_char(v_date, 'yyyymmdd');--P_20190617

                /*execute immediate 'DELETE FROM '||V_TBNAME||' partition('||v_part_name||')';
                --������execute immediate 'DELETE FROM XXX partition(P_20190601);
                commit;*/
                --execute immediate 'ALTER TABLE '||V_TBNAME||' TRUNCATE PARTITION('||v_part_name||') UPDATE GLOBAL INDEXES';
                execute immediate 'ALTER TABLE '||V_TBNAME||' TRUNCATE PARTITION('||v_part_name||')';
                dbms_output.put_line('�� '||V_TBNAME||' �µ��ܼ����� '||v_part_name||' ������');--ִ��SQL��������
                v_date := v_date + 7;--2019/06/24
                --v_date := trunc(last_day(v_date)+1,'mm');--���ｫ���ڸ������������գ����ж��Ƿ�����ѭ�� --2019/07/01
                v_loop_log := v_loop_log + 1;

            elsif  V_TM_GRN = '4' --�¼���������
              then
                v_date := trunc(v_date,'mm');--���� v_date �������գ�in: 20190620 out: 20190601
                v_part_name := 'P_' ||to_char(v_date,'yyyymmdd');

                /*execute immediate 'DELETE FROM '||V_TBNAME||' partition('||v_part_name||')';
                --������execute immediate 'DELETE FROM XXX partition(P_20190601);
                commit;*/
                --execute immediate 'ALTER TABLE '||V_TBNAME||' TRUNCATE PARTITION('||v_part_name||') UPDATE GLOBAL INDEXES';
                execute immediate 'ALTER TABLE '||V_TBNAME||' TRUNCATE PARTITION('||v_part_name||')';
                dbms_output.put_line('�� '||V_TBNAME||' �µ��¼����� '||v_part_name||' ������');--ִ��SQL��������
                v_date := add_months(v_date,1);--2019/08/01
                --v_date := trunc(last_day(v_date)+1,'mm');--���ｫ���ڸ������������գ����ж��Ƿ�����ѭ�� --2019/07/01
                v_loop_log := v_loop_log + 1;
            end if;

        elsif v_partition_type = 'SYS'
          then
            begin
              open c_partition_cur;--�ֵ���ڻ�ȡ�Ǳ�׼�����ķ�����
                  loop--******
                      fetch c_partition_cur into c_table_name ,c_partition_name, c_high_value;
                      exit when NOT c_partition_cur%FOUND;
                      if substr(c_high_value, 1, 2) = 'TI'--TIMESTAMP' 2019-04-25 00:00:00'
                          then v_high_value_vc := substr(c_high_value, 12, 10);
                      else
                          v_high_value_vc := substr(c_high_value, 11, 10); --less than 2019-07-14 ...
                      end if;
                      if (to_char(to_date(v_high_value_vc,'yyyy-mm-dd')-1, 'yyyymmdd') between V_DATE_THRESHOLD_START and V_DATE_THRESHOLD_END)
                      --and c_table_name = V_TBNAME--ֻ����SYS������
                          then
                            /*execute immediate 'DELETE FROM '||V_TBNAME||' PARTITION('||c_partition_name||')';
                            --v_ssql := 'DELETE FROM '||V_TBNAME||' PARTITION('||c_partition_name||')';
                            --execute immediate v_ssql;--******
                            commit;*/
                            --execute immediate 'ALTER TABLE '||V_TBNAME||' TRUNCATE PARTITION('||c_partition_name||') UPDATE GLOBAL INDEXES';
                            execute immediate 'ALTER TABLE '||V_TBNAME||' TRUNCATE PARTITION('||c_partition_name||')';
                            dbms_output.put_line('�� '||V_TBNAME||' �µ�SYS�Զ����� '||c_partition_name||' ������');--ִ��SQL��������
                            v_loop_log := v_loop_log + 1;
                            if to_char(to_date(v_high_value_vc,'yyyy-mm-dd')-1, 'yyyymmdd') = V_DATE_THRESHOLD_START
                              then
                                 --SYSϵͳ�������ڽ�������������ȫ��ʱ��ı����������ټ������ʱ��LOOP����v_date = ��ֹʱ�� + 1
                                 v_date := to_date(V_DATE_THRESHOLD_END,'yyyymmdd') + 1;
                                 exit;--����������ﵽ��������ʱ��������ɣ��˳������������������
                            --else continue;
                            end if;
                      end if;
                  --fetch c_partition_cur into tab_owner,tab_name,tab_partition,tab_high_value;
                  end loop;
              close c_partition_cur;
            end;

        end if;
      END LOOP;
      dbms_output.put_line('�� '||V_TBNAME||' �µķ������������ϼ�: '||v_loop_log||'.  ���ʱ�����'||to_char(sysdate,'yyyy/mm/dd hh24:mi:ss')||'.');
      dbms_output.put_line('----------------------------------------------------------------------');
      /*dbms_logmnr.add_logfile( LogFileName => 'E:\TEST1.log.');*/--Ŀǰ�����������������������Ϊlog

    END PROC_PARTITION_TRUNCATE_RANGE;

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
  PROCEDURE PROC_PARTITION_TRUNCATE_RANGE_INDEX(V_TBNAME VARCHAR2, V_TM_GRN VARCHAR2, V_DATE_THRESHOLD_START VARCHAR2, V_DATE_THRESHOLD_END VARCHAR2) IS
    v_date  date;
    v_part_name varchar2(30);--������ƴ��
    --v_date_threshold_part varchar2(10);--��ǰ����+1 ��ʽ����YYYY-MM-DD��
   -- v_date_name varchar2(200);--������չʱ���SQLƴ��
    v_loop_log number := 0 ;--������
    --v_tablespace_default varchar2(30);--��ռ�
    v_partition_type varchar2(20);--�������ͣ�С�±�׼����/ϵͳ����

    c_high_value varchar2(200);
    v_high_value_vc varchar2(20);
    c_table_name varchar2(50);
    c_partition_name varchar2(80);
    --v_ssql varchar2(300);
    v_tb_partition_exists_flag number;

    cursor c_partition_cur is
    select table_name,t.partition_name,t.high_value
    from USER_TAB_PARTITIONS t
    where table_name = V_TBNAME and partition_name not like 'P2%'--SYS_21313
    order by to_number(substr(partition_name,6)) desc;--���շ������������

    BEGIN

     select count(distinct table_name) into v_tb_partition_exists_flag from user_tables where table_name  = V_TBNAME;
      if v_tb_partition_exists_flag = 0
        then 
             dbms_output.put_line('�� '||V_TBNAME||' �����ڣ�');
             return;
      end if;

      --���������ж�
      select distinct
      case when partition_name like 'P\_%' escape '\' then 'SHIN'
              when partition_name like 'SYS\_%' escape '\' then 'SYS'
                  else null end partition_type into v_partition_type
      --decode(count(1), 0, to_char(count(1)), max(partition_name) )
      from
      (
          select partition_name, rownum rn
          from USER_TAB_PARTITIONS t
          /* using (table_name) */
          where partition_name not like 'P2%' and table_name = V_TBNAME
      )where rn >= 5;

      --���У�2019/06/19���죩 /2019/06/17���ܣ� /2019/06/01���£�
      select to_date(V_DATE_THRESHOLD_START,'yyyymmdd') into v_date from dual;--��ʼʱ���'yyyymmdd'��ʽ��--2019/06/20

      while v_date >= to_date(V_DATE_THRESHOLD_START,'yyyymmdd') and v_date <= to_date(V_DATE_THRESHOLD_END,'yyyymmdd') LOOP

        if v_partition_type = 'SHIN'
          then
            --v_loop_log := 1;
            if  V_TM_GRN = '2' --�켶��������
              then
                v_part_name := 'P_' ||to_char(v_date,'yyyymmdd');
                /*execute immediate 'DELETE FROM '||V_TBNAME||' partition('||v_part_name||')';
                commit;*/
                execute immediate 'ALTER TABLE '||V_TBNAME||' TRUNCATE PARTITION('||v_part_name||') UPDATE GLOBAL INDEXES';
                -- execute immediate 'ALTER TABLE '||V_TBNAME||' TRUNCATE PARTITION('||v_part_name||')';
                --������execute immediate 'DELETE FROM XXX partition(P_20190620);
                dbms_output.put_line('�� '||V_TBNAME||' �µ��켶���� '||v_part_name||' ������');--ִ��SQL��������
                v_date := v_date +1;--��������ٴβ�����һ����С��v_date������ѭ���ж�
                v_loop_log := v_loop_log + 1;

            elsif  V_TM_GRN = '3' --�¼���������
              then
                --������3~9/3  10~16/10  17~23/17   24~30/24
                v_date := trunc(v_date, 'iw');--���� v_date ����ʼʱ����������һ�����ڣ�in: 20190620 out: 20190617
                v_part_name := 'P_' ||to_char(v_date, 'yyyymmdd');--P_20190617

                /*execute immediate 'DELETE FROM '||V_TBNAME||' partition('||v_part_name||')';
                --������execute immediate 'DELETE FROM XXX partition(P_20190601);
                commit;*/
                execute immediate 'ALTER TABLE '||V_TBNAME||' TRUNCATE PARTITION('||v_part_name||') UPDATE GLOBAL INDEXES';
                --execute immediate 'ALTER TABLE '||V_TBNAME||' TRUNCATE PARTITION('||v_part_name||')';
                dbms_output.put_line('�� '||V_TBNAME||' �µ��ܼ����� '||v_part_name||' ������');--ִ��SQL��������
                v_date := v_date + 7;--2019/06/24
                --v_date := trunc(last_day(v_date)+1,'mm');--���ｫ���ڸ������������գ����ж��Ƿ�����ѭ�� --2019/07/01
                v_loop_log := v_loop_log + 1;

            elsif  V_TM_GRN = '4' --�¼���������
              then
                v_date := trunc(v_date,'mm');--���� v_date �������գ�in: 20190620 out: 20190601
                v_part_name := 'P_' ||to_char(v_date,'yyyymmdd');

                /*execute immediate 'DELETE FROM '||V_TBNAME||' partition('||v_part_name||')';
                --������execute immediate 'DELETE FROM XXX partition(P_20190601);
                commit;*/
                execute immediate 'ALTER TABLE '||V_TBNAME||' TRUNCATE PARTITION('||v_part_name||') UPDATE GLOBAL INDEXES';
                --execute immediate 'ALTER TABLE '||V_TBNAME||' TRUNCATE PARTITION('||v_part_name||')';
                dbms_output.put_line('�� '||V_TBNAME||' �µ��¼����� '||v_part_name||' ������');--ִ��SQL��������
                v_date := add_months(v_date,1);--2019/08/01
                --v_date := trunc(last_day(v_date)+1,'mm');--���ｫ���ڸ������������գ����ж��Ƿ�����ѭ�� --2019/07/01
                v_loop_log := v_loop_log + 1;
            end if;

        elsif v_partition_type = 'SYS'
          then
            begin
              open c_partition_cur;--�ֵ���ڻ�ȡ�Ǳ�׼�����ķ�����
                  loop--******
                      fetch c_partition_cur into c_table_name ,c_partition_name, c_high_value;
                      exit when NOT c_partition_cur%FOUND;
                      if substr(c_high_value, 1, 2) = 'TI'--TIMESTAMP' 2019-04-25 00:00:00'
                          then v_high_value_vc := substr(c_high_value, 12, 10);
                      else
                          v_high_value_vc := substr(c_high_value, 11, 10); --less than 2019-07-14 ...
                      end if;
                      if (to_char(to_date(v_high_value_vc,'yyyy-mm-dd')-1, 'yyyymmdd') between V_DATE_THRESHOLD_START and V_DATE_THRESHOLD_END)
                      --and c_table_name = V_TBNAME--ֻ����SYS������
                          then
                            /*execute immediate 'DELETE FROM '||V_TBNAME||' PARTITION('||c_partition_name||')';
                            --v_ssql := 'DELETE FROM '||V_TBNAME||' PARTITION('||c_partition_name||')';
                            --execute immediate v_ssql;--******
                            commit;*/
                            execute immediate 'ALTER TABLE '||V_TBNAME||' TRUNCATE PARTITION('||c_partition_name||') UPDATE GLOBAL INDEXES';
                            --execute immediate 'ALTER TABLE '||V_TBNAME||' TRUNCATE PARTITION('||c_partition_name||')';
                            dbms_output.put_line('�� '||V_TBNAME||' �µ�SYS�Զ����� '||c_partition_name||' ������');--ִ��SQL��������
                            v_loop_log := v_loop_log + 1;
                            if to_char(to_date(v_high_value_vc,'yyyy-mm-dd')-1, 'yyyymmdd') = V_DATE_THRESHOLD_START
                              then
                                 --SYSϵͳ�������ڽ�������������ȫ��ʱ��ı����������ټ������ʱ��LOOP����v_date = ��ֹʱ�� + 1
                                 v_date := to_date(V_DATE_THRESHOLD_END,'yyyymmdd') + 1;
                                 exit;--����������ﵽ��������ʱ��������ɣ��˳������������������
                            --else continue;
                            end if;
                      end if;
                  --fetch c_partition_cur into tab_owner,tab_name,tab_partition,tab_high_value;
                  end loop;
              close c_partition_cur;
            end;

        end if;
      END LOOP;
      dbms_output.put_line('�� '||V_TBNAME||' �µķ������������ϼ�: '||v_loop_log||'.  ���ʱ�����'||to_char(sysdate,'yyyy/mm/dd hh24:mi:ss')||'.');
      dbms_output.put_line('----------------------------------------------------------------------');
      /*dbms_logmnr.add_logfile( LogFileName => 'E:\TEST1.log.');*/--Ŀǰ�����������������������Ϊlog

    END PROC_PARTITION_TRUNCATE_RANGE_INDEX;


-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
  PROCEDURE PROC_PARTITION_DROP_RANGE(V_TBNAME VARCHAR2, V_DATE_THRESHOLD_START VARCHAR2, V_DATE_THRESHOLD_END VARCHAR2) IS
    v_partition_name                varchar2(50);
    v_date  date;
    --v_part_name varchar2(30);
    v_part_name_drop varchar2(30);
    v_loop_log number := 0 ;
    --v_tb_partition_exists_flag number;
    
    BEGIN
        -------
        v_date := to_date(V_DATE_THRESHOLD_START,'yyyymmdd'); --20191107 --> 2019-11-07

        WHILE v_date >= to_date(V_DATE_THRESHOLD_START,'yyyymmdd') and v_date <= to_date(V_DATE_THRESHOLD_END,'yyyymmdd') LOOP
        --v_loop_log := 1;
            v_part_name_drop := to_char(v_date, 'yyyymmdd'); --20191107
            PKG_MANAGE_SYSTEM_SHIN_PLUS8.PROC_PARTITION_LOCATE(V_TBNAME, v_part_name_drop , v_partition_name);

            if v_partition_name = 'NULL'
               then
                   dbms_output.put_line('�� '||V_TBNAME||' �¶�Ӧʱ�� '||v_part_name_drop||' �ķ��������ڣ����ʱ�����'||to_char(sysdate,'yyyy/mm/dd hh24:mi:ss')||'.');
                   v_date := v_date +1;--��������ٴβ�����һ����С��v_date������ѭ���ж�                   
                   continue;
            else
                   --�ѱ�� 20191107 ��Ӧ��ϵͳ�Զ����� SYS_XXX �� P_20191107
                   execute immediate 'ALTER TABLE '||V_TBNAME||' DROP PARTITION ('||v_partition_name ||') UPDATE GLOBAL INDEXES'; 
                   dbms_output.put_line('��'||V_TBNAME||'�µķ��� '||v_partition_name||' ��ɾ����');--ִ��SQL��������
                   v_date := v_date +1;--��������ٴβ�����һ����С��v_date������ѭ���ж�
                   v_loop_log := v_loop_log +1;
            end if;
            
        END LOOP;
        dbms_output.put_line('���η���ɾ������: '||v_loop_log||'. ���ʱ�����'||to_char(sysdate,'yyyy/mm/dd hh24:mi:ss')||'.');--ִ��SQL��������
        /*dbms_logmnr.add_logfile( LogFileName => 'E:\TEST1.log.');*/--Ŀǰ�����������������������Ϊlog
    END PROC_PARTITION_DROP_RANGE;


-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
  PROCEDURE PROC_PARTITION_ADD_AUTO IS
    --Editor��Shinnosuke
    --Updating��2019/05/07
    --�켶�����&�¼������ÿ������жϣ��켶�����������¼���ÿ���µ����������£�����

    --Updating��2019/05/08
    --1.�¼��������չ�ж���������������
    --2.�¼��������չע������������

    ---------------------------------------
      ssql varchar2(4000);
      cursor C_JOB   is
      select sql_string from--�����next_day���У�����Ϊ�����SQLΪ��̬DDLƴ����䣬�ǵ������ж�������������ִ�����ݣ�����
      (
            select
            case
               when s.tm_grn = '2'--ÿ��ִ���켶����չ���������չ��sysdate+1
                    then 'call PKG_MANAGE_SYSTEM_SHIN_PLUS8.PROC_PARTITION_ADD_RANGE('''|| table_name||''','''|| tm_grn ||''','''||to_char(sysdate+1,'yyyymmdd')||''','''||to_char(sysdate+1,'yyyymmdd')||''','''||TABLESPACE_NAME ||''')'
               when s.tm_grn = '3'--ÿ������ִ�У��������չ��������һ
               and trunc(sysdate) = trunc(next_day(sysdate,4))-7
               --and trunc(sysdate,'dd') = last_day(trunc(sysdate, 'mm'))
               --and to_char(sysdate,'yyyymmdd') = '20190626'--����ʱ���
                    then 'call PKG_MANAGE_SYSTEM_SHIN_PLUS8.PROC_PARTITION_ADD_RANGE('''|| table_name||''','''|| tm_grn ||''','''||to_char(trunc(next_day(sysdate,4)),'yyyymmdd')||''','''||to_char(trunc(next_day(sysdate,4)),'yyyymmdd')||''','''||TABLESPACE_NAME ||''')'
               when s.tm_grn = '4'--ÿ���µ�ǰ3�죬ִ���¼�����չ���������չ����������
               and trunc(sysdate) = last_day(trunc(sysdate, 'mm'))-3
                    then 'call PKG_MANAGE_SYSTEM_SHIN_PLUS8.PROC_PARTITION_ADD_RANGE('''|| table_name||''','''|| tm_grn ||''','''||to_char(last_day(trunc(sysdate, 'mm'))+1,'yyyymmdd')||''','''||to_char(last_day(trunc(sysdate, 'mm'))+1,'yyyymmdd')||''','''||TABLESPACE_NAME ||''')'
            end as sql_string--ƴ�ӷ�����չ���
            from FAST_DATA_PROCESS_TEMPLATE s
            where s.activate_flag = 1
            order by template_id
      )
      where sql_string is not null;
      --�����α���� c_row
      c_row c_job%rowtype;--�����ж���
      i number;
      --v_cursor number;
      --v_row number;--����
      BEGIN
          --SQL_LINE := t_sql_table();
          i := 1;
          open c_job;
            loop
                fetch c_job into c_row;
                exit when c_job%notfound;
                --SQL_LINE.Extend(1);
                --v_cursor:=dbms_sql.open_cursor;
                ssql := c_row.sql_string;
                --dbms_sql.parse(v_cursor,ssql,dbms_sql.native); --�������
                --v_row:=dbms_sql.execute(v_cursor); --ִ�����
                --dbms_sql.close_cursor(v_cursor); --�رչ��
                execute immediate ssql;
                dbms_output.put_line('SQL_LINE_'||i|| ' ����ִ�У�ִ�����ݣ�'||ssql||'.
                ');--ִ��SQL��������
                i :=i+1;
            end loop;
          close c_job;
          --return SQL_LINE;
      END PROC_PARTITION_ADD_AUTO;
     

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
  PROCEDURE PROC_PARTITION_CLEANUP_AUTO IS
    V_TBNAME varchar2(50);--:= 'LC_INDEX_LXN_BAD_CELL_DAY_ORC_TEST'; --����չ����
    --V_DATE_THRESHOLD_START varchar2(10);--������չ��ʼʱ�䣨����ʼʱ�����
    --v_date_threshold_part varchar2(10);--������չ����ʱ�䣨������ʱ�����
    --v_date_start  date;--��ǰ����
    --v_date_start_clean date;--������ʼʱ���
    v_date_start_clean_vc varchar2(15);--������ʼʱ���ʽ����yyyymmdd��
    v_partitioned varchar2(15);--�����������
    v_tm_grn varchar2(5);
    --v_template_id number :=0;--���ñ��ڱ���Ψһ��ʶ
    --v_template_id_max number;--���ñ���Ψһ��ʶ����
    v_rownum number := 0;--
    v_rownum_max number;--
    --v_table_name varchar2(100);
    v_cleanup_flag number;--���ñ��ڼ����ʶ
    v_ssql varchar2(1000);
    --v_day_clean number;
    --v_high_value_vc                 varchar2(20);
    v_partition_name                varchar2(50);
    v_partition_type varchar2(20);--�������ͣ�С�±�׼����/ϵͳ����
    v_tb_partition_exists_flag number;
    v_tb_exists_flag number;
    v_index_partition_status varchar2(30);
    v_date_start_noclean_vc varchar2(8) := to_char(trunc(sysdate, 'mm') + 14, 'yyyymmdd'); --Freq=Daily without 15th every month


    /*cursor cur_partition is --�ֵ���ڻ�ȡ�Ǳ�׼�����ķ�����
    select table_name,t.partition_name,t.high_value
    from USER_TAB_PARTITIONS t
    where table_name = V_TBNAME and partition_name not like 'P2%'--SYS_21313
    order by to_number(substr(partition_name,6)) desc;--���շ������������

    type partition_type is record(
        table_name      varchar2(200),
        partition_name  varchar2(50),
        high_value      varchar2(100)
    );
    partition_tmp partition_type;*/

    BEGIN
        --����
        --����һ��ͨ�� template_id ����ѭ��������ȱ�㣺template_id �������Ĳ��ֻ���ɳ��򱨴�����
        --select max(template_id) into v_template_id_max from FAST_DATA_PROCESS_TEMPLATE;
        --��������ͨ�� rownum ����ѭ��������ȱ�㣺������˳��Ǹ����ִ��˳�򣬳��򲻻ᱨ������
        select max(rownum) into v_rownum_max from FAST_DATA_PROCESS_TEMPLATE;
        --PLUS7��δ����
        --PKG_MANAGE_SYSTEM_PLUS7_0.PROC_PARTITION_CLEANUP_RANGE('LRNOP','LC_INDEX_LXN_BAD_CELL_DAY',v_date_start,v_date_start,'0','0');


        --�Զ�������������
        --while v_template_id < v_template_id_max loop--�������ñ������б�
        while v_rownum < v_rownum_max loop--******
            v_rownum := v_rownum + 1;
            --�������ñ��Template_id˳�򣬱���
            /*select table_name into V_TBNAME from
            (
                select table_name, rownum as rn from
                (
                    select s.table_name from FAST_DATA_PROCESS_TEMPLATE s order by s.template_id
                )t
            )where rn = v_rownum;*/
            execute immediate 
            'select table_name from
            (
                select table_name, rownum as rn from
                (
                    select s.table_name from FAST_DATA_PROCESS_TEMPLATE s order by s.template_id
                )t
            )where rn = :v_rownum' into V_TBNAME using v_rownum;
                        
            /*V_TBNAME := 'PERF_CELL_L_3';*/
            --�жϱ��Ƿ����
            /*select count(distinct table_name) into v_tb_exists_flag from user_tables where table_name  = V_TBNAME;*/
            execute immediate 'select count(distinct table_name) from user_tables where table_name = :V_TBNAME'into v_tb_exists_flag using V_TBNAME;
            
            --��ȡ���������״̬
            /*select s.cleanup_flag  into v_cleanup_flag from FAST_DATA_PROCESS_TEMPLATE s where s.table_name = V_TBNAME;--where s.template_id = v_template_id;*/
            execute immediate 'select s.cleanup_flag from FAST_DATA_PROCESS_TEMPLATE s where s.table_name = :V_TBNAME'
            into v_cleanup_flag using V_TBNAME;
            --dbms_output.put_line(V_TBNAME);
            
            --�������ڻ��������δ���������������һ��ѭ��
            --�������������ͣ��ں����������ж�
            if v_tb_exists_flag = 0
               then
                    dbms_output.put_line('�� '||V_TBNAME||' �����ڣ�');
                    continue;
            elsif v_tb_exists_flag <> 0 and (v_cleanup_flag = 0 or v_cleanup_flag is null)
               then
                    dbms_output.put_line('�� '||V_TBNAME||' ���Զ�����Ȩ��δ������');
                    continue;
            else
               --�����ñ��л�ȡ��ά��
               /*select s.tm_grn into v_tm_grn from  FAST_DATA_PROCESS_TEMPLATE s where s.table_name = V_TBNAME;*/
               execute immediate 'select s.tm_grn from  FAST_DATA_PROCESS_TEMPLATE s where s.table_name = :V_TBNAME'into v_tm_grn using V_TBNAME;
               
               if v_tm_grn is null
                   then
                        dbms_output.put_line('���ñ��б� '||V_TBNAME||' ��ʱ��ά���ֶ�Ϊ�գ���������');
                        continue;
               else
                   --��ȡ������
                   --�����ñ��л�ȡ����ʱ�䷶Χ�����������ʱ���
                   execute immediate 
                   'select decode
                   (
                     cleanup_day_range, null,
                     (case :v_tm_grn when ''2'' then to_char((trunc(sysdate) - 60), ''yyyymmdd'')--20190328
                                              when ''3'' then to_char(trunc(next_day((trunc(sysdate) - 60),''����һ''))-7,''yyyymmdd'')
                                                 when ''4'' then to_char(trunc((trunc(sysdate) - 60),''mm''),''yyyymmdd'')end
                     ),
                     (case :v_tm_grn when ''2'' then to_char((trunc(sysdate) - s.cleanup_day_range), ''yyyymmdd'')--20190328
                                              when ''3'' then to_char(trunc(next_day((trunc(sysdate) - s.cleanup_day_range),''����һ''))-7,''yyyymmdd'')
                                                 when ''4'' then to_char(trunc((trunc(sysdate) - s.cleanup_day_range),''mm''),''yyyymmdd'') end
                     )
                   )
                   from FAST_DATA_PROCESS_TEMPLATE s where s.table_name = :V_TBNAME' into v_date_start_clean_vc using v_tm_grn, v_tm_grn, V_TBNAME;
               end if;
               
               --20191106 ZYJ�û����ֻÿ�±����������ݣ�Ŀ��ʱ�����15th��
               if V_TBNAME = 'ZYJ_MR_USER_CELL' and v_date_start_clean_vc = v_date_start_noclean_vc
                   then
                        dbms_output.put_line('ʱ�����'||v_date_start_clean_vc||', �� '||V_TBNAME||' ����������������');
                        continue;
               end if;
               
               --�ж��Ƿ����
               execute immediate 'select partitioned from user_tables where table_name = :V_TBNAME' into v_partitioned using V_TBNAME;
               
               --�жϷ������ͣ��ų��׷���
               execute immediate
               'select partition_type from
               (
                 select distinct
                        case when partition_name like ''P\_%'' escape ''\'' then ''SHIN''
                                  when partition_name like ''SYS\_%'' escape ''\'' then ''SYS''
                                       else ''NULL'' end partition_type
                 --decode(count(1), 0, to_char(count(1)), max(partition_name) )
                 from
                 (
                    select partition_name from
                    (select * from FAST_DATA_PROCESS_TEMPLATE s where s.table_name = :V_TBNAME)s
                    left join USER_TAB_PARTITIONS t
                    using (table_name)
                    where partition_name not like ''P2%''--��ܷ���ͷ�жϽ��ΪNULL�����
                 )
               )where partition_type is not null' into v_partition_type using V_TBNAME;
               
               --20191018
               /*if v_partition_type = 'SHIN'
                 then--��׼���������ж�ָ�������Ƿ����
                     execute immediate
                     'select count(partition_name) --u.partition_name
                     from USER_TAB_PARTITIONS u
                     where u.table_name = :V_TBNAME
                     and substr(u.partition_name,3) = :partition_date' into v_tb_partition_exists_flag
                     using V_TBNAME, v_date_start_clean_vc;
               elsif v_partition_type = 'SYS'
                 then
                     v_tb_partition_exists_flag := 1; --Ĭ��SYSϵͳ��������
               end if;*/
               
               v_partition_name := '';
               
               /*open cur_partition; --��ʼ�����ֵ��
               fetch cur_partition into partition_tmp.table_name, partition_tmp.partition_name, partition_tmp.high_value;
               loop--------------
                     exit when NOT (cur_partition%FOUND);
                     if substr(partition_tmp.high_value, 1, 2) = 'TI'--TIMESTAMP' 2019-04-25 00:00:00'
                         then v_high_value_vc := substr(partition_tmp.high_value, 12, 10);
                     else
                         v_high_value_vc := substr(partition_tmp.high_value, 11, 10); --less than 2019-07-14 ...
                     end if;
                     if (to_char(to_date(v_high_value_vc,'yyyy-mm-dd')-1, 'yyyymmdd') = v_date_start_clean_vc)
                        then
                           v_partition_name := partition_tmp.partition_name;
                           dbms_output.put_line(v_partition_name);
                           exit;--����������ﵽĿ�����ֵʱ(ָ��ʱ��&ָ��ʱ��һ��ǰ)���α�������˳������������������
                     end if;
                     fetch cur_partition into partition_tmp.table_name, partition_tmp.partition_name, partition_tmp.high_value;
               end loop;
               close cur_partition;--------------*/
               
               PKG_MANAGE_SYSTEM_SHIN_PLUS8.PROC_PARTITION_LOCATE(V_TBNAME, v_date_start_clean_vc, v_partition_name);
               
               if v_partition_name = 'NULL'
                 then
                     v_tb_partition_exists_flag := 0;
               else 
                     v_tb_partition_exists_flag := 1;
               end if;
               
               
               if v_tb_partition_exists_flag = 0
                 then
                     dbms_output.put_line('�� '||V_TBNAME||' �¶�Ӧʱ�� '||v_date_start_clean_vc||' �ķ��������ڣ����ʱ�����'||to_char(sysdate,'yyyy/mm/dd hh24:mi:ss')||'.');
                     continue;
               else
                     
                     --�ж�Ψһ�����Ƿ��������δ��������clean��
                     execute immediate
                     'select count(1) from user_indexes t where t.table_name = :V_TBNAME' into v_index_partition_status using V_TBNAME;--�ж��Ƿ���������������ͨ������
                     if v_index_partition_status = 0--��Ψһ��������ֱ��truncate
                           then
                                v_index_partition_status := 'YES';
                     else
                                execute immediate'
                                select partitioned from
                                (
                                    select case when count(1)= 0 then ''YES'' else partitioned end as partitioned, rownum rn from
                                    (
                                        select partitioned, count(1) as partitioned_num
                                        from user_indexes t where t.table_name = :V_TBNAME
                                        --and (t.uniqueness = ''UNIQUE'')
                                        group by partitioned
                                    )b
                                    group by partitioned, rownum 
                                ) where rn =1'
                                into v_index_partition_status using V_TBNAME;
                     end if;
               end if;

               --���ˣ�׼��������ɣ�����
               ------------------------------------------------------------------------
               ------------------------------------------------------------------------
               if v_tm_grn = '2' and v_partitioned <> 'NO'
               --�ж�ά�ȼ������Ƿ����
                    then
                        --execute immediate 'ALTER TABLE '||V_TBNAME||' NOLOGGING';                        
                        if v_index_partition_status = 'YES'
                           then
                                v_ssql := 'call PKG_MANAGE_SYSTEM_SHIN_PLUS8.PROC_PARTITION_TRUNCATE_RANGE('''||V_TBNAME||''','''||v_tm_grn||''','||v_date_start_clean_vc||','''||v_date_start_clean_vc||''')';
                                --V_TBNAME,v_tm_grn,v_date_start_clean_vc,v_date_start_clean_vc
                                execute immediate v_ssql;
                        else
                                v_ssql := 'call PKG_MANAGE_SYSTEM_SHIN_PLUS8.PROC_PARTITION_TRUNCATE_RANGE_INDEX('''||V_TBNAME||''','''||v_tm_grn||''','||v_date_start_clean_vc||','''||v_date_start_clean_vc||''')';
                                --V_TBNAME,v_tm_grn,v_date_start_clean_vc,v_date_start_clean_vc
                                execute immediate v_ssql;
                        end if;

               elsif trunc(sysdate) = trunc(next_day(sysdate,'������'))-7 and v_tm_grn = '3' and v_partitioned <> 'NO'
                    --ÿ������ִ�У�����X����ǰ�����������ܵ��ܼ�����
                    then
                        --execute immediate 'ALTER TABLE '||V_TBNAME||' NOLOGGING';
                        if v_index_partition_status = 'YES'
                           then
                                v_ssql := 'call PKG_MANAGE_SYSTEM_SHIN_PLUS8.PROC_PARTITION_TRUNCATE_RANGE('''||V_TBNAME||''','''||v_tm_grn||''','||v_date_start_clean_vc||','''||v_date_start_clean_vc||''')';
                                execute immediate v_ssql;
                        else
                                v_ssql := 'call PKG_MANAGE_SYSTEM_SHIN_PLUS8.PROC_PARTITION_TRUNCATE_RANGE_INDEX('''||V_TBNAME||''','''||v_tm_grn||''','||v_date_start_clean_vc||','''||v_date_start_clean_vc||''')';
                                execute immediate v_ssql;
                        end if;

               elsif trunc(sysdate) = trunc(last_day(sysdate)) and v_tm_grn = '4' and v_partitioned <> 'NO'
                    --ÿ��ĩ��ִ�У�����X����ǰ�����������µ��¼�����
                    then
                        --execute immediate 'ALTER TABLE '||V_TBNAME||' NOLOGGING';
                        if v_index_partition_status = 'YES'
                           then
                                v_ssql := 'call PKG_MANAGE_SYSTEM_SHIN_PLUS8.PROC_PARTITION_TRUNCATE_RANGE('''||V_TBNAME||''','''||v_tm_grn||''','||v_date_start_clean_vc||','''||v_date_start_clean_vc||''')';
                                execute immediate v_ssql;
                        else
                                v_ssql := 'call PKG_MANAGE_SYSTEM_SHIN_PLUS8.PROC_PARTITION_TRUNCATE_RANGE_INDEX('''||V_TBNAME||''','''||v_tm_grn||''','||v_date_start_clean_vc||','''||v_date_start_clean_vc||''')';
                               execute immediate v_ssql;
                        end if;

               elsif v_partitioned = 'YES' and v_partition_type = 'SHIN'
                    then
                        dbms_output.put_line('�� '||V_TBNAME||' ��������ʱ��δ�������ʱ�����'||to_char(sysdate,'yyyy/mm/dd hh24:mi:ss')||'.');
               elsif v_partitioned = 'YES' and v_partition_type = 'SYS'  
                    then
                        dbms_output.put_line('�� '||V_TBNAME||' �µ�SYS�켶�Զ��������жϣ����ʱ�����'||to_char(sysdate,'yyyy/mm/dd hh24:mi:ss')||'.');
                        continue;
               elsif v_partitioned = 'YES' and v_partition_type = 'NULL'  
                    then
                        dbms_output.put_line('�� '||V_TBNAME||' �µ�SYS�켶�Զ�����(ָ������)�������ݣ�����δ���ɣ����ʱ�����'||to_char(sysdate,'yyyy/mm/dd hh24:mi:ss')||'.');
                        continue;
               end if;
            end if;
        end loop;
        commit;--******

        dbms_output.put_line('�����Զ������������.');
    END PROC_PARTITION_CLEANUP_AUTO;
    
    
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
  PROCEDURE PROC_PARTITION_LOCATE(V_TABLE_NAME VARCHAR2, V_DATE_THRESHOLD_START VARCHAR2, V_PARTITION_NAME OUT VARCHAR2) IS
    v_high_value_vc                 varchar2(20);

    TYPE PARTITION_TYPE IS RECORD(
        table_name      varchar2(200),
        partition_name  varchar2(50),
        high_value      varchar2(100)
    );

    -- ������ڼ�¼��Ƕ�ױ�
    TYPE NESTED_TYPE IS TABLE OF PARTITION_TYPE;
    -- �������ϱ���
    NESTED_TAB      NESTED_TYPE;
    -- ������һ����������Ϊlimit��ֵ
    V_LIMIT         PLS_INTEGER := 500;
    -- �����������¼FETCH����
    V_COUNTER       INTEGER := 0;

    cursor CUR_PARTITION is --�ֵ���ڻ�ȡ�Ǳ�׼�����ķ�����
    select table_name,t.partition_name,t.high_value from USER_TAB_PARTITIONS t where table_name = V_TABLE_NAME and partition_name not like 'P2%'--SYS_21313
    order by to_number(substr(partition_name,6)) desc;--���շ������������

    BEGIN
        OPEN CUR_PARTITION; --��ʼ�����ֵ��
        LOOP--------------
            FETCH CUR_PARTITION BULK COLLECT INTO NESTED_TAB LIMIT V_LIMIT;
            EXIT WHEN NESTED_TAB.count = 0;
            V_COUNTER := V_COUNTER + 1; 
            FOR I IN NESTED_TAB.FIRST .. NESTED_TAB.LAST
            LOOP
                --����TIMESTAMP���ͣ�TIMESTAMP' 2019-04-25 00:00:00'
                if substr(NESTED_TAB(I).high_value, 1, 2) = 'TI'
                    then v_high_value_vc := substr(NESTED_TAB(I).high_value, 12, 10);
                else 
                    v_high_value_vc := substr(NESTED_TAB(I).high_value, 11, 10); --����������less than 2019-07-14 ...
                end if;

                if (to_char(to_date(v_high_value_vc,'yyyy-mm-dd')-1, 'yyyymmdd') = V_DATE_THRESHOLD_START)
                then
                    V_PARTITION_NAME := NESTED_TAB(I).partition_name;
                    dbms_output.put_line('Ŀ���������'||V_PARTITION_NAME);
                    exit;--����������ﵽĿ�����ֵʱ(ָ��ʱ��&ָ��ʱ��һ��ǰ)���α�������˳������������������
                end if;
            END LOOP;
        END LOOP;
        close cur_partition;--------------

        if V_PARTITION_NAME is NULL 
            then V_PARTITION_NAME := 'NULL'; 
        end if;

    END PROC_PARTITION_LOCATE;

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
  PROCEDURE SQL_GET_DDL_WK(I_FROM_TABLENAME VARCHAR2,  I_TM_GRN VARCHAR2,  I_FROM_OWNER VARCHAR2, I_TABLESPACE VARCHAR2, I_DATE_THRESHOLD_START VARCHAR2) is
     V_DATE  date;
     V_COB_TABLESQL CLOB;--Ԫ����
     V_COB_TBSP_PARTITIONSQL CLOB;--��ռ�&�����洢
     --V_COB_A2WKA varchar2(500);
     V_SSQL varchar2(500);
     V_DATE_FIELD  varchar2(30);--ʱ���ֶ���
     V_DATE_THRESHOLD_PART varchar2(20);
     V_PART_NAME   varchar2(30);--������ƴ��
     PK_FLAG number;
     --V_DATE_NAME   varchar2(200);--������չʱ���SQLƴ��

     BEGIN
        --������Ԫ���ݣ����ಿ���޳�
        BEGIN
          --�رմ洢����ռ�����
          DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'STORAGE',FALSE);
          --DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'TABLESPACE',TRUE);

          --�رմ������PCTFREE��NOCOMPRESS������
          --PCTFREE���鱣��10%�Ŀռ��������¸ÿ�����ʹ��
          DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'SEGMENT_ATTRIBUTES',FALSE);
          --������Ϣ
          DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'PARTITIONING',FALSE);
          --�����Ϣ�������Ż��и�ʽ��
          /*DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'PRETTY',FALSE);*/--����Ȩ�����⣬������
        END;
                
        SELECT DBMS_METADATA.GET_DDL('TABLE',I_FROM_TABLENAME,I_FROM_OWNER)
        INTO V_COB_TABLESQL
        FROM DUAL;--����Ԫ����
        --dbms_output.put_line('1��'||V_COB_TABLESQL);--��ӡ�����������
        
        --����Լ���Ƿ�����ж�
        select count(distinct u.constraint_type) into PK_FLAG
        from user_constraints u where u.table_name = I_FROM_TABLENAME--'NE_MME_L'
        and u.constraint_type = 'P';    
        
        --Ԫ���ݱ���ƴ�� 'WK_'
        if PK_FLAG <> 0 --Դ��Լ��ʱ��ȥ��Լ����������
          then
            V_COB_TABLESQL := REPLACE(REPLACE(V_COB_TABLESQL, '"."', '"."WK_'),'CONSTRAINT','<');
            V_COB_TABLESQL := regexp_substr(V_COB_TABLESQL, '[^<]+',1,1,'i');--ȥ���������
            V_COB_TABLESQL := substr(V_COB_TABLESQL ,1 ,instr(V_COB_TABLESQL ,',' ,-1 ,1)-1)||'
       )';--�ص����һ�����ţ������������' )' 
        else--Դ����Լ��ʱ������ƴ��
            V_COB_TABLESQL := REPLACE(V_COB_TABLESQL, '"."', '"."WK_');  
        end if;
        
        --��ȡʱ���ֶ���������
        select column_name into V_DATE_FIELD from USER_TAB_COLUMNS t
        where column_id||'-'||table_name in
        (
            select min(t.column_id)||'-'||max(table_name) from USER_TAB_COLUMNS t
            where t.table_name = I_FROM_TABLENAME--'LC_INDEX_LXN_BAD_CELL_MTH_ORC_TEST'
            and t.data_type = 'DATE' --order by column_id
            --group by column_name
        );
        --dbms_output.put_line('2��'||V_COB_TABLESQL);--��ӡ�����������
        
        --��������Ӧʱ���
        V_DATE := trunc(to_date(I_DATE_THRESHOLD_START,'yyyymmdd'), 'mm');--��ʼʱ���'yyyymmdd'��ʽ��--in��2019/07/02 out��2019/07/01

        if I_TM_GRN = '2'
          then
            --�켶Ҳ���������½�������
            V_PART_NAME := 'P_' ||to_char(V_DATE,'yyyymmdd');--P_20190702
            V_DATE_THRESHOLD_PART := to_char(V_DATE + 1,'YYYY-MM-DD');--2019-07-03
            --V_DATE_NAME := ' VALUES LESS THAN (TO_DATE('''|| V_DATE_THRESHOLD_PART||' 00:00:00'',''YYYY-MM-DD HH24:MI:SS'')) ';--ƴ��ʱ��
            V_COB_TBSP_PARTITIONSQL :=
            'PARTITION BY RANGE ('||V_DATE_FIELD||')
            (
              PARTITION '||V_PART_NAME||' VALUES LESS THAN (TO_DATE('''||V_DATE_THRESHOLD_PART||' 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''))
                TABLESPACE '||I_TABLESPACE||'
            )'
            ;
            V_COB_TABLESQL := V_COB_TABLESQL ||V_COB_TBSP_PARTITIONSQL;

        elsif I_TM_GRN = '3'
          then
            V_DATE := next_day(V_DATE, '����һ') - 7;--��ʼʱ���'yyyymmdd'��ʽ��--in��2019/07/02 out��2019/07/01
            --trunc(next_day(sysdate,'����һ'))-7
            --�ܼ�Ҳ���������½�������
            V_PART_NAME := 'P_' ||to_char(V_DATE,'yyyymmdd');--P_20190701
            V_DATE_THRESHOLD_PART := to_char(V_DATE + 7,'YYYY-MM-DD');--2019-07-08
            --V_DATE_NAME := ' VALUES LESS THAN (TO_DATE('''|| V_DATE_THRESHOLD_PART||' 00:00:00'',''YYYY-MM-DD HH24:MI:SS'')) ';--ƴ��ʱ��
            V_COB_TBSP_PARTITIONSQL :=
            'PARTITION BY RANGE ('||V_DATE_FIELD||')
            (
              PARTITION '||V_PART_NAME||' VALUES LESS THAN (TO_DATE('''||V_DATE_THRESHOLD_PART||' 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''))
                TABLESPACE '||I_TABLESPACE||'
            )'
            ;
            V_COB_TABLESQL := V_COB_TABLESQL ||V_COB_TBSP_PARTITIONSQL;

        elsif I_TM_GRN = '4'
          then
            V_PART_NAME := 'P_' ||to_char(V_DATE,'yyyymmdd');--P_20190701
            --V_DATE_THRESHOLD_PART := to_char(add_months(V_DATE,1),'YYYY-MM-DD');--2019-08-01
            --д��2��sysdate + interval '-1' MONTH
            V_DATE_THRESHOLD_PART := to_char((V_DATE + interval '1' MONTH),'YYYY-MM-DD');--2019-08-01
            --V_DATE_NAME := ' VALUES LESS THAN (TO_DATE('''||V_DATE_THRESHOLD_PART||' 00:00:00'',''YYYY-MM-DD HH24:MI:SS'')) ';--ƴ��ʱ��

            V_COB_TBSP_PARTITIONSQL :=
            'PARTITION BY RANGE ('||V_DATE_FIELD||')
            (
              PARTITION '||V_PART_NAME||' VALUES LESS THAN (TO_DATE('''||V_DATE_THRESHOLD_PART||' 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''))
                TABLESPACE '||I_TABLESPACE||'
            )'
            ;
            --dbms_output.put_line(V_COB_TABLESQL);--��ӡ�����������
            V_COB_TABLESQL := V_COB_TABLESQL ||V_COB_TBSP_PARTITIONSQL;

        end if;
        --dbms_output.put_line('3��'||V_COB_TBSP_PARTITIONSQL);--��ӡ�����������


        --�������ݷ���2���½�������WK_A�����ݻؿ⣬DROPԭ��A��������������WK_A��A
        --�ؽ�WK_A����������A �� DDL_SQL �� WK_A
        --dbms_output.put_line('4��'||V_COB_TABLESQL);--��ӡ�����������
        EXECUTE IMMEDIATE V_COB_TABLESQL;
        
        --�����±� WK_A �ķ���
        --PKG_MANAGE_SYSTEM_SHIN_PLUS8.PROC_PARTITION_ADD_RANGE('WK_'||I_FROM_TABLENAME, I_TM_GRN ,I_DATE_THRESHOLD_START, TO_CHAR(SYSDATE,'yyyymmdd'),I_TABLESPACE);
        PKG_MANAGE_SYSTEM_SHIN_PLUS8.PROC_PARTITION_ADD_RANGE('WK_'||I_FROM_TABLENAME, 
                                                                                                            I_TM_GRN, 
                                                                                                            to_char(V_DATE,'yyyymmdd'), 
                                                                                                            I_DATE_THRESHOLD_START, 
                                                                                                            I_TABLESPACE);    
        --���ݻر� A �� WK_A
        EXECUTE IMMEDIATE 'ALTER TABLE WK_'||I_FROM_TABLENAME||' NOLOGGING';             
        --V_COB_A2WKA := 'INSERT /*+append */ INTO WK_'||I_FROM_TABLENAME||' SELECT * FROM '||I_FROM_TABLENAME;
        --EXECUTE IMMEDIATE V_COB_A2WKA;
        
        --EXECUTE IMMEDIATE 'INSERT INTO WK_'||I_FROM_TABLENAME||' SELECT * FROM '||I_FROM_TABLENAME;
        --dbms_output.put_line('5��'||V_COB_A2WKA);--��ӡ�����������
        COMMIT;
        --EXECUTE IMMEDIATE 'ALTER TABLE WK_'||I_FROM_TABLENAME||' LOGGING';             
        --dbms_output.put_line('�� WK_'||I_FROM_TABLENAME||' ����������ɣ�');--ִ��SQL��������    
        
        --ɾ��ԭ��A
        --EXECUTE IMMEDIATE 'DROP TABLE '||I_FROM_TABLENAME||' PURGE'; 
        
        --�������±� WK_A���������� �� A
        V_SSQL := 'ALTER TABLE WK_'||I_FROM_TABLENAME||' RENAME TO '||I_FROM_TABLENAME;
        dbms_output.put_line('6��'||V_SSQL);--��ӡ�����������
        --EXECUTE IMMEDIATE V_SSQL;
        dbms_output.put_line('�� WK_'||I_FROM_TABLENAME||' ���������� '||I_FROM_TABLENAME||' ��');--ִ��SQL��������
        


     END SQL_GET_DDL_WK;


-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
  PROCEDURE SQL_GET_DDL(I_FROM_TABLENAME VARCHAR2,  I_TM_GRN VARCHAR2,  I_FROM_OWNER VARCHAR2, I_TABLESPACE VARCHAR2, I_DATE_THRESHOLD_START VARCHAR2) is
     V_DATE  date;
     V_COB_TABLESQL CLOB;--Ԫ����
     V_COB_TBSP_PARTITIONSQL CLOB;--��ռ�&�����洢
     V_COB_A2WKA varchar2(500);
     V_SSQL varchar2(500);
     V_DATE_FIELD  varchar2(30);--ʱ���ֶ���
     V_DATE_THRESHOLD_PART varchar2(20);
     V_PART_NAME   varchar2(30);--������ƴ��
     PK_FLAG number;
     --V_DATE_NAME   varchar2(200);--������չʱ���SQLƴ��

     BEGIN
        --������Ԫ���ݣ����ಿ���޳�
        BEGIN
          --�رմ洢����ռ�����
          DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'STORAGE',FALSE);
          --DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'TABLESPACE',TRUE);

          --�رմ������PCTFREE��NOCOMPRESS������
          --PCTFREE���鱣��10%�Ŀռ��������¸ÿ�����ʹ��
          DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'SEGMENT_ATTRIBUTES',FALSE);
          --������Ϣ
          DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'PARTITIONING',FALSE);
          --�����Ϣ�������Ż��и�ʽ��
          /*DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'PRETTY',FALSE);*/--����Ȩ�����⣬������
        END;
                
        SELECT DBMS_METADATA.GET_DDL('TABLE',I_FROM_TABLENAME,I_FROM_OWNER)
        INTO V_COB_TABLESQL
        FROM DUAL;--����Ԫ����
        --dbms_output.put_line('1��'||V_COB_TABLESQL);--��ӡ�����������
        
        --����Լ���Ƿ�����ж�
        select count(distinct u.constraint_type) into PK_FLAG
        from user_constraints u where u.table_name = I_FROM_TABLENAME--'NE_MME_L'
        and u.constraint_type = 'P';    
        
        --Ԫ���ݱ���ƴ�� 'WK_'
        if PK_FLAG <> 0 --Դ��Լ��ʱ��ȥ��Լ����������
          then
            V_COB_TABLESQL := REPLACE(REPLACE(V_COB_TABLESQL, '"."', '"."WK_'),'CONSTRAINT','<');
            V_COB_TABLESQL := regexp_substr(V_COB_TABLESQL, '[^<]+',1,1,'i');--ȥ���������
            V_COB_TABLESQL := substr(V_COB_TABLESQL ,1 ,instr(V_COB_TABLESQL ,',' ,-1 ,1)-1)||'
       )';--�ص����һ�����ţ������������' )' 
        else--Դ����Լ��ʱ������ƴ��
            V_COB_TABLESQL := REPLACE(V_COB_TABLESQL, '"."', '"."WK_');  
        end if;
        
        --��ȡʱ���ֶ���������
        select column_name into V_DATE_FIELD from USER_TAB_COLUMNS t
        where column_id||'-'||table_name in
        (
            select min(t.column_id)||'-'||max(table_name) from USER_TAB_COLUMNS t
            where t.table_name = I_FROM_TABLENAME--'LC_INDEX_LXN_BAD_CELL_MTH_ORC_TEST'
            and t.data_type = 'DATE' --order by column_id
            --group by column_name
        );
        --dbms_output.put_line('2��'||V_COB_TABLESQL);--��ӡ�����������
        
        --��������Ӧʱ���
        V_DATE := trunc(to_date(I_DATE_THRESHOLD_START,'yyyymmdd'), 'mm');--��ʼʱ���'yyyymmdd'��ʽ��--in��2019/07/02 out��2019/07/01

        if I_TM_GRN = '2'
          then
            --�켶Ҳ���������½�������
            V_PART_NAME := 'P_' ||to_char(V_DATE,'yyyymmdd');--P_20190702
            V_DATE_THRESHOLD_PART := to_char(V_DATE + 1,'YYYY-MM-DD');--2019-07-03
            --V_DATE_NAME := ' VALUES LESS THAN (TO_DATE('''|| V_DATE_THRESHOLD_PART||' 00:00:00'',''YYYY-MM-DD HH24:MI:SS'')) ';--ƴ��ʱ��
            V_COB_TBSP_PARTITIONSQL :=
            'PARTITION BY RANGE ('||V_DATE_FIELD||')
            (
              PARTITION '||V_PART_NAME||' VALUES LESS THAN (TO_DATE('''||V_DATE_THRESHOLD_PART||' 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''))
                TABLESPACE '||I_TABLESPACE||'
            )'
            ;
            V_COB_TABLESQL := V_COB_TABLESQL ||V_COB_TBSP_PARTITIONSQL;

        elsif I_TM_GRN = '3'
          then
            V_DATE := next_day(V_DATE, '����һ') - 7;--��ʼʱ���'yyyymmdd'��ʽ��--in��2019/07/02 out��2019/07/01
            --trunc(next_day(sysdate,'����һ'))-7
            --�ܼ�Ҳ���������½�������
            V_PART_NAME := 'P_' ||to_char(V_DATE,'yyyymmdd');--P_20190701
            V_DATE_THRESHOLD_PART := to_char(V_DATE + 7,'YYYY-MM-DD');--2019-07-08
            --V_DATE_NAME := ' VALUES LESS THAN (TO_DATE('''|| V_DATE_THRESHOLD_PART||' 00:00:00'',''YYYY-MM-DD HH24:MI:SS'')) ';--ƴ��ʱ��
            V_COB_TBSP_PARTITIONSQL :=
            'PARTITION BY RANGE ('||V_DATE_FIELD||')
            (
              PARTITION '||V_PART_NAME||' VALUES LESS THAN (TO_DATE('''||V_DATE_THRESHOLD_PART||' 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''))
                TABLESPACE '||I_TABLESPACE||'
            )'
            ;
            V_COB_TABLESQL := V_COB_TABLESQL ||V_COB_TBSP_PARTITIONSQL;

        elsif I_TM_GRN = '4'
          then
            V_PART_NAME := 'P_' ||to_char(V_DATE,'yyyymmdd');--P_20190701
            --V_DATE_THRESHOLD_PART := to_char(add_months(V_DATE,1),'YYYY-MM-DD');--2019-08-01
            --д��2��sysdate + interval '-1' MONTH
            V_DATE_THRESHOLD_PART := to_char((V_DATE + interval '1' MONTH),'YYYY-MM-DD');--2019-08-01
            --V_DATE_NAME := ' VALUES LESS THAN (TO_DATE('''||V_DATE_THRESHOLD_PART||' 00:00:00'',''YYYY-MM-DD HH24:MI:SS'')) ';--ƴ��ʱ��

            V_COB_TBSP_PARTITIONSQL :=
            'PARTITION BY RANGE ('||V_DATE_FIELD||')
            (
              PARTITION '||V_PART_NAME||' VALUES LESS THAN (TO_DATE('''||V_DATE_THRESHOLD_PART||' 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''))
                TABLESPACE '||I_TABLESPACE||'
            )'
            ;
            --dbms_output.put_line(V_COB_TABLESQL);--��ӡ�����������
            V_COB_TABLESQL := V_COB_TABLESQL ||V_COB_TBSP_PARTITIONSQL;

        end if;
        --dbms_output.put_line('3��'||V_COB_TBSP_PARTITIONSQL);--��ӡ�����������


        --�������ݷ���2���½�������WK_A�����ݻؿ⣬DROPԭ��A��������������WK_A��A
        --�ؽ�WK_A����������A �� DDL_SQL �� WK_A
        --dbms_output.put_line('4��'||V_COB_TABLESQL);--��ӡ�����������
        EXECUTE IMMEDIATE V_COB_TABLESQL;
        
        --�����±� WK_A �ķ���
        --PKG_MANAGE_SYSTEM_SHIN_PLUS8.PROC_PARTITION_ADD_RANGE('WK_'||I_FROM_TABLENAME, I_TM_GRN ,I_DATE_THRESHOLD_START, TO_CHAR(SYSDATE,'yyyymmdd'),I_TABLESPACE);
        PKG_MANAGE_SYSTEM_SHIN_PLUS8.PROC_PARTITION_ADD_RANGE('WK_'||I_FROM_TABLENAME, 
                                                                                                            I_TM_GRN, 
                                                                                                            to_char(V_DATE,'yyyymmdd'), 
                                                                                                            I_DATE_THRESHOLD_START, 
                                                                                                            I_TABLESPACE);    
        --���ݻر� A �� WK_A
        EXECUTE IMMEDIATE 'ALTER TABLE WK_'||I_FROM_TABLENAME||' NOLOGGING';  
        V_COB_A2WKA := 'INSERT /*+append */ INTO WK_'||I_FROM_TABLENAME||' SELECT * FROM '||I_FROM_TABLENAME;
        --EXECUTE IMMEDIATE V_COB_A2WKA;
        
        --EXECUTE IMMEDIATE 'INSERT INTO WK_'||I_FROM_TABLENAME||' SELECT * FROM '||I_FROM_TABLENAME;
        dbms_output.put_line('���ݻر���䣨ִ���ݲ��򿪣���'||V_COB_A2WKA);--��ӡ�����������
        COMMIT;
        --dbms_output.put_line('�� WK_'||I_FROM_TABLENAME||' ����������ɣ�');--ִ��SQL��������    
        
        --ɾ��ԭ��A
        PKG_MANAGE_SYSTEM_SHIN_PLUS8.DROPTABLE_IFEXISTS(I_FROM_TABLENAME, '1');
        --EXECUTE IMMEDIATE 'DROP TABLE '||I_FROM_TABLENAME||' PURGE'; 
        
        --�������±� WK_A���������� �� A
        V_SSQL := 'ALTER TABLE WK_'||I_FROM_TABLENAME||' RENAME TO '||I_FROM_TABLENAME;
        dbms_output.put_line('6��'||V_SSQL);--��ӡ�����������
        EXECUTE IMMEDIATE V_SSQL;
        dbms_output.put_line('�� WK_'||I_FROM_TABLENAME||' ���������� '||I_FROM_TABLENAME||' ��');--ִ��SQL��������
        


     END SQL_GET_DDL;

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
  PROCEDURE DROPTABLE_IFEXISTS(I_TABLE_NAME VARCHAR2, PURGE_FLAG NUMBER) AS
    --drop table
    --purge_flag = 1 ����ɾ�� 0 ������ɾ��
    v_tablename varchar2(50);
    v_flag number(10 ,0) := 0;
    ssql varchar2(300);
    BEGIN
          v_tablename:=UPPER(I_TABLE_NAME);
          ssql:= 'select count(*) from USER_TABLES where table_name='''||v_tablename|| '''';
          execute immediate ssql into v_flag;
          if v_flag = 1 and purge_flag = 1 then
             begin
                ssql:= 'drop table '||v_tablename||' purge' ;
                execute immediate ssql;
                commit;
             end;
          elsif v_flag = 1 and purge_flag = 0 then
             begin
                ssql:= 'drop table '||v_tablename;
                execute immediate ssql;
                commit;
             end;
          end if ;
    END DROPTABLE_IFEXISTS;
    
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
  PROCEDURE PROC_LOGGING(I_SDATE DATE, I_PKG_NAME VARCHAR2,  I_INSIDE_LOOP_LOG NUMBER,  I_EXSIT_FLAG NUMBER) IS
    BEGIN
        insert into DB_CHECK(execute_sdate, execute_sql, v_loop_log, v_exsit_flag)
        (
          select I_SDATE,
          I_PKG_NAME||'('||to_char(I_SDATE, 'yyyymmdd')||')',
          I_INSIDE_LOOP_LOG,
          I_EXSIT_FLAG
          from dual
        );
        commit;
        dbms_output.put_line('LOG�ɼ����...');

    END PROC_LOGGING;


-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
  PROCEDURE PROC_TEST IS
    BEGIN
        insert into LC_INDEX_LXN_BAD_CELL_DAY_ORC_TEST(start_time, area, area_level)
        (
          select sysdate,
          '�Ϻ�',
          '�Ϻ�'
          from dual
        );
        commit;
        dbms_output.put_line('LC_INDEX_LXN_BAD_CELL_DAY_ORC_TEST�����������...');

    END PROC_TEST;
        

END PKG_MANAGE_SYSTEM_SHIN_PLUS8;
/

