-- 用户信息
create table user
(
	user_tel int pk,  			/* 用户的手机号 */
	user_password text, 		/* 用户密码 */
	user_type	int 			/* 用户类型, 医生/患者/其它 */
)
;

-- 患者信息
create table patient_info
(
	patient_id int pk,				
	patient_tel int,
	patient_name text,
	patient_birth_year int,
	patient_medical_history text,
	allergy text,
	patient_address text,
	patient_pay_info text,
	patient_score int,
	patient_consume_limit int,
	patient_insurance_info int,

	FOREIGN KEY (patient_tel) REFERENCES user(user_tel)
)
;

-- 医生信息
create table doctor_info
{
	doctor_id int pk,				/* 医生编号 */				
	doctor_name text,				/* 医生姓名 */
	doctor_password text,			/* 登录密码 */
	doctor_birth_year int,			/* 出生年份 */
	doctor_tel		  int,			/* 医生电话 */
	doctor_mail		  text,			/* 医生邮箱 */
	hospital_id 	id,				/* 医生所在医院 */
	doctor_level text,				/* 医生职称 */
	doctor_license int,				/* 医师编号 */

	FOREIGN KEY (patient_tel) REFERENCES user(uer_tel)
	FOREIGN KEY (hospital_id) REFERENCES hospital_info(hospital_id)
}
;

-- 医院信息
create table hospital_info
{
	hospital_id int pk,			  /* 医院编号 */
	hospital_name text,				  /* 医院名称 */
	hospital_eng_name text,			  /* 医院英文名 */
	hospital_insurance int,			  /* 医保信息 */
	hospital_level text,			  /* 医院级别 */	
	hospital_city text,				  /* 医院所在城市 */
	hospital_address text,			  /* 医院详细地址 */
	hospital_tel int,				  /* 医院电话 */
	hospital_license text			  /* 医院定点医疗机构编码 */
}
;

-- 邀约表
create table invitation_order_info
{
	order_id int pk,					/* 邀约编号 */
	doctor_id int,						/* 医生编号 */
	patient_ids set,					/* 邀约的患者编号，多个，使用集合类型保存 */
	order_deploy_time timestamp,		/* 发布时间 */
	order_implement_time timestamp,		/* 邀约诊疗时间，用于计算时间 */
	order_address text,					/* 诊疗地址 */
	order_patients_num int,				/* 邀约人数 */
	order_real_pat_num int,				/* 实际诊疗人数 */
	order_price int,					/* 邀约价格 */
	order_status int,					/* 邀约状态: 取消，正常 */
	order_disease_desc text,			/* 备注信息: 可选病症，医生科室信息 */

	FOREIGN KEY (doctor_id) REFERENCES doctor_info(doctor_id)
}

-- 处方表
create table prescription_info
{
	prescription_id int,				/* 处方编号 */
	invitation_id int,					/* 邀约编号 */
	doctor_id int,						/* 医生编号 */
	patient_id int,						/* 患者编号 */
	patient_gender int,					/* 患者性别 */
	patient_age int,					/* 患者年龄 */
	disease_desc text,					/* 病症描述 */
	diagnosis_result text,				/* 诊断结果 */
	disease_catalog text,				/* 诊断结果病症的类别 */
	prescription_detail text			/* 处方内容， 字符串保存的类 json 格式 */
	prescription_doctor_eval text,			/* 医生对病人的评价 */
	prescription_patient_eval text			/* 病人对医生的评价 */

	FOREIGN KEY (doctor_id) REFERENCES doctor_info(doctor_id),
	FOREIGN KEY (patient_id) REFERENCES patient_info(patient_id)
	FOREIGN KEY (invitation_id) REFERENCES invitation_order_info(order_id)
}
;

-- 药品信息
create table medicine_info
{
	medicine_id int pk,					/* 药品名 */
	medicine_custom_name text,			/* 常用名 */
	medicine_standard_name text,		/* 学名 */
	medicine_eng_name text,				/* 英文名 */
	medicine_insurance_type int         /* 药品的医保类型 */
}
;

