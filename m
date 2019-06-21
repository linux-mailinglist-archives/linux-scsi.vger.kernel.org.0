Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 893064ED6B
	for <lists+linux-scsi@lfdr.de>; Fri, 21 Jun 2019 18:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfFUQug (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 21 Jun 2019 12:50:36 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:19078 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726017AbfFUQug (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 21 Jun 2019 12:50:36 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LGnLOE007652;
        Fri, 21 Jun 2019 09:50:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=v9I5G0UAyA/4BVKOeRh8Al1PqCyn0xARhttmoaEAjro=;
 b=BTnJHLI2zQWNWKqIyOdFXK/4/zlcMIoZ9wLlELk9iFTHd/ID+6P0K8a3yqO7vaHohimc
 gdKbBeG5tf38lqYpZ5ERYvmcQhxuvvSexX37ldbg/rzDDPEaXlg5NrAYTztbCPL9AuUG
 X5GGwMab/oHSoqXmq48GN4sDFCW10siLqlW9EE7qB/NwFsNIry2YRUyKOe1Ly1sJywON
 2CcRP6Smh0DZWRT9eW52OTPe77Dbbq5gWy6vJI84PKf3bS1TTOqnu6I8tSDyQP98IrWD
 yyCjasZEJRtzkLDSqTZMd5ZEjOpT/UU5bk1Csm/83j2YHNJRkJxLJ5uj+59hrMjWMeEZ QA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2t8vu2hgwv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 21 Jun 2019 09:50:34 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 21 Jun
 2019 09:50:24 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 21 Jun 2019 09:50:24 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 7AEDE3F703F;
        Fri, 21 Jun 2019 09:50:24 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x5LGoOAv023909;
        Fri, 21 Jun 2019 09:50:24 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x5LGoOwd023908;
        Fri, 21 Jun 2019 09:50:24 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH v3 0/3] qla2xxx: Fix crashes with FC-NVMe devices
Date:   Fri, 21 Jun 2019 09:50:21 -0700
Message-ID: <20190621165024.23874-1-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_12:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

This series fixes crash during abort handling with FC-NVMe devices. 
Also, we discovered race condition between nvme command and ls completion
with FC-NVMe devices.

Please apply this series to 5.3/scsi-queue at your earliest convenience.

Thanks,
Himanshu

Changes from v2 -> v3
o Change to single kref_put call.
o Move fcport null check before referencing it.

Changes from v1 -> v2
o Removed now unused qla_is_active_nvme_fcport function.

Arun Easi (1):
  qla2xxx: Fix kernel crash after disconnecting NVMe devices

Quinn Tran (2):
  qla2xxx: on session delete return nvme cmd
  qla2xxx: Fix NVME cmd and LS cmd timeout race condition

 drivers/scsi/qla2xxx/qla_def.h  |   4 +-
 drivers/scsi/qla2xxx/qla_nvme.c | 226 +++++++++++++++++++++++++---------------
 drivers/scsi/qla2xxx/qla_nvme.h |   2 +-
 drivers/scsi/qla2xxx/qla_os.c   |   1 -
 4 files changed, 145 insertions(+), 88 deletions(-)

-- 
2.12.0

