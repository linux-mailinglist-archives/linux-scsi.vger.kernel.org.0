Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1466E125C4
	for <lists+linux-scsi@lfdr.de>; Fri,  3 May 2019 02:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfECAvG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 May 2019 20:51:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726114AbfECAvG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 2 May 2019 20:51:06 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x430lYMS177296
        for <linux-scsi@vger.kernel.org>; Thu, 2 May 2019 20:51:04 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s87ubegpf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Thu, 02 May 2019 20:51:04 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-scsi@vger.kernel.org> from <tyreld@linux.ibm.com>;
        Fri, 3 May 2019 01:51:03 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 May 2019 01:51:02 +0100
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x430p1V536962446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 May 2019 00:51:01 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1880428058;
        Fri,  3 May 2019 00:51:01 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84BBA28059;
        Fri,  3 May 2019 00:51:00 +0000 (GMT)
Received: from ltcalpine2-lp11.aus.stglabs.ibm.com (unknown [9.40.195.194])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  3 May 2019 00:51:00 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, brking@linux.ibm.com,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 1/3] ibmvscsi: Wire up host_reset() in the drivers scsi_host_template
Date:   Thu,  2 May 2019 19:50:56 -0500
X-Mailer: git-send-email 2.18.1
X-TM-AS-GCONF: 00
x-cbid: 19050300-0072-0000-0000-0000042457A1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011038; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01197740; UDB=6.00628232; IPR=6.00978597;
 MB=3.00026706; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-03 00:51:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050300-0073-0000-0000-00004C0DCD88
Message-Id: <20190503005058.8768-1-tyreld@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905030003
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
Changes in v2:
	removed interrupt disabe/enable around reset

 drivers/scsi/ibmvscsi/ibmvscsi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 8cec5230fe31..65fc8ca962c5 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -2050,6 +2050,16 @@ static struct device_attribute ibmvscsi_host_config = {
 	.show = show_host_config,
 };
 
+static int ibmvscsi_host_reset(struct Scsi_Host *shost, int reset_type)
+{
+	struct ibmvscsi_host_data *hostdata = shost_priv(shost);
+
+	dev_info(hostdata->dev, "Initiating adapter reset!\n");
+	ibmvscsi_reset_host(hostdata);
+
+	return 0;
+}
+
 static struct device_attribute *ibmvscsi_attrs[] = {
 	&ibmvscsi_host_vhost_loc,
 	&ibmvscsi_host_vhost_name,
@@ -2076,6 +2086,7 @@ static struct scsi_host_template driver_template = {
 	.eh_host_reset_handler = ibmvscsi_eh_host_reset_handler,
 	.slave_configure = ibmvscsi_slave_configure,
 	.change_queue_depth = ibmvscsi_change_queue_depth,
+	.host_reset = ibmvscsi_host_reset,
 	.cmd_per_lun = IBMVSCSI_CMDS_PER_LUN_DEFAULT,
 	.can_queue = IBMVSCSI_MAX_REQUESTS_DEFAULT,
 	.this_id = -1,
-- 
2.18.1

