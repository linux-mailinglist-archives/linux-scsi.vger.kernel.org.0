Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4646110BF
	for <lists+linux-scsi@lfdr.de>; Thu,  2 May 2019 02:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfEBArj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 1 May 2019 20:47:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbfEBArj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 1 May 2019 20:47:39 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x420kjw7079887
        for <linux-scsi@vger.kernel.org>; Wed, 1 May 2019 20:47:38 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s7gftkjvm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Wed, 01 May 2019 20:47:37 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-scsi@vger.kernel.org> from <tyreld@linux.ibm.com>;
        Thu, 2 May 2019 01:47:36 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 May 2019 01:47:34 +0100
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x420lXlj32571424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 May 2019 00:47:33 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 126112805E;
        Thu,  2 May 2019 00:47:33 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F1FD2805C;
        Thu,  2 May 2019 00:47:32 +0000 (GMT)
Received: from ltcalpine2-lp11.aus.stglabs.ibm.com (unknown [9.40.195.194])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  2 May 2019 00:47:32 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, brking@linux.ibm.com,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 1/3] ibmvscsi: Wire up host_reset() in the drivers scsi_host_template
Date:   Wed,  1 May 2019 19:47:27 -0500
X-Mailer: git-send-email 2.18.1
X-TM-AS-GCONF: 00
x-cbid: 19050200-0072-0000-0000-00000423D54F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011032; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01197265; UDB=6.00627943; IPR=6.00978119;
 MB=3.00026688; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-02 00:47:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050200-0073-0000-0000-00004C0A5048
Message-Id: <20190502004729.19962-1-tyreld@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-01_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905020004
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Wire up the host_reset function in our driver_template to allow a user
requested adpater reset via the host_reset sysfs attribute.

Example:

echo "adapter" > /sys/class/scsi_host/host0/host_reset

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 8cec5230fe31..1c37244f16a0 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -2050,6 +2050,18 @@ static struct device_attribute ibmvscsi_host_config = {
 	.show = show_host_config,
 };
 
+static int ibmvscsi_host_reset(struct Scsi_Host *shost, int reset_type)
+{
+	struct ibmvscsi_host_data *hostdata = shost_priv(shost);
+
+	vio_disable_interrupts(to_vio_dev(hostdata->dev));
+	dev_info(hostdata->dev, "Initiating adapter reset!\n");
+	ibmvscsi_reset_host(hostdata);
+	vio_enable_interrupts(to_vio_dev(hostdata->dev));
+
+	return 0;
+}
+
 static struct device_attribute *ibmvscsi_attrs[] = {
 	&ibmvscsi_host_vhost_loc,
 	&ibmvscsi_host_vhost_name,
@@ -2076,6 +2088,7 @@ static struct scsi_host_template driver_template = {
 	.eh_host_reset_handler = ibmvscsi_eh_host_reset_handler,
 	.slave_configure = ibmvscsi_slave_configure,
 	.change_queue_depth = ibmvscsi_change_queue_depth,
+	.host_reset = ibmvscsi_host_reset,
 	.cmd_per_lun = IBMVSCSI_CMDS_PER_LUN_DEFAULT,
 	.can_queue = IBMVSCSI_MAX_REQUESTS_DEFAULT,
 	.this_id = -1,
-- 
2.18.1

