/* DRUGSTORECHAIN is a database that has The prescriptions chain of pharmacies  */

/* DRUGSTORECHAIN - CREATE TABLE statements  */

-- create the database
DROP DATABASE IF EXISTS drugstorechain;
CREATE DATABASE drugstorechain;

-- select the database
USE drugstorechain;

-- create tables and data    
CREATE TABLE doctor
(	doctorid	CHAR(5) NOT NULL,
	doctorssn	CHAR(11) NOT NULL,
	doctorname	VARCHAR(40)	NOT NULL,
    specialty	VARCHAR(40)	NOT NULL,
    years_experience	INTEGER		NOT NULL,
    PRIMARY KEY (doctorid) );
 
CREATE TABLE patient 
(   patientid 	CHAR(5)	NOT NULL,
	patientssn 	CHAR(11)	NOT NULL,
	patientname VARCHAR(40)	NOT NULL,
    primary_physicianid	CHAR(5)	NOT NULL, 
	age 		INTEGER		NOT NULL,
	address 	VARCHAR(95)	NOT NULL,
    CHECK (age > 0),
    CHECK (age < 120),
	PRIMARY KEY (patientid),
	FOREIGN KEY (primary_physicianid) REFERENCES doctor(doctorid));    

CREATE TABLE pharmaceuticalcompany
(	pharmid 	CHAR(5)	NOT NULL,
	pharmaname	VARCHAR(40)	NOT NULL,
	phone_number	VARCHAR(12)	NOT NULL,
    PRIMARY KEY (pharmid) );

CREATE TABLE drug 
(	drugid 		CHAR(5)	NOT NULL,
	tradename 	VARCHAR(40)	NOT NULL,
	pharmid 	CHAR(5)	NOT NULL,
    formula		VARCHAR(256)	NOT NULL,
	PRIMARY KEY (drugid),
	FOREIGN KEY (pharmid) REFERENCES pharmaceuticalcompany (pharmid) ON DELETE CASCADE);

CREATE TABLE pharmacy 
( 	pharmacyid	CHAR(5)	NOT NULL,
	pharmacyname 	VARCHAR(40)	NOT NULL,
	phone_number 	CHAR(12)	NOT NULL,
	pharmacyaddress 	VARCHAR(95)	NOT NULL,
	PRIMARY KEY (pharmacyid));

CREATE TABLE contract
( 	contractid 		CHAR(5)	NOT NULL,
	pharmacyid		CHAR(5)	NOT NULL,
	pharmid 		CHAR(5)	NOT NULL,
	start_date 		DATE		NOT NULL,
	end_date 		DATE		NOT NULL,
	contract_folder	VARCHAR(256)	NOT NULL, /*CONTRACT FOLDER LOCATION*/
	supervisor 		VARCHAR(40)	NOT NULL,
    CHECK (start_date < end_date),
	PRIMARY KEY (contractid),
	FOREIGN KEY (pharmacyid) REFERENCES pharmacy (pharmacyid),
	FOREIGN KEY (pharmid) REFERENCES pharmaceuticalcompany (pharmid));
    
CREATE TABLE drug_list 
( 	productid	CHAR(5)	NOT NULL,
	drugid 		CHAR(5)	NOT NULL,
	pharmacyid	CHAR(5)	NOT NULL,
	price 		NUMERIC(7,2)	NOT NULL,
    CHECK (price > 0),
    PRIMARY KEY (productid),
	FOREIGN KEY (pharmacyid) REFERENCES pharmacy (pharmacyid),
	FOREIGN KEY (drugid) REFERENCES drug (drugid));

CREATE TABLE prescription 
( 	prescriptionid	CHAR(5)	NOT NULL,
	productid	CHAR(5)	NOT NULL,
    patientid 	CHAR(5)		NOT NULL,
	doctorid 	CHAR(5)	NOT NULL,
    issue_date 	DATE		NOT NULL,
	filled_date DATE	NOT NULL,
	quantity 	INTEGER		NOT NULL,
    CHECK (filled_date >= issue_date),
    CHECK (quantity > 0),
	PRIMARY KEY (prescriptionid),
	FOREIGN KEY (patientid) REFERENCES patient (patientid),
	FOREIGN KEY (doctorid) REFERENCES doctor (doctorid),
	FOREIGN KEY (productid) REFERENCES drug_list (productid));

/* PENDING VALUES FOR DRUGSTORE CHAIN */
    
