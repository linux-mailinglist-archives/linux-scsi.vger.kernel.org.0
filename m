Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1592227E03
	for <lists+linux-scsi@lfdr.de>; Thu, 23 May 2019 15:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbfEWNYD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 23 May 2019 09:24:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726310AbfEWNYD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 23 May 2019 09:24:03 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4ND4KNV122679
        for <linux-scsi@vger.kernel.org>; Thu, 23 May 2019 09:24:01 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sntw8cctk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Thu, 23 May 2019 09:24:00 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-scsi@vger.kernel.org> from <maier@linux.ibm.com>;
        Thu, 23 May 2019 14:23:59 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 May 2019 14:23:56 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4NDNtxP32112804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 May 2019 13:23:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 517E252057;
        Thu, 23 May 2019 13:23:55 +0000 (GMT)
Received: from oc4120165700.ibm.com (unknown [9.152.97.204])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 0820A52050;
        Thu, 23 May 2019 13:23:55 +0000 (GMT)
From:   Steffen Maier <maier@linux.ibm.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org,
        Benjamin Block <bblock@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Steffen Maier <maier@linux.ibm.com>
Subject: [PATCH 0/2] zfcp fixes for v5.2-rcX
Date:   Thu, 23 May 2019 15:23:44 +0200
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19052313-0008-0000-0000-000002E9AAEC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052313-0009-0000-0000-0000225669CA
Message-Id: <1558617826-30129-1-git-send-email-maier@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-23_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=759 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905230092
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Martin, James,

here are 2 zfcp bugfixes for v5.2-rcX.
The patches apply to Martin's 5.2/scsi-fixes
and to James' fixes branch.

Steffen Maier (2):
  zfcp: fix missing zfcp_port reference put on -EBUSY from port_remove
  zfcp: fix to prevent port_remove with pure auto scan LUNs (only sdevs)

 drivers/s390/scsi/zfcp_ext.h   |  1 +
 drivers/s390/scsi/zfcp_scsi.c  |  9 ++++++
 drivers/s390/scsi/zfcp_sysfs.c | 55 ++++++++++++++++++++++++++++++----
 drivers/s390/scsi/zfcp_unit.c  |  8 ++++-
 4 files changed, 66 insertions(+), 7 deletions(-)

-- 
2.17.1

