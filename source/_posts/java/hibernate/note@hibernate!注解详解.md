hibernateע���CascadeType����

cascade��ʾ��������   

CascadeType.MERGE�������£���items�����޸�����ôorder���󱣴�ʱͬʱ�޸�items��Ķ��󡣶�ӦEntityManager��merge���� 
  
CascadeType.PERSIST����ˢ�£���ȡorder������ҲͬʱҲ���»�ȡ���µ�itemsʱ�Ķ��󡣶�ӦEntityManager��refresh(object)������Ч���������²�ѯ���ݿ������������   
   
CascadeType.REFRESH�������棺��order���󱣴�ʱҲ��items��Ķ���Ҳ�ᱣ�档��ӦEntityManager��presist����   
   
CascadeType.REMOVE����ɾ������order����ɾ��Ҳ��items��Ķ���Ҳ��ɾ������ӦEntityManager��remove����   
CascadeType.PERSISTֻ��A������ʱ���ἶ��B������������B���������ݿ�棨���£��������쳣����B��Ϊ�־�̬��
CascadeType.MERGEָA���������߱仯���ἶ��B�����������߱仯��
CascadeType.REMOVEֻ��A��ɾ��ʱ���ἶ��ɾ��B�ࣻ
CascadeType.ALL�������У�
CascadeType.REFRESHû�ù���
���ϣ�����������CascadeType.MERGE���ܴﵽ���������ֲ�������CascadeType.ALLʱҪ������CascadeType.REMOVE
@Fetch:
�����˼��ع�����ϵ�Ļ�ȡ����. FetchMode ������
SELECT (����Ҫ���ع�����ʱ�򴥷�select����), SUBSELECT(ֻ�Լ�����Ч,ʹ�����Ӳ�ѯ����,����ο�hibernate�ο��ĵ�)
JOIN (�ڼ�����ʵ��(owner entity)��ʱ��ʹ��SQL JOIN�����ع�����ϵ).
JOIN ����д�κ��ӳ����� (ͨ�� JOIN���Լ��صĹ��������پ����ӳ���).