/* drugstorechain - INSERT INTO statements  -	INSERT INTO ____ VALUES ('','','','');  */
INSERT INTO doctor VALUES ('24564','987-45-3124','Derek Shepherd','Neurosurgeon','20');
INSERT INTO doctor VALUES ('24897','316-45-9631','Owen Hunt','Trauma Surgery','20');
INSERT INTO doctor VALUES ('54598','326-98-7531','Meredith Grey','General Surgery','15');
INSERT INTO doctor VALUES ('54984','484-78-1575','Cristina Yang','Cardiothoracic Surgery','15');
INSERT INTO doctor VALUES ('59831','231-45-4681','Alex Karev','Pediatric Surgery','15');

INSERT INTO patient VALUES ('K7HEU','456-15-4512','Bobby Smith','24564','45','322 Vine Ave. Simi Valley, CA 93065');
INSERT INTO patient VALUES ('3CVEM','172-09-0493','Parker Roger','24564','32','654 Summerhouse St. San Jose, CA 95111');
INSERT INTO patient VALUES ('NVCVY','609-75-3964','Will Chandler','54598','39','9500 Cross St. Victorville, CA 92392');
INSERT INTO patient VALUES ('YQQMM','389-65-4132','Claudia Carley','54598','24','67 South Oak Ave. Paramount, CA 90723');
INSERT INTO patient VALUES ('463IR','463-48-5479','Rose Mary Barrows','24897','29','5 East Valley Farms St. Riverside, CA 92509');
INSERT INTO patient VALUES ('45REF','420-90-0505','Nicola Childs','24897','13','7563 Fremont Court Salinas, CA 93906');
INSERT INTO patient VALUES ('K8ZE0','419-11-0655','Shanelle Marquez','54598','16','936 Gulf Ave. Sylmar, CA 91342');
INSERT INTO patient VALUES ('9W4VS','416-92-3151','Khadija Michael','54984','17','8963 W. Fieldstone Drive San Diego, CA 92117');
INSERT INTO patient VALUES ('Y65F2','625-31-2775','Andrei Kaur','54984','18','8383 Joy Ridge Ave. Anaheim, CA 92801');
INSERT INTO patient VALUES ('LRXW6','621-35-7425','Cherish Shaw','59831','60','9179 Hawthorne Dr. Anaheim, CA 92804');
INSERT INTO patient VALUES ('9HZKF','565-83-7079','Ashlee Cote','59831','23','8991 Winchester Street San Francisco, CA 94112');

INSERT INTO pharmaceuticalcompany VALUES ('JII8','Johnson & Johnson','818-202-3047');
INSERT INTO pharmaceuticalcompany VALUES ('4KET','Pfizer','423-300-9093');
INSERT INTO pharmaceuticalcompany VALUES ('WHVS','Roche','608-264-9476');
INSERT INTO pharmaceuticalcompany VALUES ('9P2X','Novartis','641-221-4551');
INSERT INTO pharmaceuticalcompany VALUES ('7GNB','GlaxoSmithKline','313-349-8627');
INSERT INTO pharmaceuticalcompany VALUES ('QZ4W','Merck & Co.','732-725-8056');
INSERT INTO pharmaceuticalcompany VALUES ('MTFS','Sanofi','315-912-8229');

INSERT INTO drug VALUES ('VI21','Vicodin','JII8','4,5α-epoxy-3-methoxy-17-methylmorphinan-6-one tartrate (1:1) hydrate (2:5)');
INSERT INTO drug VALUES ('TY89','Tylenol','4KET','N-acetyl-p-aminophenol');
INSERT INTO drug VALUES ('MU99','Mucinex','4KET','2-(diphenylmethoxy)-N,N-dimethylethylamine hydrochloride');
INSERT INTO drug VALUES ('CL40','Claritin','WHVS','ethyl 4-(8-chloro-5,6-dihydro-11H-benzo[5,6]cyclohepta[1,2-b]pyridin-11-ylidene) -1-piperidinecarboxylate');
INSERT INTO drug VALUES ('LI31','Lipitor','9P2X','(3R,5R)-7-[2-(4-fluorophenyl)-3-phenyl-4-(phenylcarbamoyl)-5-propan-2-ylpyrrol-1-yl]-3,5-dihydroxyheptanoic acid');
INSERT INTO drug VALUES ('MO27','Motrin','7GNB','(RS)-2-(4-(2-methylpropyl)phenyl)propanoic acid');
INSERT INTO drug VALUES ('AS15','Aspirin','QZ4W','2-acetoxybenzoic acid');
INSERT INTO drug VALUES ('BE10','Benadryl','MTFS','3-[(4,5-dihydro-1H-imidazol-2-yl)methyl]-6-(1,1-dimethylethyl)-2,4-dimethyl-phenol hydrochloride');
INSERT INTO drug VALUES ('VI49','Visine','QZ4W','3-[(4,5-dihydro-1H-imidazol-2-yl)methyl]-6-(1,1-dimethylethyl)-2,4-dimethyl-phenol hydrochloride');

