Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF08EEAA17
	for <lists+linux-scsi@lfdr.de>; Thu, 31 Oct 2019 06:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfJaFM3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 31 Oct 2019 01:12:29 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:38896 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfJaFM3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 31 Oct 2019 01:12:29 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  viswas.g@microsemi.com designates 208.19.100.23 as permitted
  sender) identity=mailfrom; client-ip=208.19.100.23;
  receiver=esa4.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="viswas.g@microsemi.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:208.19.100.20 ip4:208.19.100.21 ip4:208.19.100.22
  ip4:208.19.100.23 ip4:208.19.99.221 ip4:208.19.99.222
  ip4:208.19.99.223 ip4:208.19.99.225 -all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.100.23; receiver=esa4.microchip.iphmx.com;
  envelope-from="viswas.g@microsemi.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=viswas.g@microsemi.com; spf=None smtp.helo=postmaster@smtp.microsemi.com; dmarc=fail (p=none dis=none) d=microchip.com
IronPort-SDR: 30ZBpVeDLaYBHvUAtwaBjSAMfOPf7hmav9htfCudGYpDfnxBkWjbprWNooUkY7ycHCsYX47cXI
 73h3i47hWrVJ1InlSlkrKPG9Td3mcT9ZA7qiMWsyvEVuSKyVxyPdMYU76LF/iu+2jB9YqBKhWK
 cc5iuj/NV9/7rOTGBECeUGFAMAfp7qRekO6iuC7ysy8vTiyFIvDnl+Ri7eIIlrgcx1B/FdWovt
 SxfDJSB1fmRs2ZBqnZ8zY6oP3YYcUXGSIcwExWRUasloXvc9xiUCAWaR4J53tEWylnqFj6Ia9T
 RvY=
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; 
   d="scan'208";a="53588655"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.23])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Oct 2019 22:12:27 -0700
Received: from AVMBX1.microsemi.net (10.100.34.31) by AVMBX3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 30 Oct
 2019 22:12:27 -0700
Received: from localhost (10.41.130.49) by avmbx1.microsemi.net (10.100.34.31)
 with Microsoft SMTP Server id 15.1.1847.3 via Frontend Transport; Wed, 30 Oct
 2019 22:12:26 -0700
From:   Deepak Ukey <deepak.ukey@microchip.com>
To:     <linux-scsi@vger.kernel.org>
CC:     <Vasanthalakshmi.Tharmarajan@microchip.com>,
        <Viswas.G@microchip.com>, <deepak.ukey@microchip.com>,
        <jinpu.wang@profitbricks.com>, <martin.petersen@oracle.com>,
        <dpf@google.com>, <jsperbeck@google.com>, <auradkar@google.com>,
        <ianyar@google.com>
Subject: [PATCH 12/12] pm80xx : Modified the logic to collect fatal dump.
Date:   Thu, 31 Oct 2019 10:42:41 +0530
Message-ID: <20191031051241.6762-13-deepak.ukey@microchip.com>
X-Mailer: git-send-email 2.19.0-rc1
In-Reply-To: <20191031051241.6762-1-deepak.ukey@microchip.com>
References: <20191031051241.6762-1-deepak.ukey@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Deepak Ukey <Deepak.Ukey@microchip.com>

Added the correct method to collect the fatal dump.

