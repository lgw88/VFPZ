#If Version(3) = "86"
*-- ��������
	*** ToolTipText
	***
	#Define ManyHeader_Controls_ImgLock  "���б�ǣ��ڴ˴��������������Ų��ƶ����"
	***
	***

	*** InitHeader
	#Define ManyHeader_InitHeader_1		"�� InitHeader �б��봫��һ����Ч GRID ���������"
	#Define ManyHeader_InitHeader_2		"�� AllowCellSelection = .F. ʱ������ Valid ������Ҫһ�п�ָ���������һ�� * ָ�"

	*** MergeHeader
	#Define ManyHeader_MergeHeader_1	"ManyHeader δ�� GRID ������󶨻��� GRID ������Ч��"
	#Define ManyHeader_MergeHeader_2	"δָ���ϲ������ͷ�ı��⣡"
	#Define ManyHeader_MergeHeader_3	"δָ����Ҫ�ϲ����з�Χ��"
	#Define ManyHeader_MergeHeader_4	"�ϲ��е���ʼλ��Ӧ�ô�����ֹλ�ã�"
	#Define ManyHeader_MergeHeader_5	"ָ�����з�Χ�Ƿ�����ʼ��Ӧ���� 0��"
	#Define ManyHeader_MergeHeader_6	"ָ�����з�Χ�Ƿ�����ֹ�в��ܴ��ڱ���е�������"

	*** HeaderLock
	#Define ManyHeader_HeaderLock_1		"���������ͷ�Ĳ����У��뽫��չ�������������������������С�"

	*** HeaderSwap
	#Define ManyHeader_HeaderSwap_1		"����ִ������������ӱ�ͷ���ӱ�ͷ�ĸ���ͷ�޷��Ե�˳��"
	#Define ManyHeader_HeaderSwap_2		"ϵͳ���󣡣�û��ƥ��Ľ���������"

	*** GetHeaderLeft
	#Define ManyHeader_GetHeaderLeft_1	"����� nType = "

#ElIf Version(3) = "88"
*-- �c�餤��
	*** ToolTipText
	***
	#Define ManyHeader_Controls_ImgLock  "��C�аO�A�b���B���U���Х��䤣��ò��ʹ���"
	***
	***

	*** InitHeader
	#Define ManyHeader_InitHeader_1		"�b InitHeader �������ǻ��@�Ӧ��� GRID ��H�Ѽ�!"
	#Define ManyHeader_InitHeader_2		"�� AllowCellSelection = .F. �ɡA��檺 Valid �ܤֻݭn�@��ū��O�A���H�K�K�[�@�� * ���O�C"

	*** MergeHeader
	#Define ManyHeader_MergeHeader_1	"ManyHeader ���P GRID ��H�۸j�w�Ϊ� GRID ��H�v�L�ġI"
	#Define ManyHeader_MergeHeader_2	"�����w�X�æZ�ռ��Y�����D�I"
	#Define ManyHeader_MergeHeader_3	"�����w�N�n�X�ê��C�S��I"
	#Define ManyHeader_MergeHeader_4	"�X�æC���_�l��m���Ӥj�_�פ��m�I"
	#Define ManyHeader_MergeHeader_5	"���w���C�S��D�k�I�_�l�C���j�_ 0�C"
	#Define ManyHeader_MergeHeader_6	"���w���C�S��D�k�I�פ�C����j�_���C���`�ơC"

	*** HeaderLock
	#Define ManyHeader_HeaderLock_1		"������ռ��Y�������C�A�бN�ծi�}�Z�q�ժ��̥��C���k�̦���C�C"

	*** HeaderSwap
	#Define ManyHeader_HeaderSwap_1		"�������o�Ӿާ@�I�l���Y�P�l���Y�������Y�L�k��ն��ǡI"
	#Define ManyHeader_HeaderSwap_2		"�t�ο��~�I�I�S���ǰt���洫��סI"

	*** GetHeaderLeft
	#Define ManyHeader_GetHeaderLeft_1	"���~�� nType = "

#Else
*-- Englisth
	*** ToolTipText
	***
	#Define ManyHeader_Controls_ImgLock  "Tag of Lock,Its can be drag and drop to different location."
	***
	***

	*** InitHeader
	#Define ManyHeader_InitHeader_1		"InitHeader in need of an effective transfer of the GRID object as a parameter!"
	#Define ManyHeader_InitHeader_2		"When AllowCellSelection =. F., Grid.Valid() methods can not be empty. not add his command: *"

	*** MergeHeader
	#Define ManyHeader_MergeHeader_1	"Please run headerInit() bind GRID object first!"
	#Define ManyHeader_MergeHeader_2	"After the merger does not specify the title of the header group!"
	#Define ManyHeader_MergeHeader_3	"Is not specified to be out of the merger!"
	#Define ManyHeader_MergeHeader_4	"Merger out of the starting position should be greater than the termination position!"
	#Define ManyHeader_MergeHeader_5	"Designated out of the illegal! Start out should be greater than 0."
	#Define ManyHeader_MergeHeader_6	"Designated out of the illegal! Termination are not greater than the total number of forms out."

	*** HeaderLock
	#Define ManyHeader_HeaderLock_1		"Group can not lock out the group part, please expand group and lock by left Column."

	*** HeaderSwap
	#Define ManyHeader_HeaderSwap_1		"Unable to perform this operation! Father and son header order can not be reversed."
	#Define ManyHeader_HeaderSwap_2		"System Error! Can not solve the problems."

	*** GetHeaderLeft
	#Define ManyHeader_GetHeaderLeft_1	"NTYPE the wrong values = "

#EndIf