INSERT INTO pharmacy VALUES ('CAP01','CNC Aurora Pharmacy','626-542-3374','11245 Lower Azusa Rd #B, El Monte, CA 91731');
INSERT INTO pharmacy VALUES ('TOP01','Top Pharmacy', '562-633-1150', '3650 South St # 100, Lakewood, CA 90712');
INSERT INTO pharmacy VALUES ('ARP01','Apple Rx Pharmacy','562-220-2586','17601 Lakewood Blvd, Bellflower, CA 90706');
INSERT INTO pharmacy VALUES ('ZAP01','Zen Apothecary Pharmacy','951-475-7870','420 N Main St STE 105, Corona, CA 92880');
INSERT INTO pharmacy VALUES ('RWP01','Riverwalk Pharmacy','951-352-3030','4234 Riverwalk Pkwy #130, Riverside, CA 92505');
INSERT INTO pharmacy VALUES ('CMP01','California Medical Pharmacy','213-413-2343','2201 W Temple St, Los Angeles, CA 90026');

INSERT INTO contract VALUES ('01X01','CAP01','JII8','2011-09-08','2020-03-17','C:\\Users\\Admin\\OneDrive\\Documents\\CAPContract01','Ranveer Dillard');
INSERT INTO contract VALUES ('01X02','CAP01','QZ4W','2012-07-13','2023-06-06','C:\\Users\\Admin\\OneDrive\\Documents\\CAPContract02','Millie-Rose Cruz');
INSERT INTO contract VALUES ('02X01','TOP01','4KET','2013-09-19','2023-06-06','C:\\Users\\Admin\\OneDrive\\Documents\\TOPContract01','Ewen Montgomery');
INSERT INTO contract VALUES ('02X02','TOP01','WHVS','2011-09-08','2027-12-24','C:\\Users\\Admin\\OneDrive\\Documents\\TOPContract02','Shayan Martins');
INSERT INTO contract VALUES ('03X01','ARP01','QZ4W','2014-07-26','2027-12-24','C:\\Users\\Admin\\OneDrive\\Documents\\ARPContract01','Kyan Nairn');
INSERT INTO contract VALUES ('04X01','ZAP01','9P2X','2016-02-06','2029-02-25','C:\\Users\\Admin\\OneDrive\\Documents\\ZAPContract01','Ceara Rivera');
INSERT INTO contract VALUES ('04X02','ZAP01','7GNB','2018-12-31','2029-02-25','C:\\Users\\Admin\\OneDrive\\Documents\\ZAPContract02','Isma Miranda');
INSERT INTO contract VALUES ('05X01','RWP01','QZ4W','2013-09-19','2026-10-27','C:\\Users\\Admin\\OneDrive\\Documents\\RWPContract01','Georga Hayward');
INSERT INTO contract VALUES ('05X02','RWP01','MTFS','2020-03-17','2030-07-15','C:\\Users\\Admin\\OneDrive\\Documents\\RWPContract02','Samina Lancaster');
INSERT INTO contract VALUES ('06X01','CMP01','4KET','2018-12-31','2029-02-25','C:\\Users\\Admin\\OneDrive\\Documents\\CMPContract01','Victor Rodriquez');
INSERT INTO contract VALUES ('06X02','CMP01','JII8','2020-03-17','2030-07-15','C:\\Users\\Admin\\OneDrive\\Documents\\CMPContract02','Katrina Rush');
INSERT INTO contract VALUES ('06X03','CMP01','WHVS','2012-07-13','2027-12-24','C:\\Users\\Admin\\OneDrive\\Documents\\CMPContract03','Ari Dunlap');
INSERT INTO contract VALUES ('06X04','CMP01','9P2X','2016-02-06','2026-10-27','C:\\Users\\Admin\\OneDrive\\Documents\\CMPContract04','Braxton Summers');