Signed-off-by: Deepak Ukey <deepak.ukey@microchip.com>
Signed-off-by: Viswas G <Viswas.G@microchip.com>
---
 drivers/scsi/pm8001/pm8001_sas.h |   3 +
 drivers/scsi/pm8001/pm80xx_hwi.c | 247 +++++++++++++++++++++++++++++----------
 2 files changed, 191 insertions(+), 59 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index a55b03bca529..93438c8f67da 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -152,6 +152,8 @@ struct pm8001_ioctl_payload {
 #define MPI_FATAL_EDUMP_TABLE_HANDSHAKE            0x0C     /* FDDHSHK */
 #define MPI_FATAL_EDUMP_TABLE_STATUS               0x10     /* FDDTSTAT */
 #define MPI_FATAL_EDUMP_TABLE_ACCUM_LEN            0x14     /* ACCDDLEN */
+#define MPI_FATAL_EDUMP_TABLE_TOTAL_LEN		   0x18	    /* TOTALLEN */
+#define MPI_FATAL_EDUMP_TABLE_SIGNATURE		   0x1C     /* SIGNITURE */
 #define MPI_FATAL_EDUMP_HANDSHAKE_RDY              0x1
 #define MPI_FATAL_EDUMP_HANDSHAKE_BUSY             0x0
 #define MPI_FATAL_EDUMP_TABLE_STAT_RSVD                 0x0
@@ -507,6 +509,7 @@ struct pm8001_hba_info {
 	u32			forensic_last_offset;
 	u32			fatal_forensic_shift_offset;
 	u32			forensic_fatal_step;
+	u32			forensic_preserved_accumulated_transfer;
 	u32			evtlog_ib_offset;
 	u32			evtlog_ob_offset;
 	void __iomem	*msg_unit_tbl_addr;/*Message Unit Table Addr*/
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 5ca9732f4704..56d99921cbc1 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -76,7 +76,7 @@ void pm80xx_pci_mem_copy(struct pm8001_hba_info  *pm8001_ha, u32 soffset,
 	destination1 = (u32 *)destination;
 
 	for (index = 0; index < dw_count; index += 4, destination1++) {
-		offset = (soffset + index / 4);
+		offset = (soffset + index);
 		if (offset < (64 * 1024)) {
 			value = pm8001_cr32(pm8001_ha, bus_base_number, offset);
 			*destination1 =  cpu_to_le32(value);
@@ -93,9 +93,11 @@ ssize_t pm80xx_get_fatal_dump(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 	void __iomem *fatal_table_address = pm8001_ha->fatal_tbl_addr;
 	u32 accum_len , reg_val, index, *temp;
+	u32 status = 1;
 	unsigned long start;
 	u8 *direct_data;
 	char *fatal_error_data = buf;
+	u32 length_to_read;
 
 	pm8001_ha->forensic_info.data_buf.direct_data = buf;
 	if (pm8001_ha->chip_id == chip_8001) {
@@ -105,16 +107,35 @@ ssize_t pm80xx_get_fatal_dump(struct device *cdev,
 		return (char *)pm8001_ha->forensic_info.data_buf.direct_data -
 			(char *)buf;
 	}
+	/* initialize variables for very first call from host application */
 	if (pm8001_ha->forensic_info.data_buf.direct_offset == 0) {
 		PM8001_IO_DBG(pm8001_ha,
 		pm8001_printk("forensic_info TYPE_NON_FATAL..............\n"));
 		direct_data = (u8 *)fatal_error_data;
 		pm8001_ha->forensic_info.data_type = TYPE_NON_FATAL;
 		pm8001_ha->forensic_info.data_buf.direct_len = SYSFS_OFFSET;
+		pm8001_ha->forensic_info.data_buf.direct_offset = 0;
 		pm8001_ha->forensic_info.data_buf.read_len = 0;
+		pm8001_ha->forensic_preserved_accumulated_transfer = 0;
 
-		pm8001_ha->forensic_info.data_buf.direct_data = direct_data;
+		/* Write signature to fatal dump table */
+		pm8001_mw32(fatal_table_address,
+				MPI_FATAL_EDUMP_TABLE_SIGNATURE, 0x1234abcd);
 
+		pm8001_ha->forensic_info.data_buf.direct_data = direct_data;
+		PM8001_IO_DBG(pm8001_ha,
+			pm8001_printk("ossaHwCB: status1 %d\n", status));
+		PM8001_IO_DBG(pm8001_ha,
+			pm8001_printk("ossaHwCB: read_len 0x%x\n",
+			pm8001_ha->forensic_info.data_buf.read_len));
+		PM8001_IO_DBG(pm8001_ha,
+			pm8001_printk("ossaHwCB: direct_len 0x%x\n",
+			pm8001_ha->forensic_info.data_buf.direct_len));
+		PM8001_IO_DBG(pm8001_ha,
+			pm8001_printk("ossaHwCB: direct_offset 0x%x\n",
+			pm8001_ha->forensic_info.data_buf.direct_offset));
+	}
+	if (pm8001_ha->forensic_info.data_buf.direct_offset == 0) {
 		/* start to get data */
 		/* Program the MEMBASE II Shifting Register with 0x00.*/
 		pm8001_cw32(pm8001_ha, 0, MEMBASE_II_SHIFT_REGISTER,
@@ -127,30 +148,66 @@ ssize_t pm80xx_get_fatal_dump(struct device *cdev,
 	/* Read until accum_len is retrived */
 	accum_len = pm8001_mr32(fatal_table_address,
 				MPI_FATAL_EDUMP_TABLE_ACCUM_LEN);
-	PM8001_IO_DBG(pm8001_ha, pm8001_printk("accum_len 0x%x\n",
-						accum_len));
+	/* Determine length of data between previously stored transfer length
+	 * and current accumulated transfer length
+	 */
+	length_to_read =
+		accum_len - pm8001_ha->forensic_preserved_accumulated_transfer;
+	PM8001_IO_DBG(pm8001_ha,
+		pm8001_printk("get_fatal_spcv: accum_len 0x%x\n", accum_len));
+	PM8001_IO_DBG(pm8001_ha,
+		pm8001_printk("get_fatal_spcv: length_to_read 0x%x\n",
+		length_to_read));
+	PM8001_IO_DBG(pm8001_ha,
+		pm8001_printk("get_fatal_spcv: last_offset 0x%x\n",
+		pm8001_ha->forensic_last_offset));
+	PM8001_IO_DBG(pm8001_ha,
+		pm8001_printk("get_fatal_spcv: read_len 0x%x\n",
+		pm8001_ha->forensic_info.data_buf.read_len));
+	PM8001_IO_DBG(pm8001_ha,
+		pm8001_printk("get_fatal_spcv:: direct_len 0x%x\n",
+		pm8001_ha->forensic_info.data_buf.direct_len));
+	PM8001_IO_DBG(pm8001_ha,
+		pm8001_printk("get_fatal_spcv:: direct_offset 0x%x\n",
+		pm8001_ha->forensic_info.data_buf.direct_offset));
+
+	/* If accumulated length failed to read correctly fail the attempt.*/
 	if (accum_len == 0xFFFFFFFF) {
 		PM8001_IO_DBG(pm8001_ha,
 			pm8001_printk("Possible PCI issue 0x%x not expected\n",
-				accum_len));
-		return -EIO;
+			accum_len));
+		return status;
 	}
-	if (accum_len == 0 || accum_len >= 0x100000) {
+	/* If accumulated length is zero fail the attempt */
+	if (accum_len == 0) {
 		pm8001_ha->forensic_info.data_buf.direct_data +=
 			sprintf(pm8001_ha->forensic_info.data_buf.direct_data,
-				"%08x ", 0xFFFFFFFF);
+			"%08x ", 0xFFFFFFFF);
 		return (char *)pm8001_ha->forensic_info.data_buf.direct_data -
 			(char *)buf;
 	}
+	/* Accumulated length is good so start capturing the first data */
 	temp = (u32 *)pm8001_ha->memoryMap.region[FORENSIC_MEM].virt_ptr;
 	if (pm8001_ha->forensic_fatal_step == 0) {
 moreData:
+		/* If data to read is less than SYSFS_OFFSET then reduce the
+		 * length of dataLen
+		 */
+		if (pm8001_ha->forensic_last_offset + SYSFS_OFFSET
+				> length_to_read) {
+			pm8001_ha->forensic_info.data_buf.direct_len =
+				length_to_read -
+				pm8001_ha->forensic_last_offset;
+		} else {
+			pm8001_ha->forensic_info.data_buf.direct_len =
+				SYSFS_OFFSET;
+		}
 		if (pm8001_ha->forensic_info.data_buf.direct_data) {
 			/* Data is in bar, copy to host memory */
-			pm80xx_pci_mem_copy(pm8001_ha, pm8001_ha->fatal_bar_loc,
-			 pm8001_ha->memoryMap.region[FORENSIC_MEM].virt_ptr,
-				pm8001_ha->forensic_info.data_buf.direct_len ,
-					1);
+			pm80xx_pci_mem_copy(pm8001_ha,
+			pm8001_ha->fatal_bar_loc,
+			pm8001_ha->memoryMap.region[FORENSIC_MEM].virt_ptr,
+			pm8001_ha->forensic_info.data_buf.direct_len, 1);
 		}
 		pm8001_ha->fatal_bar_loc +=
 			pm8001_ha->forensic_info.data_buf.direct_len;
@@ -161,21 +218,28 @@ ssize_t pm80xx_get_fatal_dump(struct device *cdev,
 		pm8001_ha->forensic_info.data_buf.read_len =
 			pm8001_ha->forensic_info.data_buf.direct_len;
 
-		if (pm8001_ha->forensic_last_offset  >= accum_len) {
+		if (pm8001_ha->forensic_last_offset  >= length_to_read) {
 			pm8001_ha->forensic_info.data_buf.direct_data +=
 			sprintf(pm8001_ha->forensic_info.data_buf.direct_data,
 				"%08x ", 3);
-			for (index = 0; index < (SYSFS_OFFSET / 4); index++) {
+			for (index = 0; index <
+				(pm8001_ha->forensic_info.data_buf.direct_len
+				 / 4); index++) {
 				pm8001_ha->forensic_info.data_buf.direct_data +=
-					sprintf(pm8001_ha->
-					 forensic_info.data_buf.direct_data,
-						"%08x ", *(temp + index));
+				sprintf(
+				pm8001_ha->forensic_info.data_buf.direct_data,
+				"%08x ", *(temp + index));
 			}
 
 			pm8001_ha->fatal_bar_loc = 0;
 			pm8001_ha->forensic_fatal_step = 1;
 			pm8001_ha->fatal_forensic_shift_offset = 0;
 			pm8001_ha->forensic_last_offset	= 0;
+			status = 0;
+			PM8001_IO_DBG(pm8001_ha,
+			pm8001_printk("get_fatal_spcv: return1 0x%lx\n",
+			((char *)pm8001_ha->forensic_info.data_buf.direct_data
+			- (char *)buf)));
 			return (char *)pm8001_ha->
 				forensic_info.data_buf.direct_data -
 				(char *)buf;
@@ -185,12 +249,19 @@ ssize_t pm80xx_get_fatal_dump(struct device *cdev,
 				sprintf(pm8001_ha->
 					forensic_info.data_buf.direct_data,
 					"%08x ", 2);
-			for (index = 0; index < (SYSFS_OFFSET / 4); index++) {
-				pm8001_ha->forensic_info.data_buf.direct_data +=
-					sprintf(pm8001_ha->
+			for (index = 0; index <
+				(pm8001_ha->forensic_info.data_buf.direct_len
+				 / 4); index++) {
+				pm8001_ha->forensic_info.data_buf.direct_data
+					+= sprintf(pm8001_ha->
 					forensic_info.data_buf.direct_data,
 					"%08x ", *(temp + index));
 			}
+			status = 0;
+			PM8001_IO_DBG(pm8001_ha,
+			pm8001_printk("get_fatal_spcv: return2 0x%lx\n",
+			((char *)pm8001_ha->forensic_info.data_buf.direct_data
+			- (char *)buf)));
 			return (char *)pm8001_ha->
 				forensic_info.data_buf.direct_data -
 				(char *)buf;
@@ -200,63 +271,121 @@ ssize_t pm80xx_get_fatal_dump(struct device *cdev,
 		pm8001_ha->forensic_info.data_buf.direct_data +=
 			sprintf(pm8001_ha->forensic_info.data_buf.direct_data,
 				"%08x ", 2);
-		for (index = 0; index < 256; index++) {
+		for (index = 0; index <
+			(pm8001_ha->forensic_info.data_buf.direct_len
+			 / 4) ; index++) {
 			pm8001_ha->forensic_info.data_buf.direct_data +=
 				sprintf(pm8001_ha->
-					forensic_info.data_buf.direct_data,
-						"%08x ", *(temp + index));
+				forensic_info.data_buf.direct_data,
+				"%08x ", *(temp + index));
 		}
 		pm8001_ha->fatal_forensic_shift_offset += 0x100;
 		pm8001_cw32(pm8001_ha, 0, MEMBASE_II_SHIFT_REGISTER,
 			pm8001_ha->fatal_forensic_shift_offset);
 		pm8001_ha->fatal_bar_loc = 0;
+		status = 0;
+		PM8001_IO_DBG(pm8001_ha,
+		pm8001_printk("get_fatal_spcv: return3 0x%lx\n",
+		((char *)pm8001_ha->forensic_info.data_buf.direct_data
+		- (char *)buf)));
 		return (char *)pm8001_ha->forensic_info.data_buf.direct_data -
 			(char *)buf;
 	}
 	if (pm8001_ha->forensic_fatal_step == 1) {
-		pm8001_ha->fatal_forensic_shift_offset = 0;
-		/* Read 64K of the debug data. */
-		pm8001_cw32(pm8001_ha, 0, MEMBASE_II_SHIFT_REGISTER,
-			pm8001_ha->fatal_forensic_shift_offset);
-		pm8001_mw32(fatal_table_address,
-			MPI_FATAL_EDUMP_TABLE_HANDSHAKE,
+		/* store previous accumulated length before triggering next
+		 * accumulated length update
+		 */
+		pm8001_ha->forensic_preserved_accumulated_transfer =
+			pm8001_mr32(fatal_table_address,
+			MPI_FATAL_EDUMP_TABLE_ACCUM_LEN);
+
+		/* continue capturing the fatal log until Dump status is 0x3 */
+		if (pm8001_mr32(fatal_table_address,
+			MPI_FATAL_EDUMP_TABLE_STATUS) <
+			MPI_FATAL_EDUMP_TABLE_STAT_NF_SUCCESS_DONE) {
+
+			/* reset fddstat bit by writing to zero*/
+			pm8001_mw32(fatal_table_address,
+					MPI_FATAL_EDUMP_TABLE_STATUS, 0x0);
+
+			/* set dump control value to '1' so that new data will
+			 * be transferred to shared memory
+			 */
+			pm8001_mw32(fatal_table_address,
+				MPI_FATAL_EDUMP_TABLE_HANDSHAKE,
 				MPI_FATAL_EDUMP_HANDSHAKE_RDY);
 
-		/* Poll FDDHSHK  until clear  */
-		start = jiffies + (2 * HZ); /* 2 sec */
+			/*Poll FDDHSHK  until clear */
+			start = jiffies + (2 * HZ); /* 2 sec */
 
-		do {
-			reg_val = pm8001_mr32(fatal_table_address,
+			do {
+				reg_val = pm8001_mr32(fatal_table_address,
 					MPI_FATAL_EDUMP_TABLE_HANDSHAKE);
-		} while ((reg_val) && time_before(jiffies, start));
+			} while ((reg_val) && time_before(jiffies, start));
 
-		if (reg_val != 0) {
-			PM8001_FAIL_DBG(pm8001_ha,
-			pm8001_printk("TIMEOUT:MEMBASE_II_SHIFT_REGISTER"
-			" = 0x%x\n", reg_val));
-			return -EIO;
-		}
-
-		/* Read the next 64K of the debug data. */
-		pm8001_ha->forensic_fatal_step = 0;
-		if (pm8001_mr32(fatal_table_address,
-			MPI_FATAL_EDUMP_TABLE_STATUS) !=
-				MPI_FATAL_EDUMP_TABLE_STAT_NF_SUCCESS_DONE) {
-			pm8001_mw32(fatal_table_address,
-				MPI_FATAL_EDUMP_TABLE_HANDSHAKE, 0);
-			goto moreData;
-		} else {
-			pm8001_ha->forensic_info.data_buf.direct_data +=
-				sprintf(pm8001_ha->
-					forensic_info.data_buf.direct_data,
-						"%08x ", 4);
-			pm8001_ha->forensic_info.data_buf.read_len = 0xFFFFFFFF;
-			pm8001_ha->forensic_info.data_buf.direct_len =  0;
-			pm8001_ha->forensic_info.data_buf.direct_offset = 0;
-			pm8001_ha->forensic_info.data_buf.read_len = 0;
+			if (reg_val != 0) {
+				PM8001_FAIL_DBG(pm8001_ha, pm8001_printk(
+				"TIMEOUT:MPI_FATAL_EDUMP_TABLE_HDSHAKE 0x%x\n",
+				reg_val));
+			       /* Fail the dump if a timeout occurs */
+				pm8001_ha->forensic_info.data_buf.direct_data +=
+				sprintf(
+				pm8001_ha->forensic_info.data_buf.direct_data,
+				"%08x ", 0xFFFFFFFF);
+				return((char *)
+				pm8001_ha->forensic_info.data_buf.direct_data
+				- (char *)buf);
+			}
+			/* Poll status register until set to 2 or
+			 * 3 for up to 2 seconds
+			 */
+			start = jiffies + (2 * HZ); /* 2 sec */
+
+			do {
+				reg_val = pm8001_mr32(fatal_table_address,
+					MPI_FATAL_EDUMP_TABLE_STATUS);
+			} while (((reg_val != 2) || (reg_val != 3)) &&
+					time_before(jiffies, start));
+
+			if (reg_val < 2) {
+				PM8001_FAIL_DBG(pm8001_ha, pm8001_printk(
+				"TIMEOUT:MPI_FATAL_EDUMP_TABLE_STATUS = 0x%x\n",
+				reg_val));
+				/* Fail the dump if a timeout occurs */
+				pm8001_ha->forensic_info.data_buf.direct_data +=
+				sprintf(
+				pm8001_ha->forensic_info.data_buf.direct_data,
+				"%08x ", 0xFFFFFFFF);
+				pm8001_cw32(pm8001_ha, 0,
+					MEMBASE_II_SHIFT_REGISTER,
+					pm8001_ha->fatal_forensic_shift_offset);
+			}
+			/* Read the next block of the debug data.*/
+			length_to_read = pm8001_mr32(fatal_table_address,
+			MPI_FATAL_EDUMP_TABLE_ACCUM_LEN) -
+			pm8001_ha->forensic_preserved_accumulated_transfer;
+			if (length_to_read != 0x0) {
+				pm8001_ha->forensic_fatal_step = 0;
+				goto moreData;
+			} else {
+				pm8001_ha->forensic_info.data_buf.direct_data +=
+				sprintf(
+				pm8001_ha->forensic_info.data_buf.direct_data,
+				"%08x ", 4);
+				pm8001_ha->forensic_info.data_buf.read_len
+								= 0xFFFFFFFF;
+				pm8001_ha->forensic_info.data_buf.direct_len
+								=  0;
+				pm8001_ha->forensic_info.data_buf.direct_offset
+								= 0;
+				pm8001_ha->forensic_info.data_buf.read_len = 0;
+			}
 		}
 	}
-
+	PM8001_IO_DBG(pm8001_ha,
+		pm8001_printk("get_fatal_spcv: return4 0x%lx\n",
+		((char *)pm8001_ha->forensic_info.data_buf.direct_data -
+		 (char *)buf)));
 	return (char *)pm8001_ha->forensic_info.data_buf.direct_data -
 		(char *)buf;
 }
-- 
2.16.3