INSERT INTO drug_list VALUES ('00001','VI21','CAP01',34.95);
INSERT INTO drug_list VALUES ('00002','VI49','CAP01',99.95);
INSERT INTO drug_list VALUES ('00003','TY89','TOP01',16.95);
INSERT INTO drug_list VALUES ('00004','CL40','TOP01',4.95);
INSERT INTO drug_list VALUES ('00005','AS15','ARP01',8.95);
INSERT INTO drug_list VALUES ('00006','VI49','ARP01',249.95);
INSERT INTO drug_list VALUES ('00007','LI31','ARP01',16.95);
INSERT INTO drug_list VALUES ('00008','LI31','ZAP01',4.95);
INSERT INTO drug_list VALUES ('00009','MO27','ZAP01',8.95);
INSERT INTO drug_list VALUES ('00010','BE10','ZAP01',249.95);
INSERT INTO drug_list VALUES ('00011','AS15','RWP01',99.95);
INSERT INTO drug_list VALUES ('00012','VI49','RWP01',4.00 );
INSERT INTO drug_list VALUES ('00013','BE10','RWP01',399.95);
INSERT INTO drug_list VALUES ('00014','VI21','CMP01',399.95);
INSERT INTO drug_list VALUES ('00015','TY89','CMP01',24.00 );
INSERT INTO drug_list VALUES ('00016','CL40','CMP01',649.95);
INSERT INTO drug_list VALUES ('00017','LI31','CMP01',34.95);

INSERT INTO prescription VALUES ('RX001','00010','K7HEU','24564','2020-08-18','2020-09-28', 2);
INSERT INTO prescription VALUES ('RX002','00012','3CVEM','24564','2020-05-12','2020-06-19', 10);
INSERT INTO prescription VALUES ('RX003','00002','NVCVY','54598','2020-01-14','2020-02-24', 1);
INSERT INTO prescription VALUES ('RX004','00008','YQQMM','54598','2020-06-14','2020-06-19', 12);
INSERT INTO prescription VALUES ('RX005','00005','463IR','24897','2020-02-20','2020-02-24', 3);
INSERT INTO prescription VALUES ('RX006','00013','45REF','24897','2020-08-12','2020-09-28', 7);
INSERT INTO prescription VALUES ('RX007','00011','K8ZE0','54598','2021-01-12','2021-01-23',4);
INSERT INTO prescription VALUES ('RX008','00004','9W4VS','54984','2021-01-20','2021-01-23',6);
INSERT INTO prescription VALUES ('RX009','00009','Y65F2','54984','2021-01-23','2021-01-23',8);
INSERT INTO prescription VALUES ('RX010','00006','LRXW6','59831','2020-08-30','2020-09-28',7);
INSERT INTO prescription VALUES ('RX011','00001','9HZKF','59831','2020-05-30','2020-06-19',20);
INSERT INTO prescription VALUES ('RX012','00017','9HZKF','59831','2020-01-30','2020-02-24',1);

-- Display patientname, patientid, doctorname, and doctorid where patient age is greater than 30.

SELECT patientname, patientid, doctorname, doctorid
FROM patient, doctor
WHERE patient.primary_physicianid = doctor.doctorid and patient.age > 30;

-- display drugid, tradename, and total sales of presciptions 
SELECT drug.drugid, drug.tradename, sum(Price*Quantity) AS TotalSales
FROM drug INNER JOIN drug_list ON drug.drugid = drug_list.drugid INNER JOIN prescription ON drug_list.productid = prescription.productid
GROUP BY drug.drugid, tradename;

-- Display the tradename from prescriptions that have sold more than 3 (total quantity).
SELECT r.tradename
FROM prescription p, drug_list d, drug r
WHERE d.productid = p.productid
AND r.drugid = d.drugid
GROUP BY r.tradename
HAVING SUM(quantity) > 3;



-- Display pharmacyname, tradename, price, price at a 20% discount from contracts with ‘Pfizer’
SELECT p.pharmacyname, d.tradename, price, round(price * .80, 2) as discounted_price
FROM pharmacy p, drug d, drug_list l, contract c
WHERE p.pharmacyid = c.pharmacyid
AND p.pharmacyid = l.pharmacyid
AND l.drugid = d.drugid
AND c.pharmid in (
SELECT pharmid
FROM pharmaceuticalcompany
WHERE pharmaname = 'Pfizer' )
AND c.pharmid = d.pharmid;

-- Display doctor name that has less than 3 patients
SELECT d.doctorname
FROM doctor d, patient p
WHERE d.doctorid = p.primary_physicianid
GROUP BY d.doctorid
Having COUNT(d.doctorid) < 3;